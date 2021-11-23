function wave=createWave(space,time,width,height,wWaveHeight) 
    
%�������ɺ�����max(m*H*(sin(2*pi/d*i)+sin(pi/d*i))/1.8,H/10),4*k*d<i<(4*k+2)*d
    
dim = size(space); 
%xmaxΪ�˳��ִ�
x = dim(1)-1; 
%4*k*d<i<(4*k+2)*d�ı�ʽ
a1 = time/(4*width); 
a2 = round(a1);
if a1 <= a2 
    wave = space; 
else
    h = ceil(wWaveHeight*height*(sin(2*pi*time/width)+sin(pi*time/width)/1.8)); 
    if h < 2 
        h = 2;
    end
    space(x,:,2:h+1) = -1; 
    wave = space; 
end

end