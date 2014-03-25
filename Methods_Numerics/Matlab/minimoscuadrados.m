function minimoscuadrados(x,y)% Fecha: 23 de Noviembre de 2011
% Por:  David Martínez
%       Javier Hernández
%clear;
%m1=[1,2];       %inicializa las medidas de la matriz cuadrada A
%m2=[500,2];    %inicializa las medidas del vector X
%while(m1(1,1)~=m1(1,2))
%x=input('Ingrese el vector de la variable independiente: ');%recibe el vector del usuario
%x=[0 2 3 5];
%m1=size(x);     %verifica las dimensiones de la matriz
%end
%while(m2(1,1)~=m1(1,1))
%y=input('Ingrese el vector de la variable dependiente: '); %recibe el vector del usuario
%y=[-1 0 2 1];
%m2=size(y); %verifica que el vector sea igual de alto a A
%end
%valor=input('Ingrese el valor al que quiere que se vea distante de la recta');
%valor=0.5;
fprintf('x    y    x^2   xy');

x2=x.^2;
xy=x.*y;
sum1=sum(x);
sum2=sum(y);
sum3=sum(x2);
sum4=sum(xy);
disp([x y x2 xy])
%x3=min(x):1/1000:max(x);
%n=length(x3);
%n1=0:1/1000:(n-1)/1000;
%l=0.4615*x3-0.6538;
%plot(n1,l)
%hold
plot(x,y,'r.')
title('Gráfica de regresión')
xlabel('Valores independientes')
ylabel('Valores dependientes')
%axis([min(x)-valor max(x)+valor min(y)-valor max(y)+valor])
grid