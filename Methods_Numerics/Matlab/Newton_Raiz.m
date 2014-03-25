clear all;
function [Raiz,Iter,Erro] =Newton_Raiz(funcao,x0,Toler,IterMax);


%parametros de entrada: funcao,x0,Toler,IterMax -> funcao, valor inicial,

%tolerancia e num. max. de iteracoes

%parametros de saida: Raiz,Iter,Erro-> raiz, num. gasto de iteracoes e

%cond. de erro



x = x0;

Fx = eval(funcao);

DFx = eval(diff(funcao));

Iter = 0;

disp('      Iter        x     DFx      Fx        DeltaX');

disp([Iter           x        DFx      Fx     ]);

while (1)

    DeltaX = -Fx/DFx;

    x = x+DeltaX;

    Fx = eval(funcao);

    DFx = eval(diff(funcao));

    Iter = Iter+1;

    disp([Iter     x     DFx      Fx     DeltaX]);      

    if(abs(DeltaX)<Toler && abs(Fx)<Toler)||abs(DFx)==0 || Iter>= IterMax

        break;

    end

    

end

Raiz = x;

if abs(Fx)<Toler

    Erro = 0;

else

    Erro =1;

end

y = [];

for x=0.001:0.001:10

    y = [y,eval(funcao)];

end

x = 0.001:0.001:10;

plot(x,y);



end