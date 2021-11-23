function [xmin,xmax,ymin,ymax,zmin,zmax,x,y,z] = xyzBound(dim,x,y,z)

%求边界条件函数。

xmin = false;
xmax = false;
ymin = false;
ymax = false;
zmin = false;   
zmax = false;      
if x <= 1
    x = 1;
    xmin = true;
elseif x >= dim(1)
    x = dim(1);
    xmax = true;
end
if y <= 1
    y = 1;
    ymin = true;
elseif y >= dim(2)
    y = dim(2);
    ymax = true;
end
if z <= 1
    z = 1;
    zmin = true;
elseif z >= dim(3)
    z = dim(3);
    zmax = true;
end

end