function [time,r] = createSpace(long, width, height, ratio,modelType,r0,t0,C,k0,wWaveHeight,changeNum,pRain)

%����������ratio��ɳ�Ѻ�ˮ�ʡ�

close;
space = zeros(3*width, 3*long, 2*height);
space(:,1:end,1) = 2;%���� = 2
d = 10;%ɳ���뺣����΢����������ڲ�ʧ��״�ʹ�С�����Ե�ǰ����ʹ��Ԫ�������ӽ�����

%΢����������ڲ�ʧ��״�ʹ�С�����Ե�ǰ����ʹ��Ԫ�������ӽ���
if modelType == 0
    space = createCircular(space, 1.05*long, 1.05*width, 1.05*height, d, 1-ratio);
elseif modelType == 3
    space = createThreePyramid(space, 1.15*long, 1.15*width, 1.15*height, .5, d, 1-ratio);
elseif modelType == 4
    space = createFourPyramid(space, 0.9*long, 0.9*width, 0.9*height, .5, d, 1-ratio);
elseif modelType == 6
    space = createSixPyramid(space, long, height, .5, d, 1-ratio);
else
    space = createFourPyramid(space, 0.9*long, 0.9*width, 0.9*height, .5, d, 1-ratio);
end

[total,xyz] = getPrimarySandNum(space);
sNum = total;
time = 0; 
r = sNum/total;%r��ɳ��ʣ����
draw(space,time,r)

logic_rmid = false;

%д���ļ�
fid = fopen('Exp.txt','at+');
fprintf(fid,'Experiment:\n');
strTime = datestr(datetime);
strTime = strrep(strTime,':','_');
fprintf(fid,[strTime,'\n']);
strParameter = ['l=',num2str(long),'_w=',num2str(width),'_h=',...
                    num2str(height),'_ratio=',num2str(ratio),'_model=',num2str(modelType),'_r0=',...
                    num2str(r0),'_t0=',num2str(t0),'_C=',num2str(C),'_k0=',num2str(k0),'_wWaveH=',...
                    num2str(wWaveHeight),'_chngNum=',num2str(changeNum),'_pRain=',num2str(pRain)];
fprintf(fid,[strParameter,'\n']);
fclose(fid);

while r > r0  && time<t0%̮���ж�
    time = time+1; 
    space = createWave(space,time,width,height,wWaveHeight);%ˢ��
    space = createRain(space,pRain);
    draw(space,time,r)
    space = moveWave(space);
    space = moveRain(space);
    space = changeSandyWater(space,changeNum);
    draw(space,time,r)
    space = moveSand(space,C,k0);
    draw(space,time,r)
    sNum = getPresentSandNum(space,xyz);
    r = sNum/total;
   
    if time == 1
        strTime = datestr(datetime);
        strTime = strrep(strTime,':','_');
        strVariable = ['t=',num2str(time)+'_r=',num2str(r)];
        saveas(1,['Fig_',strTime,'_',strVariable,'_',strParameter,'.jpg'])
    elseif ~logic_rmid && r < (1-r0)/2+r0
        strTime = datestr(datetime);
        strTime = strrep(strTime,':','_');
        strVariable = ['t=',num2str(time),'_r=',num2str(r)];
        saveas(1,['Fig_',strTime,'_',strVariable,'_',strParameter,'.jpg'])
         logic_rmid = true;
    end
    
end


draw(space,time,r)
strTime = datestr(datetime);
strTime = strrep(strTime,':','_');
strVariable = ['t=',num2str(time),'_r=',num2str(r)];
saveas(1,['Fig_',strTime,'_',strVariable,'_',strParameter,'.jpg'])


%�ܽ�ʵ����
fid = fopen('Exp.txt','at+');
strTime = datestr(datetime);
strTime = strrep(strTime,':','_');
fprintf(fid,'\n');
fprintf(fid,[strTime,'\n']);
strResult = ['Model=',num2str(modelType),' t=',num2str(time),' r=',num2str(r)];
fprintf(fid,[strResult,'\n']);
fprintf(fid,'----------------------------------------\n\n');
fclose(fid);
    
end