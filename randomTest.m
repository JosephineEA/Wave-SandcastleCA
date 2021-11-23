function randomTest()

long = 20;
width = 20;
height = 20;
ratio = 1/9;
modelType = 4;
r0 = 0;
t0 = 200;
k0 = 1/9;
pr0 = 0;

C = 6;
wWaveHeight = 0.8;
changeNum = 15;

%{
CArray = [4 5 6 7 8 9];
wwhArray = [0.4 0.6 0.8 1 1.2];
chngArray = [9 10 11 12 13 14 15 16 17];
pRainArray = [0.02:0.02:0.2];
%}

while true
    C0 = rand(1);
    wwh0 = rand(1);
    cn0 = rand(1);
    ratio0 = rand(1);
    C0_ = round(C0*5+4);
    wwh0_ = wwh0*0.8+0.4;
    cn0_ = round(cn0*8+9);
    ratio0_ = ratio0;
    pr0_ = rand(1)*0.2;
    [~,r] = createSpace(long, width, height, ratio0_,modelType,r0,t0,C0_,k0,wwh0_,cn0_,pr0);
    fid = fopen('randomTest1.txt','at+');
    strResult = [num2str(C0),'\t\t',num2str(wwh0),'\t\t',num2str(cn0),'\t\t',num2str(ratio0),'\t\t',num2str(pr0),'\t\t',num2str(r)];
    fprintf(fid,[strResult,'\n']);
    fclose(fid);
end

end