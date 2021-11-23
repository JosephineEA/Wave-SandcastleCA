function space = createRain(space,p)

dim = size(space);
%p = height/(20*width);
for x = 2:dim(1)-1
    for y = 2:dim(2)-1
        if rand(1) < p
            space(x,y,dim(3)) = -3;
        end
    end
end
    
end

