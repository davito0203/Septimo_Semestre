% Fecha: 11 de septiembre de 2011
% Por:  David Martinez
%       Javier Hernndez
% Descripcin: Programa que lleva a cabo la factorizacin tringular para
% resolver un sistema de ecuaciones lineales representado por una matriz
% A (cuadrada) y un vector X entregados por el usuario.
clear;
medidas=[1,2];       %inicializa las medidas de la matriz cuadrada A
medidas2=[500,2];    %inicializa las medidas del vector X
while(medidas(1,1)~=medidas(1,2)) %recibe la matriz estricatamente cuadrada
%A=input('Ingrese la matriz cuadrada A: ');%pide la matriz al usuario
A=[4 -9 2;2 -4 6;1 -1 3]
medidas=size(A);     %verifica las dimensiones de la matriz
end
while(medidas2(1,1)~=medidas(1,1))%recibe el vector de la misma altura de A
%X=input('Ingrese el vector X: '); %recibe el vector del usuario
X=[5;3;4]
medidas2=size(X); %verifica que el vector sea igual de alto a A
end
matriz=[A X];    %forma la matriz aadida
medidas=size(matriz);
for j=1:medidas(1,1); %for para recorrer la diagonal j,j en A
    if(matriz(j,j)==0)%si matriz(j,j)=0 intercambia filas
        for k=j+1:medidas(1,1)%recorre los valores bajo matriz(j,j)
            if(matriz(k,j)~=0)%si encuentra un valor diferente de cero
            aux=matriz(j,1:medidas(j,2));%guarda la fila en vector auxiliar
            matriz(j,1:medidas(j,2))= matriz(k,1:medidas(j,2));
            %copia la fila k en la fila j
            matriz(k,1:medidas(j,2))= aux(1,1:medidas(j,2));
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
    for i=j+1:medidas(1,1) %for para hacer cero los trminos bajo matriz(j,j)
            if(matriz(i,j)~=0)
            multiplicador=matriz(i,j)/matriz(j,j);%conserva en memoria los valores de multiplicador
            %donde i>j
            matriz(i,j:medidas(1,2))=matriz(i,j:medidas(1,2))-(matriz(j,j:medidas(1,2))*multiplicador);
            %resta la fila j multiplicada por el multiplicador de la fila i
            matriz
            matriz(i,j)=multiplicador;%coloca multiplicador en la posicion (i,j)
            matriz
            end
    end
        
end
fprintf('la matriz resultante es: \n');
matriz
L=A; %crea las matrices L y U cuadradas
U=A;
%en los siguientes for se llenan tanto L como U con sus respectivos valores
%de la matriz
for i=1:medidas(1,1)
    for j=1:medidas(1,1)
        if(i<=j)
            U(i,j)=matriz(i,j);
            if(i==j)
                L(i,j)=1;
            else
                L(i,j)=0;
            end
        else
            U(i,j)=0;
            L(i,j)=matriz(i,j);
        end
    end
end
L %muestra la matriz L
U %muestra la matriz U
matriz=[L X]
respuestas=X;
%respuestas(1,1)=X(1,1)/matriz(1,1)

for i=1:medidas(1,1)%recorre la matriz de arriba hacia abajo
    resta=0;        %inicializa resta
    for j=1:i-1
        resta=resta+respuestas(j,1)*matriz(i,j);%hace sumatoria de sustraendos
    end
    respuestas(i,1)=(X(i,1)-resta)/matriz(i,i);
end

X=respuestas;
disp('matriz [UX]');
matriz=[U X]

for i=medidas(1,1):-1:1%recorre la matriz U de abajo hacia arriba
    resta=0;        %inicializa suma
    for j=medidas(1,1):-1:i+1
        resta=resta+(respuestas(j,1)*matriz(i,j));%hace sumatoria de sumandos
    end
    respuestas(i,1)=(X(i,1)-resta)/matriz(i,i);
end
disp('Las soluciones son: ');
for z=1:medidas(1,1)
    fprintf('X%d = %d\n',z,respuestas(z,1));
end