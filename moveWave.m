function space = moveWave(space) 

%ˮԪ���ƶ���������

[wx,wy,wz] = getCellPos(space,-1);
sea = [wx,wy,wz].';
dim = size(space);
for wave = sea 
    
    x = wave(1);
    y = wave(2);
    z = wave(3);
    
    [xmin,~,ymin,ymax,zmin,~,x,y,z] = xyzBound(dim,x,y,z);
    
    %������ǰ����ɿ���������ȥ�ˣ�
    %��Ϊģ�⡰��ϫ����ȥ����δ��룬�Բ���ˮλ������Ч��
    
    if xmin
        space(x,y,z) = 0;
        continue
    end
 

    %�߽��ж�
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
    
    %���ȼ�0��ˮ�·�Ϊ����
    if ~zmin
        %0.1�����·��գ�����ǰ�·�
        if space(x,y,z-1) == 0
            if ~xmin
                if space(x-1,y,z-1) == 0
                    space(x-1,y,z-1) = -1;
                    space(x,y,z) = 0;
                    continue
                end
            end
            %0.2�����в��·�  
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
        %0.3��������·�
        space(x,y,z-1) = -1;
        space(x,y,z) = 0;
        continue;     
        end
    end
    %���ȼ�1����ǰ��
    if ~xmin
        if space(x-1,y,z) == 0
            space(x-1,y,z) = -1;
            space(x,y,z) = 0;
            continue
        end
    end
    %���ȼ�2����ǰ��
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
    %���ȼ�3�����෽
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