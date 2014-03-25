function z = reglafalsa(a, b, p)

x=0; 
fprintf('a          c           b   f(a)    f(c)    f(b)\n');
while(x<6)%b-a > 0.0001)

    c = b-((polyval(p,b)*(b-a))/(polyval(p,b)-polyval(p,a)));

    fprintf('%7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f\n', a, c, b, polyval(p,a), polyval(p,c),polyval(p,b));

    if(polyval(p,c) == 0)
        break;

    end;

    if polyval(p,a)*polyval(p,c) < 0 
        b = c;

    else a = c;

    end;
    x=x+1;
    
end;
fprintf('%7.4f es la raiz aproximada del polinomio tras cinco iteraciones',c);