function draw(space,time,r)

%»æÍ¼º¯Êý¡£
    
dim = size(space); 
[x1,y1,z1] = getCellPos(space,-1); 
[x2,y2,z2] = getCellPos(space,1); 
[x3,y3,z3] = getCellPos(space,2);
[x4,y4,z4] = getCellPos(space,-2);
[x5,y5,z5] = getCellPos(space,-3);


figure(1);
clf('reset'); 
hold off
h3 = scatter3(x3,y3,z3,'MarkerEdgeColor',[1 .75 0],'MarkerFaceColor',[1 .75 0]);
h3.DisplayName = 'Land Cell'; 
xlim([0 dim(1)]) 
ylim([1 dim(2)]) 
zlim([0 dim(3)])
title(['time=',num2str(time),' r=',num2str(r)]);
hold on
h1 = scatter3(x1,y1,z1,'MarkerEdgeColor',[0 .75 .75],'MarkerFaceColor',[0 .75 .75]);
h1.DisplayName = 'Water Cell'; 
hold on
h2 = scatter3(x2,y2,z2,'MarkerEdgeColor',[.6 .2 0],'MarkerFaceColor',[.6 .2 0]);
h2.DisplayName = 'Sand Cell'; 
hold on
h4 = scatter3(x4,y4,z4,'MarkerEdgeColor',[.6 .2 .0],'MarkerFaceColor',[0 .75 .75]);
h4.DisplayName = 'Sandy Water Cell'; 

h5 = scatter3(x5,y5,z5,'MarkerEdgeColor',[0 .75 1],'MarkerFaceColor',[0 .75 1]);
h5.DisplayName = 'Rain Cell'; 

view(218,46); 

end