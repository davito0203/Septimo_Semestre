% Fecha: 24 de septiembre de 2011
% Por:  David Martinez
%       Javier Hernandez
% Descripcion: Programa que construye el polinomio de Newton en diferencias
% finitas hacia adelante y pide una abscisa para interpolar el valor de f(x)
% en ese punto, adems que pide el nmero de trminos que se usarn en el 
% polinomio.
% el programa construye por separado la tabla de diferencias finitas y la
% tabla de polinomios de S, calcula el S utilizando el X dado por el
% usuario y el intervalo que selecciono para hacer la aproximacin.
% Luego el programa muestra el polinomio de aproximacin S al usuario y
% finalmente lo evalua con la funcin polyval en el punto deseado.
clear; %borra todas las variables que existan en el espacio de trabajo
a=[1 1];%vector tamaño de X
sep=0;%variable que determina si la separacion entre abscisas es uniforme
while(a(1,2)<2||sep==0)%debe haber por lo menos dos abcisas x0 y x1
sep=1;
X=input('Ingrese el vector X: ');%pide el vector X
%X=[50 60 70 80 90 100]%vector predeterminado para agilizar la ejecucin
H=X(1,2)-X(1,1); %determina la separacion entre abscisas
a=size(X);%mide el tamaño de X y lo guarda en a
for i=1:a(1,2)-1
	if H~=(X(1,i+1)-X(1,i))%determina si la separacion entre abscisas es igual
		sep=0;%pone en cero la variable de control, lo que ocasiona que
		%el vector x tenga que ser introducido de nuevo por estar
		%mal espaciado
		disp('Separacion no uniforme entre abscisas');
		disp('Los valores de X deben estas equiespaciados');
	end
end
end
b=[1 1];%vector tamaño de Y
while(b(1,2)~=a(1,2))%exige que haya el mismo numero de ordenadas que abcisas
Y=input('Ingrese el vector Y: ');%pide el vector Y
%Y=[24.94 30.11 36.05 42.84 50.57 59.30]%vector predeterminado para agilizar la ejecucin
b=size(Y);%mide el tamaño de Y y lo guarda en b
end
I=zeros(a(1,2));%crea la matriz donde se guardaran las diferencias
I(1:a(1,2),1)=Y'%coloca la primera fila de la tabla
%a continuacin se llena la tabla de diferencias finitas
k=0;%contador de regresin para no recorrer las casillas que no se usan
for j=2:a(1,2)%recorre la tabla desde la columna 2
	k=k+1;%incrementa la variable tope vertical
	for i=1:a(1,2)-k %recorre la columna solo hasta la diagonal ascendente
		I(i,j)=I(i+1,j-1)-I(i,j-1);%calcula las diferencias finitas tomando
		%los valores de la izquierda e izquierda
		%baja
	end
end
I    %muestra la matriz de diferencias finitas
terminos=0;
x=input('Ingrese el valor de X para el que quiere interpolar: ');
%x=55 %valor predeterminado para agilizar la ejecucin
for i=1:a(1,2)-1
	fprintf('\n%d: [%4.2f,%4.2f]',i,X(1,i),X(1,i+1));
end
intervalo=input('\nIngrese el numero del intervalo en el que desea interpolar: ');
%intervalo=1 %valor predeterminado para agilizar la ejecucin
S=(x-X(intervalo))/H %calcula el valor de S
%a continuacion generaremos una matriz que contendra los polinomios
%1,S,S(S-1),S(S-1)(S-2), ... que sean necesarios para nuestro caso
ese=zeros(a(1,2),a(1,2)); %crea la matriz para guardar la configuracion 
%de los polinomios S
ese(1,a(1,2))=I(intervalo,1);%genera la constante para multiplicar f(x0)
ese(2,a(1,2)-1)=1;%genera S-0
for i=3:a(1,2) %for para generar los polinomios de S(S-1)(S-2)..........
	ese(i,a(1,2)-(i-1):a(1,2))=conv(ese(i-1,a(1,2)-(i-2):a(1,2)),[1 -(i-2)]);
	ese(i,a(1,2)-(i-1):a(1,2))=ese(i,a(1,2)-(i-1):a(1,2))./factorial(i-1);
	end
orden=-1; %orden asignado para que pueda entrar al while
while orden>=a(1,2)||orden<0
    orden=input('\nIngrese el numero de terminos al que desea truncar el polinomio de S:');
end
ese
result=ese(1:orden+1,1:a(1,2))%guarda en result los polinomios de ese
for i=2:orden
	result(i,1:a(1,2))=result(i,1:a(1,2))*I(intervalo,i);%genera coeficientes
					%para el polinomio de S
end
result
for i=2:orden+1
	result(1,1:a(1,2))=result(1,1:a(1,2))+result(i,1:a(1,2));%suma todos los polinomios S en uno solo
end                                                          %en la fila 1 de result
fprintf('\nel polinomio de Newton en diferencias finitas hacia delante es:\n\nPn=');
for i=1:a(1,2) %for para mostrar esteticamente el polinomio
	if result(1,i)>=0&&i==1
		fprintf(' %4.6f S^%d ',result(1,i),a(1,2)-i);%muestra el mayor coeficiente sin signo
	elseif result(1,i)>=0
		fprintf('+ %4.6f S^%d ',result(1,i),a(1,2)-i);%muestra coeficientes positivos
	else 
	fprintf('- %4.6f S^%d ',abs(result(1,i)),a(1,2)-i);%muestra coeficientes negativos
	end
end
re=polyval(result(1,1:a(1,2)),S);%se calcula el valor del polinomio en funcion de S
		%donde S fue calculado a partir del x y el 
		%periodo que di el usuario
fprintf('\n\n\npara el punto x=%d el polinomio es igual a: %4.6f\n',x,re); %finalmente muestra el resultado
						%de la aproximacin en el punto