function begin()

long = 20;
width = 20;
height = 20;
ratio = 1/9;
modelType = 4;
r0 = 0.6;
t0 = 500;
C = 6;
k0 = 1/9;
wWaveHeight = 0.8;
changeNum = 15;
pRain = 0;
typeArray = [0 3 4 6];
%ratioArray = [0 0.05 0.1 1/9 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95];
ratioArray = [0:0.01:1];
CArray = [4 5 6 7 8 9];
wwhArray = [0.4 0.6 0.8 1 1.2];
chngArray = [9 10 11 12 13 14 15 16 17];
pRainArray = [0.02:0.02:0.2];
%{
for modelType = typeArray
    createSpace(long, width, height, ratio,modelType,r0,t0,C,k0,wWaveHeight,changeNum,pRain);
end
%}

data = zeros(300,14);
cnt = 0;

for ratio_ = ratioArray
    [time,r] = createSpace(long, width, height, ratio_,modelType,r0,t0,C,k0,wWaveHeight,changeNum,pRain);
    cnt = cnt+1;
    data(cnt,:) = [long, width, height, ratio_,modelType,r0,t0,C,k0,wWaveHeight,changeNum,pRain,time,r];
end




%{
for modelType_ = typeArray
    r0_ = 0;
    t0_ = 200;
    for C_ = CArray
        [time,r] = createSpace(long, width, height, ratio,modelType_,r0_,t0_,C_,k0,wWaveHeight,changeNum,pRain);
        cnt = cnt+1;
        data(cnt,:) = [long, width, height, ratio,modelType_,r0_,t0_,C_,k0,wWaveHeight,changeNum,pRain,time,r];
    end
end
%}

%{
for modelType_ = typeArray
    r0_ = 0;
    t0_ = 200;
    for wWaveHeight_ = wwhArray
        [time,r] = createSpace(long, width, height, ratio,modelType_,r0_,t0_,C,k0,wWaveHeight_,changeNum,pRain);
        cnt = cnt+1;
        data(cnt,:) = [long, width, height, ratio,modelType_,r0_,t0_,C,k0,wWaveHeight_,changeNum,pRain,time,r];
    end
end
%}

%{
for modelType_ = typeArray
    [time,r] = createSpace(long, width, height, ratio,modelType_,r0,t0,C,k0,wWaveHeight,changeNum,pRain);
    cnt = cnt+1;
    data(cnt,:) = [long, width, height, ratio,modelType_,r0,t0,C,k0,wWaveHeight,changeNum,pRain,time,r];
end
%}

 %{
for modelType_ = typeArray
    r0_ = 0;
    t0_ = 200;
    for changeNum_ =  chngArray
        [time,r] = createSpace(long, width, height, ratio,modelType_,r0_,t0_,C,k0,wWaveHeight,changeNum_,pRain);
        cnt = cnt+1;
        data(cnt,:) = [long, width, height, ratio,modelType_,r0_,t0_,C,k0,wWaveHeight,changeNum_,pRain,time,r];
    end
end
%}
%{
for  modelType_ = typeArray
    for wWaveHeight_ = wwhArray
        for pRain_ = pRainArray
            [time,r] = createSpace(long, width, height, ratio,modelType_,r0,t0,C,k0,wWaveHeight_,changeNum,pRain_);
            cnt = cnt+1;
            data(cnt,:) = [long, width, height, ratio,modelType_,r0,t0,C,k0,wWaveHeight_,changeNum,pRain_,time,r];
        end
    end
end
%}
data = data(1:cnt,:);
T = array2table(data,...
    'VariableNames',{'long','width','height','ratio','modelType',...
    'r0','t0','C','k0','wWaveHeight','changeNum','pRain','time','r'});
writetable(T,'data.xls')

end