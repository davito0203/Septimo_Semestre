%function L=linsht(F1,F2,a,b,alpha,beta,M)
 
% Input   - F1 and F2 are the system of first-order equations
%           representing the I.V.P.'s (9) and (10), respectively;
%           input as strings 'F1', 'F2'
%         - a and b are the points of the interval
%         - alpha = x(a) and beta = x(b); oundary conditions
%         - M is teh number of steps
% Output  - L =[T' X]; where T' is the (M+1)x1 vector of
%           abscissas and X is the (M+1)x1 vector ordinates
% Solve the system F1
F1=input('El sistema 1 de primer orden (U(t)): ','s');
F1=inline(F1)
F2=input('El sistema 2 de primer orden (V(t)): ','s');
F2=inline(F2)
a=input('Ingrese el valor del limite inferior del intervalo: ');
b=input('Ingrese el valor del limite superior del intervalo: ');
alpha=input('Ingrese el valor de alfa = x(a): ');
beta=input('Ingrese el valor de beta = x(b): ');
M=input('Ingrese el numero de pasos que desea calcular: ');
Za=[alpha,0];
h=(b-a)/M;
T=zeros(1,M+1);
Z=zeros(M+1,length(Za));
T=a:h:b;
Z(1,:)=Za;
for j=1:M
    k1=h*feval(F1,T(j),Z(j,:));
    k2=h*feval(F1,T(j)+h/2,Z(j,:)+k1/2);
    k3=h*feval(F1,T(j)+h/2,Z(j,:)+k2/2);
    k4=h*feval(F1,T(j),Z(j,:)+k3);
    Z(j+1,:)=Z(j,:)+(k1+k2+k3+k4)/6;
end
U=Z(:,1);
% Solve the system F2
Za=[0,1];
for j=1:M
    k1=h*feval(F2,T(j),Z(j,:));
    k2=h*feval(F2,T(j)+h/2,Z(j,:)+k1/2);
    k3=h*feval(F2,T(j)+h/2,Z(j,:)+k2/2);
    k4=h*feval(F2,T(j),Z(j,:)+k3);
    Z(j+1,:)=Z(j,:)+(k1+k2+k3+k4)/6;
end
V=Z(:,1);
%Calculate the solution to the boundary value problem
X=U+(beta-U(M+1))*V/V(M+1);
L=[T' X]