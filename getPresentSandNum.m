function sNum = getPresentSandNum(space,xyz)

%ͳ�Ƶ�ǰɳ�ѽṹ��ɳ��ɳˮԪ������

sNum = 0;
for sand = xyz
    x = sand(1);
    y = sand(2);
    z = sand(3);
    if space(x,y,z) == 1 || space(x,y,z) == -2
        sNum = sNum+1;
    end
end

end