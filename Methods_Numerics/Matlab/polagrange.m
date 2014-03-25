% Fecha: 24 de septiembre de 2011
% Por:	 David Martinez
% 	Javier Hernndez
% Descripcin: Programa que construye el polinomio interpolador de Lagrange
% dados dos o mas puntos p=(x,y) representados por el vector X y el vector Y.
clear all;
a=[1 1];%vector tamao de X
while(a(1,2)<2)%debe haber por lo menos dos abcisas x0 y x1
X=input('Ingrese el vector X: ');%pide el vector X
%X=[1 2 3 4 6]
a=size(X);%mide el tamao de X y lo guarda en a
end
b=[1 1];%vector tamao de Y
while(b(1,2)~=a(1,2))%exige que haya el mismo nmero de ordenadas que abcisas
Y=input('Ingrese el vector Y: ');%pide el vector Y
% Y=[120 94 75 62 125]
b=size(Y);%mide el tamao de Y y lo guarda en b
end
% a continuacin se realiza la multiplicacin de los diferentes binomios
% por medio de la orden conv para hallar los polinomios I
I=ones(a(1,2),a(1,2));%crea la matriz donde se guardarn lo polinomios
L=ones(1,a(1,2));%crea el vector donde se guardarn los divisores
P=zeros(1,a(1,2));
for i=1:a(1,2)%recorre el vector X para calcular los Ii
	q=0;%cuenta los espacios dentro de la matriz I
	for j=1:a(1,2)%recorre el vector X para hacer operaciones
		if i~=j%las operaciones solo se hacen si i~=j
			q=q+1;%contador adicional independiente de j
			L(1,i)=L(1,i)*(X(1,i)-X(1,j)); %crea el vector de divisores
			K=[1 -1*X(1,j)];%crea los binomios para multiplicar
			I(i,1:q+1)=conv(I(i,1:q),K);   %multiplica los binomios con I
		end
	end
	I(i,1:a(1,2))=I(i,1:a(1,2)).*(Y(1,i)/L(1,i));  %divide para hallar el polinomio
	P(1,1:a(1,2))=P(1,1:a(1,2))+I(i,1:a(1,2));
end
P(1,1:a(1,2))=P(1,1:a(1,2))/abs(P(1,1))  %divide todo el polinomio P(x)
%para hacer el primer indice +-1
fprintf('El polinomio interpolador de Lagrange para los puntos dados\n');
fprintf('es P(x)= ');
for i=1:a(1,2)
	if i<(a(1,2)-1)
		fprintf('%4.2fX^%d ',P(1,i),a(1,2)-i);
	elseif(i==(a(1,2)-1))
	fprintf('%4.2fX ',P(1,i));
	else
	fprintf('%4.2f =0\n',P(1,i));
	end
	if i<a(1,2)&&P(1,i+1)>0
		fprintf('+ ');
	end
end