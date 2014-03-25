% Fecha: 24 de septiembre de 2011
% Por:  David Martinez
%       Javier Hernandez
% Descripcion: Programa que construye el polinomio interpolador de Lagrange
% dados dos o mas puntos p=(x,y) representados por el vector X y el vector Y.
clear;%borra las variables existentes
format long;
a=[1 1];%vector tamaño de X
while(a(1,2)<2)%debe haber por lo menos dos abcisas x0 y x1
%X=input('Ingrese el vector X: ');%pide el vector X
X=[1 2 3 4]
a=size(X);%mide el tamaño de X y lo guarda en a
end
b=[1 1];%vector tamaño de Y
while(b(1,2)~=a(1,2))%exige que haya el mismo numero de ordenadas que abcisas
%Y=input('Ingrese el vector Y: ');%pide el vector Y
Y=[120 94 75 62]
b=size(Y);%mide el tamaño de Y y lo guarda en b
end
% a continuacion se realiza la multiplicacion de los diferentes binomios
% por medio de la orden conv para hallar los polinomios I
I=ones(a(1,2),a(1,2));%crea la matriz donde se guardaran lo polinomios
L=ones(1,a(1,2));%crea el vector donde se guardaran los divisores
P=zeros(1,a(1,2));
for i=1:a(1,2)%recorre el vector X para calcular los Ii
	q=0;%cuenta los espacios dentro de la matriz I
	for j=1:a(1,2)%recorre el vector X para hacer operaciones
		if i~=j%las operaciones solo se hacen si i diferente de j
			q=q+1;%contador adicional independiente de j
			L(1,i)=L(1,i)*(X(1,i)-X(1,j)); %crea el vector de divisores
			K=[1 -1*X(1,j)];               %crea los binomios para multiplicar
			I(i,1:q+1)=conv(I(i,1:q),K);   %multiplica los binomios con I
		end
	end
	I(i,1:a(1,2))=I(i,1:a(1,2)).*(Y(1,i)/L(1,i));  %divide para hallar el polinomio
	P(1,1:a(1,2))=P(1,1:a(1,2))+I(i,1:a(1,2)); %suma el componente polinomial al total
end
fprintf('El polinomio interpolador de Lagrange para los puntos dados\n');
fprintf('es P(x)= ');
for i=1:a(1,2) %muestra el polinomio de una manera estetica
	if i<(a(1,2)-1)
		fprintf('%4.3fX^%d ',P(1,i),a(1,2)-i);%valores negativos
	elseif(i==(a(1,2)-1))
		fprintf('%4.3fX ',P(1,i));%primer valor no lleva signo
	else
	fprintf('%4.3f =0\n',P(1,i));%ultimo valor e iguala a cero
end
if i<a(1,2)&&P(1,i+1)>0 %introduce el signo +
	fprintf('+ ');
end
end
x=-100.0;%valor asignado a x para que pueda entrar en el ciclo while
while (x<X(1,1)||x>X(a(1,2)))
fprintf('\tintervalo [%4.2f,%4.2f]\n',X(1,1),X(1,a(1,2))); %muestra el intervalo valido para x
x=input('Ahora ingrese un valor de x dentro del intervalo para evaluar la aproximacin polinomial: ');
%pide al usuario un valor de x para hacer la interpolacin
end
fprintf('\n\tEl valor aproximado de f(x) en x=%4.2f es: %4.2f\n',x,polyval(P,x));
%muestra al usuario el resultado de la interpolacin en el punto x