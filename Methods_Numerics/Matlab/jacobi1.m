% Fecha: 11 de septiembre de 2011
% Por:	David Martinez
%	Javier Hernndez
% Descripcion: Programa que lleva a cabo la solucion para un sistema
% de lineal de N variables, ingresando los coeficientes de dicho sistema lineal
% en la variable A, en la variable B el vector independiente, P el vector de puntos
% iniciales, error con respecto a los valores obtenidos almacenado en la variable delta
% y el numero maximo de iteraciones almacenados en max
%function X=jacobi1(A,B,P,delta, max)
% Input
%	- A es una matriz de N x N
%	- B es una matriz de 1 x N
%	- P es una matriz de 1 x N; puntos iniciales
%	- delta es la tolerancia para P
%	- max1 numero maximo de iteraciones	
	%format long;
%A=input('Ingrese la matriz A ')%Pide los valores de la matiz A
A=[4 -1 1; 4 -8 1; -2 1 5]
if (size(A)(1,1)==size(A)(1,2))%valida el tamaño para que sea una matriz cuadrada
	A=A;
else
	disp('La matriz A no es cuadrada')%visualizacion en la pantalla
	break,%detiene el programa
end
%B=input('Ingrese la matriz B, como un vector de 1xN ')%Pide los valores de la matiz B
B=[7 -21 15]
if(size(A)(1,2)==size(B)(1,2))%valida el tamaño para que tenga las mismas dimensiones ya sea fila o columna de la matriz A
	B=B;
else
	disp('El vector B no corresponde a la matriz A por dimensiones')%visualizacion en la pantalla
	break,%detiene el programa
end
%P=input('Ingrese el punto inicial como vector de 1xN')%Pide los valores de la matiz P
P=[2 4 3]
if(size(B)(1,2)==size(P)(1,2))%valida el tamaño para que tenga las mismas dimensiones del vector B con respecto al vector P
	P=P;
else
	disp('El vector B no corresponde a la matriz A por dimensiones')%Visualizacion en la pantalla
	break,%detiene el programa
end
%delta=input('Ingrese el error permitido ')%Pide el valor del error maximo soportado
delta=0.000001
%max1=input('Ingrese el maximo de itereaciones ')%Numero maximo de iteraciones que se creen necesarias para terminar el metodo
max1=100
	B=B';%Transpone el vector B para que al utilizarlo en el for anidado no se tengo que tomar encuenta la posicion en las filas
	P=P';%Transpone el vector P para que al utilizarlo en el for anidado no se tengo que tomar encuenta la posicion en las filas
	N = length(B);%Longitud del vector B
	k=0;%inicia la variable en 0
	disp ("           k          Pa          Pb        Pc        error        ")%Salida en la pantalla de los que se va a calcular
	disp([k, P', 0])%Visualizacion en la pantalla
	for k=1:max1%Incio recorrido de las filas
		   for j=1:N%Inicio recorrido de las columnas
		   	X(j)=(B(j)-A(j,[1:j-1,j+1:N])*P([1:j-1,j+1:N]))/A(j,j);%ecuacion caracteristica del Jacobiano
		   end
		   err=abs(norm(X' - P));%error
		   relerr=err/(norm(X)+eps);%error absoluto
		   P=X';%Transponer el vector X
		   if (err<delta)|(relerr<delta)%condiconal del error con respecto al delta
		   	break%Se detiene si tiene el error es menor a delta
		   end
		   disp([k, X, relerr])%visualizacion para el termino k-1
	end
	disp([k, X, relerr])%visualicion del termino k-esimo
	fprintf('El metodo termino con exito a la iteracion numero  %d \n', k);
	disp('El punto final es: ')%salida en la pantalla
	disp(X)%Muestra el vector solucion