% Fecha: 3 de septiembre de 2011
% Por:  David Martinez
%         Javier Hernndez
% Descripcin: Programa que utiliza el mtodo de Biseccin de Bolzano para hallar una raiz
% de una ecuacin proporcionada por el usuario pidiendo el error deseado en la
% aproximacin y el intervalo en el que se buscar la raiz 
clear all
x=0;
iter=0;
a=input('Teclee el valor de a del intervalo [a,b]: ');   %pide el lmite inferior del intervalo
b=input('Teclee el valor de b para el  intervalo [a,b]: '); %pide el lmite superior
Fx=input('Teclee la funcin f(x) a la que desea sacarle las raices: ','s'); %pide que se introdusc la funcion a calcular
er=input('Introdusca el porcentaje de error que permitir:  '); %pide el error en porcentaje
c=(a+b)/2; %calcula la mitad del intervalo
x=c;              %le da a x el valor de la mitad del intervalo
fc=eval(Fx); %calcula la funcin en la mitad del intervalo
x=a;            %le da a x el valor del limite inferior del intervalo
fa=eval(Fx); %calcula la funcin en el lmite inferior del intervalo
x=b;             % le da a x el valor de b
fb=eval(Fx); %calcula la funcin en el lmite superior del intervalo
if (fa*fb>0)  %si no hay cruces en el intervalo, muestra aviso y detiene el programa
	fprintf('\n\nNo existen cruces con el eje x en este intervalo\n\n');
break
end
while (100*( (abs(b-a)   )/a)    >er) %verifica si el error es lo suficientemente pequeo para terminar el programa
%          m=input('Oprima ENTER:  ');

	c=(a+b)/2; %calcula la mitad del nuevo intervalo
	x=a;            %da a x el valor del lmite inferior del intervalo
	fa=eval(Fx); %calcula la funcin en el lmite inferior del intervalo
	x=c;              %le da a x el valor de la mitad del intervalo
	fc=eval(Fx); %calcula la funcin en la mitad del intervalo
	x=b;              %le da a x el valor del lmite superior del intervalo
	fb=eval(Fx); %cacula la funcin en el lmite superior del intervalo
	fprintf('error relativo:  %7.8f %%\n', 100*( (abs(b-a)   )/a));
	fprintf('I= %d, a= %7.6f, c= %7.6f, b= %7.6f, f(a)= %7.6f, f(c)= %7.6f, f(b)= %7.6f\n',iter, a, c, b, fa, fc, fb);% muestra los resultados
	iter=iter+1; % incrementa la cuenta de iteraciones
	if (fc==0)%si la funcin alcance el cero en c, termina el programa 
	break      
	end          
	if (fa*fc<0) %si hay cambio de signo entre a y c, toma este intervalo como [a,b]
		b=c;
	else a=c;    %si no toma el intervalo [c ,b] como nuevo [a,b]
	end;
end;
fprintf('\n\nEl resultado de la aproximacin con un %7.8f por ciento de error es %7.8f\n',er,c);  %muestra el resultado de la aproximacin con el error dado