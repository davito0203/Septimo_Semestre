function v =secante(x0,x1,tol,max)
%f: funcion a calcular la raiz
%x0, x1: puntos iniciales
%tol: tolerancia en error absoluto para la raiz
%max: maximo numero de iteraciones permitidas
fprintf(1, 'Metodo de la secante \n');
f=input('Ingrese el valor de f(x): ','s');
f0=subs(f,x0); 
f1=subs(f,x1);
iter=1;
while(abs(f1)>tol) && (iter<max)
	a = x1-f1*((x1-x0)/(f1-f0));
   f0=f1; f1=subs(f,a);
   fprintf(1, 'iter= %i, a= %x0,f= %e  \n', iter,a ,f1)
	iter = iter + 1;
	x0=x1;	x1=a;
end