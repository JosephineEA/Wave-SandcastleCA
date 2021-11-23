function space = moveSand(space,C,k0)

%沙元胞移动函数。

[sx,sy,sz] = getCellPos(space,1); 
sands = [sx,sy,sz].';
[wx,wy,wz] = getCellPos(space,-2); 
sdWater = [wx,wy,wz].';
sands = [sands,sdWater];
dim = size(space);

%C = 6;%不稳定系数
%k0 = 1/9;%理想含水量

for sand = sands 
    
    x = sand(1);
    y = sand(2);
    z = sand(3);
    
    %如果沙子在底部，不移动
    if z <= 1
        continue;
    end
    
    %处理边界条件
   [xmin,xmax,ymin,ymax,zmin,zmax,x,y,z] = xyzBound(dim,x,y,z);
    
    %优先级0：正下方为空气，向正下方掉落
    if space(x,y,z-1) == 0 
        tmp = space(x,y,z);
        space(x,y,z) = space(x,y,z-1);
        space(x,y,z-1) = tmp;
        continue;
    end
    
    unstableJudge = false;
 
    %需处理特殊情况：靠左侧，靠右侧，靠最前（以水方向定前后），靠最后和靠最上（鲁棒考虑，保留带沙水情况）
    %靠最前；先处理靠最前从而规避靠左前靠右前
    if xmin
        %若靠最前，消失（流出去了）
        space(x,y,z) = 0;
        continue;
    elseif xmax || zmax
        %若靠最后或最顶，直接认为不稳定
        unstableJudge = true;
    end
    
    %{
    关于xmax和zmax的解释：假设沙子只能被往前冲（浪方向定前后），
    则只需考虑前下空间情况（沙子不会飞上天），
    不存在同时满足xmin和zmax的沙子的情况，
    因而后面的考虑前下空间代码是鲁棒的。
    %}
    
    if unstableJudge == false
        %侧方处理：认为边界元胞等同另一边的元胞
        %cube三维数组便于统一编程处理
        %已处理xmin,xmax,zmax,(zmin)，处理ymin,ymax
        if ymin
            c1 = space(x-1:x+1,y,z-1:z+1);
            c2 = space(x-1:x+1,y+1,z-1:z+1);
            cube = [c2,c1,c2];
        elseif ymax
            c1 = space(x-1:x+1,y,z-1:z+1);
            c2 = space(x-1:x+1,y-1,z-1:z+1);
            cube = [c2,c1,c2];
        else
            cube = space(x-1:x+1,y-1:y+1,z-1:z+1);
        end
        cubeDim = size(cube);

        %注意对cube判定，要修改的仍然是space
        
        %冲击力加权
        waterF = 0;
        if cube(3,2,2) == -1
            waterF = waterF+1;
        end
        if cube(3,2,3) == -1
            waterF = waterF+1/sqrt(2);
        end
        if cube(3,1,2) == -1
            waterF = waterF+1/sqrt(2);
        end
        if cube(3,3,2) == -1
            waterF = waterF+1/sqrt(2);
        end
        if cube(3,2,1) == -1
            waterF = waterF+1/sqrt(2);
        end
        if cube(3,1,3) == -1
            waterF = waterF+1/sqrt(3);
        end
        if cube(3,3,3) == -1
            waterF = waterF+1/sqrt(3);
        end
        %水沙混合比运算
        cntSdWater = 0;
        cntSand = 0;
        for i = 1:cubeDim(1)
            for j = 1:cubeDim(2)
                for k = 1:cubeDim(3)
                    if cube(i,j,k) == -2
                        cntSdWater = cntSdWater+1;
                    elseif cube(i,j,k) == 1 || cube(i,j,k) == 2
                        cntSand = cntSand+1;
                    end
                end
            end
        end
        %求粘力
        f = exp(-abs(cntSdWater/(cntSdWater+cntSand)-k0));
        %稳定判定
        if waterF/(f*(cntSand+cntSdWater))*C > 1
            unstableJudge = true;
        end
    end
    
    if unstableJudge == true
              
        %（同真时）两侧选择判断
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
    
        %优先级1：前下方
        if ~zmin && ~xmin
            if space(x-1,y,z-1) == 0 || space(x-1,y,z-1) == -1
                tmp = space(x,y,z);
                space(x,y,z) = space(x-1,y,z-1);
                space(x-1,y,z-1) = tmp;
                continue;
            end
        end
        %优先级2：侧前下方
        if ~zmin && ~xmin && (y_sub || y_add)
            if y_sub
                if space(x-1,y-1,z-1) == 0 || space(x-1,y-1,z-1) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x-1,y-1,z-1);
                    space(x-1,y-1,z-1) = tmp;
                    continue
                end
            elseif y_add
                if space(x-1,y+1,z-1) == 0 || space(x-1,y+1,z-1) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x-1,y+1,z-1);
                    space(x-1,y+1,z-1) = tmp;
                    continue
                end
            end
        end
        %优先级3：正侧下方    
        if ~zmin && (y_sub || y_add)
            if y_sub
                if space(x,y-1,z-1) == 0 || space(x,y-1,z-1) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x,y-1,z-1);
                    space(x,y-1,z-1) = tmp;
                    continue
                end
            elseif y_add
                if space(x,y+1,z-1) == 0 || space(x,y+1,z-1) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x,y+1,z-1);
                    space(x,y+1,z-1) = tmp;
                    continue
                end
            end
        end
        %优先级4：正前方    
        if ~xmin
            if space(x-1,y,z) == 0 || space(x-1,y,z) == -1
                tmp = space(x,y,z);
                space(x,y,z) = space(x-1,y,z);
                space(x-1,y,z) = tmp;
                continue
            end
        end
        %优先级5：正侧前方    
        if ~xmin && (y_sub || y_add)
            if y_sub
                if space(x-1,y-1,z) == 0 || space(x-1,y-1,z) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x-1,y-1,z);
                    space(x-1,y-1,z) = tmp;
                    continue
                end
            elseif y_add
                if space(x-1,y+1,z) == 0 || space(x-1,y+1,z) == -1
                    tmp = space(x,y,z);
                    space(x,y,z) = space(x-1,y+1,z);
                    space(x-1,y+1,z) = tmp;
                    continue
                end
            end
        end
        %优先级6：正下方（下不为空气）
        if ~zmin
            if space(x,y,z-1) == -1 %|| space(x,y,z-1) == 0
                tmp = space(x,y,z);
                space(x,y,z) = space(x,y,z-1);
                space(x,y,z-1) = tmp;
                continue
            end
        end
        
    end
        
end

end