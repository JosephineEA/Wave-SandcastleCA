function equation = getPlane(A,B,C)

syms x y jz 
D=[ones(4,1),[[x,y,jz];A;B;C]];
detd=det(D);
z = solve(detd,jz);
equation = z; 
    
end
