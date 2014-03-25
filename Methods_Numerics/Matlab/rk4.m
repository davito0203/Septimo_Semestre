%function rk4(f,a,b,ya,M)
% Input    - f es la funcion como estring 'f'
%          - a y b son los puntos del intervalo
%          - ya es la condicion inicial de y(a)
%          - M es el numero de pasos
% Output   - R=[T' Y']; donde T es el vector de absisas
%            y Y es el vector de ordenadas
clear all;
format long;
f=input('Ingrese la función f(t,y): ','s');
f=inline(f,'t','y')
a=input('Ingrese el valor del limite inferior: ');
b=input('Ingrese el valor del limite superior: ');
ya=input('Ingrese la condición incial y(a): ');
M=input('Ingrese el numero de pasos que desea calcular: ');
h=(b-a)/M;
T=zeros(1,M+1);
Y=zeros(1,M+1);
T=a:h:b;
Y(1)=ya;
for j=1:1:M
    k1=h*feval(f,T(j),Y(j));
    k2=h*feval(f,T(j)+h/2,Y(j)+k1/2);
    k3=h*feval(f,T(j)+h/2,Y(j)+k2/2);
    k4=h*feval(f,T(j)+h,Y(j)+k3);
    Y(j+1)=Y(j)+(k1+2*k2+2*k3+k4)/6;
end
R=[T' Y']