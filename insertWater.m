function water = insertWater(space,ratio)

%�������ĺ�ˮ����ɳ���������ɳˮԪ����

if ratio < 1 
    waterNum = round(length(find(space==1))*(1-ratio));
    [sx,sy,sz] = getCellPos(space,1); 
    sand = [sx,sy,sz]; 
    for i = 1:waterNum
        inserted = 0; 
        while inserted == 0
            randIndex = randi(length(sand)); 
            point = sand(randIndex,:); 
            %�����ˮֱ������ɹ�
            if space(point(1),point(2),point(3)) == -2
                continue 
            else
                space(point(1),point(2),point(3)) = -2;
                inserted = 1; 
            end 
        end
    end
end
water = space;
    
end

