function space = moveRain(space) 

%雨水元胞移动函数。

dim = size(space);   
cells = zeros(dim(1)*dim(2)*dim(3),3);
cnt = 0;
%此处不调用getCellPos()是因为函数采取从上往下遍历，雨水元胞应从下往上遍历。
for i = 1:dim(1)
    for j = 1:dim(2)
        for k = 1:dim(3)
            if space(i,j,k) == -3
                cnt = cnt+1;
                cells(cnt,:) = [i,j,k];
            end
        end
    end    
end
cells_ = cells(1:cnt,:);
rx = cells_(:,1);
ry = cells_(:,2);
rz = cells_(:,3); 
rains = [rx,ry,rz].';
for rain = rains 
    x = rain(1);
    y = rain(2);
    z = rain(3);
    %若下方为空，下降
    if space(x,y,z-1) == 0
        space(x,y,z) = 0;
        space(x,y,z-1) = -3;
        continue
    end
    %若下方为沙、沙水元胞，交换位置后变成海浪元胞
    if space(x,y,z-1) == 1 || space(x,y,z-1) == -2
        space(x,y,z) = space(x,y,z-1);
        space(x,y,z-1) = -1;
        continue
    end
    %若下方为海浪元胞，变成海浪元胞
    if space(x,y,z-1) == -1
        space(x,y,z) = -1;
        continue
    end
    
end