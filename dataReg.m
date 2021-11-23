function [b,bints,r,rint,stats] = dataReg()

data = importdata('randomTest1.txt');
C0 = data(:,1);
wwh0 = data(:,3);
cn0 = data(:,5);
ratio0 = data(:,7);
%pr0 = data.data(:,9);
res = data(:,11);
X = [C0,wwh0,cn0,ratio0,ones(length(C0),1)];
[b,bints,r,rint,stats] = regress(res,X);

end