%function F=findiff(p,q,r,a,b,alpha,beta,N)
% Input  - p,q, and r are the coefficient functions of
%          x''=p(t)x'(t)+q(t)x(t)+r(t) 
%          input as strings; 'p', 'q', 'r'
%        - a and b are the left and right end points
%        - alpha=x(a) and beta=x(b)
%        - N is the number of steps
% Output - F[T' X']: where T' is the 1xN vectir of abscissas }
%          and X' is the 1xN vector of ordinales
clear all;
p=input('Ingrese el coeficiente p(t) de la función: ','s')
p=inline(p)
q=input('Ingrese el coeficiente q(t) de la función: ','s')
q=inline(q)
r=input('Ingrese el coeficiente r(t) de la función: ','s')
r=inline(r)
a=0;
b=4;
alpha=1.25;
beta=-0.95;
N=20;
%a=input('Ingrese el valor del limite inferior del intervalo: ')
%b=input('Ingrese el valor del limite superior del intervalo: ')
%alpha=input('Ingrese el valor de Alfa: ')
%beta=input('Ingrese el valor de Beta: ')
%N=input('Ingrese el número de intervalos: ')
%Initialize vector and h
T=zeros(1,N+1);
X=zeros(1,N-1);
Va=zeros(1,N-2);
Vb=zeros(1,N-1);
Vc=zeros(1,N-2);
Vd=zeros(1,N-1);
h=(b-a)/N;
%Calculate the constant vector B in AX=B
Vt=a+h:h:a+h*(N-1);
Vb=-(h^2)*feval(r,Vt);
Vb(1)=Vb(1)+(1+h/2*feval(p,Vt(1)))*alpha;
Vb(N-1)=Vb(N-1)+(1-h/2*feval(p,Vt(N-1)))*beta;
%Calculate the main diagonal of A in AX=B
Vd=2+h^2*feval(q,Vt);
%Calculate the superdiagonal of A in AX=B
Vta=Vt(1,2:N-1);
Va=-1-h/2*feval(p,Vta);
%Calculate the subdiagonal of A in AX=B
Vtc=Vt(1,1:N-2);
Vc=-1+h/2*feval(p,Vtc);
%Solve AX=B
N1=length(Vb);
for k=2:N1
    mult=Va(k-1)/Vd(k-1);
    Vd(k)=Vd(k)-mult*Vc(k-1);
    Vb(k)=Vb(k)-mult*Vb(k-1);
end
X(N1)=Vb(N1)/Vd(N1);
for k=N1-1:-1:1
    X(k)=(Vb(k)-Vc(k)*X(k+1))/Vd(k);
end
%end Solve AX=B
T=[a,Vt,b];
X=[alpha,X,beta];
F=[T' X']