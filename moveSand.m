function space = moveSand(space,C,k0)

%ɳԪ���ƶ�������

[sx,sy,sz] = getCellPos(space,1); 
sands = [sx,sy,sz].';
[wx,wy,wz] = getCellPos(space,-2); 
sdWater = [wx,wy,wz].';
sands = [sands,sdWater];
dim = size(space);

%C = 6;%���ȶ�ϵ��
%k0 = 1/9;%���뺬ˮ��

for sand = sands 
    
    x = sand(1);
    y = sand(2);
    z = sand(3);
    
    %���ɳ���ڵײ������ƶ�
    if z <= 1
        continue;
    end
    
    %����߽�����
   [xmin,xmax,ymin,ymax,zmin,zmax,x,y,z] = xyzBound(dim,x,y,z);
    
    %���ȼ�0�����·�Ϊ�����������·�����
    if space(x,y,z-1) == 0 
        tmp = space(x,y,z);
        space(x,y,z) = space(x,y,z-1);
        space(x,y,z-1) = tmp;
        continue;
    end
    
    unstableJudge = false;
 
    %�账���������������࣬���Ҳ࣬����ǰ����ˮ����ǰ�󣩣������Ϳ����ϣ�³�����ǣ�������ɳˮ�����
    %����ǰ���ȴ�����ǰ�Ӷ���ܿ���ǰ����ǰ
    if xmin
        %������ǰ����ʧ������ȥ�ˣ�
        space(x,y,z) = 0;
        continue;
    elseif xmax || zmax
        %�����������ֱ����Ϊ���ȶ�
        unstableJudge = true;
    end
    
    %{
    ����xmax��zmax�Ľ��ͣ�����ɳ��ֻ�ܱ���ǰ�壨�˷���ǰ�󣩣�
    ��ֻ�迼��ǰ�¿ռ������ɳ�Ӳ�������죩��
    ������ͬʱ����xmin��zmax��ɳ�ӵ������
    �������Ŀ���ǰ�¿ռ������³���ġ�
    %}
    
    if unstableJudge == false
        %�෽������Ϊ�߽�Ԫ����ͬ��һ�ߵ�Ԫ��
        %cube��ά�������ͳһ��̴���
        %�Ѵ���xmin,xmax,zmax,(zmin)������ymin,ymax
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

        %ע���cube�ж���Ҫ�޸ĵ���Ȼ��space
        
        %�������Ȩ
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
        %ˮɳ��ϱ�����
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
        %��ճ��
        f = exp(-abs(cntSdWater/(cntSdWater+cntSand)-k0));
        %�ȶ��ж�
        if waterF/(f*(cntSand+cntSdWater))*C > 1
            unstableJudge = true;
        end
    end
    
    if unstableJudge == true
              
        %��ͬ��ʱ������ѡ���ж�
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
    
        %���ȼ�1��ǰ�·�
        if ~zmin && ~xmin
            if space(x-1,y,z-1) == 0 || space(x-1,y,z-1) == -1
                tmp = space(x,y,z);
                space(x,y,z) = space(x-1,y,z-1);
                space(x-1,y,z-1) = tmp;
                continue;
            end
        end
        %���ȼ�2����ǰ�·�
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
        %���ȼ�3�������·�    
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
        %���ȼ�4����ǰ��    
        if ~xmin
            if space(x-1,y,z) == 0 || space(x-1,y,z) == -1
                tmp = space(x,y,z);
                space(x,y,z) = space(x-1,y,z);
                space(x-1,y,z) = tmp;
                continue
            end
        end
        %���ȼ�5������ǰ��    
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
        %���ȼ�6�����·����²�Ϊ������
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