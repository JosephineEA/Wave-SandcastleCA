function [x,y,z] = getCellPos(space,type)
    dim = size(space);   
    cells = zeros(dim(1)*dim(2)*dim(3),3);
    cnt = 0;
    for i = 1:dim(1)
        for j = 1:dim(2)
            k = dim(3);
            while k > 0
                if space(i,j,k) == type
                    cnt = cnt+1;
                    cells(cnt,:) = [i,j,k];
                end
                k = k-1;
            end
        end    
    end
    cells_ = cells(1:cnt,:);
    x = cells_(:,1);
    y = cells_(:,2);
    z = cells_(:,3); 
end