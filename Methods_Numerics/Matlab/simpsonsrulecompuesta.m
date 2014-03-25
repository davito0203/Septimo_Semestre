%function S=simpson(f,a,b,m)
% Datos de entrada
% - f es el integrando, dado como una cadena de caracteres 'f'
% - a y b son los extremos inferior y superior del intervalo de
% integracion
% - 2*m es el numero de subintervalos
% Datos de salida
% - S es la aproximacion obtenida con la regla compuesta de Simpson
clear all;
format long
f=input('ingrese el valor de la función: ','s');
f=inline(f)
a=input('Ingrese el limite inferior: ');
b=input('Ingrese el limite superior: ');
m=input('Ingrese el numero de subintervalos que desea: ');
if a==b
    suma=0;
    return
end
h=(b-a)/(2*m);
% nodos impares
ximp=a+h*[1:2:2*m-1];
% valores de f en los nodos impares
for i=1:length(ximp)
    fimp(i)=feval(f,ximp(i));
end
%nodos pares
xpar=a+h*[2:2:2*m-2];
% valores de f en los nodos pares
for i=1:length(xpar)
    fpar(i)=feval(f,xpar(i));
end
% valor aproximado de la integral mediante Simpson
suma=h*(feval(f,a)+feval(f,b)+4*sum(fimp)+2*sum(fpar))/3;
disp('El valor aproximado de la integral mediante Simpson es: ')
disp(suma)