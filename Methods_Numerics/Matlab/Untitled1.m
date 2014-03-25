%Hecho en Matlab
% Fecha: 23 de Noviembre de 2011
% Por:  David Martínez
%       Javier Hernández
% Descripción: Programa que construye el polinomio de grado 1 que mejor se 
% ajusta en el sentido de los mínimos cuadrados a las parejas de datos
% dadas por el usuario.
clear all;
format long;
%x=[input('Ingrese el vector de la variable independiente: ')];%recibe el vector del usuario
x=[0 2 3 5];
m1=size(x);     %verifica las dimensiones de la matriz
%y=input('Ingrese el vector de la variable dependiente: '); %recibe el vector del usuario
y=[-1 0 2 1];
m2=size(y); %verifica que el vector sea igual de alto a A
%valor=input('Ingrese el valor al que quiere que se vea distante de la recta');
valor=0.5;
disp('     x     y    x^2   xy');%Salida en la pantalla
x2=x.^2';%Eleva cada termino a la segunda potencia el vector x
xy=(x.*y)';%multiplica el vector x con el vector y punto a punto
disp([x' y' x2 xy]);%muestra los valores en la pantalla
sum1=sum(x);%sumatoria del vector x
sum2=sum(y);%sumatoria del vector y
sum3=sum(x2);%sumatoria del vector x2
sum4=sum(xy);%sumatoria del vector xy
disp('__________________________')
disp([sum1 sum2 sum3 sum4]);
%delta=input('Ingrese el valor de muestreo de la recta de regresión');
delta=1/1000;
A=[sum3 sum1; sum1 length(x)];%matriz que es ingresada a la solucion
X=[sum4; sum2];%vector resultado
matriz=[A X];    %forma la matriz añadida
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
    %divide toda la fila j por el término matriz(j,j) para que matriz(j,j)=1
    for i=j+1:medidas(1,1) %for para hacer cero los términos bajo matriz(j,j)
            if(matriz(i,j)~=0)
            multiplicador=matriz(i,j)/matriz(j,j);%conserva en memoria los valores de multiplicador
            %donde i>j
            matriz(i,j:medidas(1,2))=matriz(i,j:medidas(1,2))-(matriz(j,j:medidas(1,2))*multiplicador);
            %resta la fila j multiplicada por el multiplicador de la fila i
            matriz(i,j)=multiplicador;%coloca multiplicador en la posicion (i,j)
            end
    end
end
%fprintf('la matriz resultante es: \n');
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
L; %muestra la matriz L
U; %muestra la matriz U
matriz=[L X];
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
%disp('matriz [UX]');
matriz=[U X];
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
fprintf('El polinomio que mejor se ajusta en mínimos cuadrados es:\n y = \n');
for z=1:medidas(1,1)%muestra la ecuación que mejor se ajusta a los minimos cuadrados
    if(1+1-z>0)
        fprintf('(%d) X^%d + ',respuestas(z,1),1+1-z);
    else
        fprintf('(%d) X^%d \n',respuestas(z,1),1+1-z);
    end
end
suma=0;
for q=1:length(x)%sumatora para calcular el error cuadratico emdio
    suma1 = abs(respuestas(1)*x(q)+respuestas(2)-y(q))^2;
    suma = suma+suma1;
end
ecm=sqrt(1/length(x)*suma);%valor del error cuadratico medio
disp('El error cuadratico medio es: ')
disp(ecm)
x3=min(x):delta:max(x);
l=respuestas(1,1)*x3+respuestas(2,1);%ecuación para calcular error cuadratico medio
n=length(x3);
n1=min(x):delta:(n-1)*delta;
plot(x,y,'r.')
hold
plot(n1,l)
title('Gráfica de regresión')
xlabel('Valores independientes')
ylabel('Valores dependientes')
axis([min(x)-valor max(x)+valor min(y)-valor max(y)+valor])
%grid