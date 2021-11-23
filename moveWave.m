function space = moveWave(space) 

%水元胞移动规则函数。

[wx,wy,wz] = getCellPos(space,-1);
sea = [wx,wy,wz].';
dim = size(space);
for wave = sea 
    
    x = wave(1);
    y = wave(2);
    z = wave(3);
    
    [xmin,~,ymin,ymax,zmin,~,x,y,z] = xyzBound(dim,x,y,z);
    
    %到达最前方变成空气（流出去了）
    %若为模拟“潮汐”，去掉这段代码，以产生水位上升的效果
    
    if xmin
        space(x,y,z) = 0;
        continue
    end
 

    %边界判断
    y_sub = false;
    y_add = false;
    if ~ymin
        y_sub = true;
    end
    if ~ymax
        y_add = true;
    end
    if y_sub && y_add
         rnd = randi([1,2]);
        if rnd == 1
            y_add = false;
        elseif rnd == 2
            y_sub = false;
        end
    end
    
    %优先级0：水下方为空气
    if ~zmin
        %0.1：若下方空，先判前下方
        if space(x,y,z-1) == 0
            if ~xmin
                if space(x-1,y,z-1) == 0
                    space(x-1,y,z-1) = -1;
                    space(x,y,z) = 0;
                    continue
                end
            end
            %0.2：再判侧下方  
             if ~xmin && (y_sub || y_add)
                 if y_sub
                     if space(x-1,y-1,z-1) == 0
                        space(x-1,y-1,z-1) = -1;
                        space(x,y,z) = 0;
                        continue
                     end
                 elseif y_add
                     if space(x-1,y+1,z-1) == 0
                         space(x-1,y+1,z-1) = -1;
                         space(x,y,z) = 0;
                         continue
                     end
                 end
             end
        %0.3：最后正下方
        space(x,y,z-1) = -1;
        space(x,y,z) = 0;
        continue;     
        end
    end
    %优先级1：正前方
    if ~xmin
        if space(x-1,y,z) == 0
            space(x-1,y,z) = -1;
            space(x,y,z) = 0;
            continue
        end
    end
    %优先级2：侧前方
    if ~xmin && (y_sub || y_add)
        if y_sub
            if space(x-1,y-1,z) == 0
                space(x-1,y-1,z) = -1;
                space(x,y,z) = 0;
                continue
            end
        elseif y_add
            if space(x-1,y+1,z) == 0
                space(x-1,y+1,z) = -1;
                space(x,y,z) = 0;
                continue
            end
        end
    end
    %优先级3：正侧方
    if y_sub || y_add
        if y_sub
            if space(x,y-1,z) == 0
                space(x,y-1,z) = -1;
                space(x,y,z) = 0;
                continue
            end
        elseif y_add
            if space(x,y+1,z) == 0
                space(x,y+1,z) = -1;
                space(x,y,z) = 0;
                continue
            end
        end
    end
end
    
end