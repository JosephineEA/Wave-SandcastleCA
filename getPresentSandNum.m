function sNum = getPresentSandNum(space,xyz)

%统计当前沙堆结构中沙、沙水元胞数。

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