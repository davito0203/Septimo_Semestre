% Fecha: 3 de septiembre de 2011
% Por:  David Martinez
%            Javier Hernndez
% Descripcin: Programa que utiliza el mtodo de Newton Rapshon para hallar una raiz
% de una ecuacin proporcionada por el usuario pidiendo el error deseado en la
% aproximacin y el intervalo en el que se buscar la raiz 
clear all %Elimina todas las variables almacenadas
format long;
f=input('Teclee el valor de f(x):  ','s');% Recibe el valor de la funcion
xo=input('Ingrese el punto incial de f(x): ');%Valor del puto inicial
iter=input('Ingrese el numero de iteraciones que desea calcular: ' );%Numero de iteraciones a calcular
tol=input('Ingrese el porcentaje de error que permirita:  ');% valor de la torlerancia para calcular el valor
f=inline(f);%F es una funcion
Df=input('Ingrese la derivada de la funcion f(x): ','s');
Df=inline(Df);
disp ("           n          x          err        f(x)")%Salida en la pantalla
for i=1:iter%Inicio de las iteraciones
Fx = eval('f(xo)');
Dfx=eval('Df(xo)');
        x=xo-Fx/Dfx%ecuacion caracteristica
    if (f(xo)==0 | abs(x-xo) < tol)
      disp ("El metodo termino con exito despues de " )
      disp(i);
      disp("iteraciones")
      return;%finaliza el mtodo
    else
      epsilon=abs(x-xo);
      disp ([i-1, xo, epsilon, f(xo)]);%Muestra en pantalla los valores de las vriables
      xo=x;%convierte la nueva x en el punto inicial x0
    end
  end
  disp ("El metodo Fallo despues de " )
  disp(iter)
  disp( "iteraciones")