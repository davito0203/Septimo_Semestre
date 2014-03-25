%function T=trapecio(f,a,b,n)
% Datos de entrada
% - f es el integrando, dado como una cadena de caracteres 'f'
% - a y b son los extremos inferior y superior del intervalo de
% integracion
% - n es el numero de subintervalos
% Datos de salida
% - T es la aproximacion obtenida con la regla compuesta del trapecio
clear all;
format long
f=input('ingrese el valor de la función: ','s');
f=inline(f)
a=input('Ingrese el limite inferior: ');
b=input('Ingrese el limite superior: ');
n=input('Ingrese el numero de subintervalos que desea: ');
if a==b
    T=0;
    return
end
h=(b-a)/n;
% nodos interiores
xint=a+h*[1:n-1];
% valores de f en los nodos interiores
for i=1:length(xint)
    fint(i)=feval(f,xint(i));
end
% valor aproximado de la integral mediante el metodo del trapecio
T=h*(feval(f,a)+feval(f,b)+2*sum(fint))/2;
disp('El valor aproximado de la integral mediante Trapecio es: ')
disp(T)