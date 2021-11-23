function [total,xyz] = getPrimarySandNum(space)

%统计初始沙、沙水元胞数函数。

[sx,sy,sz] = getCellPos(space,1);
[swx,swy,swz] = getCellPos(space,-2);
sands = [sx,sy,sz].';
sdWater = [swx,swy,swz].';
xyz = [sands,sdWater];
dim = size(xyz);
total = dim(2);

end