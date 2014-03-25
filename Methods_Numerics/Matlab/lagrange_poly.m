function lp = lagrange_poly (xi, i)
%%%Argumentos:
% xi vector que contiene los puntos de interpolación
% i indice asociado al punto de interpolación.
n=length(xi);
temp=[1];
denom=1;
if((i<1)||(i>n))
    disp('lagrange_poly error: index i out of bounds')
    return
elseif(i==1)
    for j=2:n
        temp=conv(temp,[1-xi(j)]);
        denom=denom*(xi(1)-xi(j));
    end
elseif (i==n)
    for j=1:n-1
        temp=conv(temp,[1-xi(j)]);
        denom=denom*(xi(n -xi(j)));
    end
else
    for j=1:i-1
        temp=conv(temp,[1-xi(j)]);
        denom=denom*(xi(i)-xi(j));
    end
    for j=i+1:n
        temp=conv(temp,[1-xi(j)]);
        denom=denom*(xi(i)-xi(j));
    end
end
if (nargout==0)
    disp(temp/denom)
else
    lp=temp/denom;
end