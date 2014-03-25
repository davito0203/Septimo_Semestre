% Fecha: 11 de septiembre de 2011
% Por:  David Martinez
%       Javier Hernndez
% Descripcin: Programa que usa el mtodo iterativo de Jacobi para solucionar
% un sistema de n ecuaciones con n incgnitas introducido por el usuario,
% el programa permite fijar el nmero de iteraciones deseadas.
clear;
medidas=[1,2];       %inicializa las medidas de la matriz cuadrada A
medidas2=[500,2];    %inicializa las medidas del vector X
medidas3=[500,2];    %inicializa las medidas del vector B
disp('\tPrograma para resolver A.X=B por iteraciones');
while(medidas(1,1)~=medidas(1,2)) %recibe la matriz estricatamente cuadrada
A=input('Ingrese la matriz cuadrada A: ');%pide la matriz al usuario
%A=[4 .5 1;1 -10 1;-1 1 5]
%A=[6 -2 -4 4;3 -3 -6 1;-12 8 21 -8;-6 0 -10 7]
medidas=size(A);     %verifica las dimensiones de la matriz
end
while(medidas3(1,1)~=medidas(1,1))%recibe el vector de la misma altura de A
B=input('Ingrese el vector B de constantes: '); %recibe el vector del usuario
%B=[8;-6;10]
%B=[2;-4;8;-43]
medidas3=size(B); %verifica que el vector sea igual de alto a A
end
while(medidas2(1,1)~=medidas(1,1))%recibe el vector de la misma altura de A
X=input('Ingrese el vector X de posibles respuestas: '); %recibe el vector 
%del usuario
%X=[5;5;5;5]
medidas2=size(X); %verifica que el vector sea igual de alto a A
end
it=input('Ingrese el nmero de iteraciones que desea hacer: ');
err=input('Ingrese el porcentaje de error que admitir: ');
err=err/100;
matriz=[A B];
medidas=size(matriz);
fprintf('valores de X iniciales:');
for d=1:medidas(1,1)
	fprintf('\tX%d = %d',d,X(d,1));
end
verif=0;
for j=1:medidas(1,1); %for para recorrer la diagonal j,j en A
	verif=0;
	if(matriz(j,j)==0)%si matriz(j,j)=0 intercambia filas
	for k=j+1:medidas(1,1)%recorre los valores bajo matriz(j,j)
		if(matriz(k,j)~=0&&verif==0)%si encuentra un valor diferente de cero
		verif=1;
		aux=matriz(j,1:medidas(j,2));%guarda la fila en vector auxiliar
		matriz(j,1:medidas(j,2))= matriz(k,1:medidas(j,2));
		%copia la fila k en la fila j
		matriz(k,1:medidas(j,2))= aux(1,1:medidas(j,2))
		%copia lo que habia en la fila j a la fila k
	end
	end
end
if (matriz(j,j)==0)%si despues de intentar el cambio de fila matriz(j,j)
	%sigue siendo 0
	fprintf('\n\n\tLa matriz A es singular y el sistema tiene 0 o infinitas soluciones!!!');
	%muestra mensaje de que la matriz es singular
	break;%termina el programa
	return
end
%matriz(j,j:medidas(1,2))=matriz(j,j:medidas(1,2))/matriz(j,j);
%divide toda la fila j por el trmino matriz(j,j) para que matriz(j,j)=1
end
B=matriz(1:medidas(1,1),medidas(1,2));
error=2*err;
iteracion=0;
X2=0*X;
salir=0;
while iteracion<it&&salir==0
	iteracion=iteracion+1;
	for i=1:medidas(1,1)%recorre la matriz de arriba hacia abajo
		resta=0;        %inicializa resta
		for j=1:medidas(1,1)%for para recorrer la fila de izquierda a derecha
			if(i~=j)    %si el elemento no esta en la diagonal
			resta=resta+(matriz(i,j)*X(j,1));%hace sumatoria de sustraendos
		end
	end
	X(i,1)=(B(i,1)-resta)/matriz(i,i);%guarda los valores nuevos de X
end
fprintf('\nIteracion %d \n\t%d',iteracion);
for d=1:medidas(1,1)
	fprintf('\tX%d=%d',d,X(d,1));
	end
salir=1;
for als=1:medidas(1,1)
	error=abs((X(als,1)-X2(als,1))/X(als,1));
	if error>err %si alguno de los valores tiene error mayor, el ciclo continua
		salir=0;
	end
end
if salir==1
	fprintf('\nnivel de error satisfecho en la iteracion %d !!!\n',iteracion);
end
X2=X;
end