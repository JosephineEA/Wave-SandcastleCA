function space = changeSandyWater(space,changeNum)

%ɳˮԪ����ɺ���Ԫ�����ж�������

[wx,wy,wz] = getCellPos(space,-2); 
sdWater = [wx,wy,wz].';
dim = size(space);

for water = sdWater
    x = water(1);
    y = water(2);
    z = water(3);
    [xmin,xmax,ymin,ymax,zmin,zmax,x,y,z] = xyzBound(dim,x,y,z);
    if xmin
        xLow = x;
    else
        xLow = x-1;
    end
    if xmax
        xUp = x;
    else
        xUp = x+1;
    end
    if ymin
        yLow = y;
    else
        yLow = y-1;
    end
    if ymax
        yUp = y;
    else
        yUp = y+1;
    end
    if zmin
        zLow = z;
    else
        zLow = z-1;
    end
    if zmax
        zUp = z;
    else
        zUp = z+1;
    end
    cntWater = 0;
    for i = xLow:xUp
        for j = yLow:yUp
            for k = zLow:zUp
                if space(i,j,k) == -1
                    cntWater = cntWater+1;
                end
            end
        end
    end
    %��ɳˮԪ����Χ�����ɸ�����Ԫ�������ɺ���Ԫ����
    if cntWater > changeNum
        space(x,y,z) = -1;
    end
end

end