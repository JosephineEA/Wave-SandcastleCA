function sixPyramid=createSixPyramid(space,length,height,s,d,ratio)

%Éú³ÉÁùÀâÌ¨É³¶Ñ¡£

length = round(length);
height = round(height);

%s = 0.5
%d = 10£¬É³¶Ñ¾àº£°¶µÄ¾àÀë¡£
dim = size(space);

pos = sym('pos',[9,3]);
pos(1,:) = [dim(1)-1-d,round(dim(2)/2-length/4),2];
pos(2,:) = [pos(1,1),round(dim(2)/2+length/4),2];
pos(3,:) = [round(pos(1,1)-sqrt(3)*length/4),round(pos(2,2)+length/4),2];
pos(4,:) = [round(pos(1,1)-sqrt(3)*length/2),pos(2,2),2];
pos(5,:) = [pos(4,1),pos(1,2),2];
pos(6,:) = [pos(3,1),round(pos(1,2)-length/4),2];
pos(7,:) = [pos(6,1),round(dim(2)/2-length*s/2),height+pos(1,3)-1]; 
pos(8,:) = [round(pos(7,1)+sqrt(3)*s*length/4),round(pos(7,2)+3*s*length/4),height+pos(1,3)-1];
pos(9,:) = [pos(7,1),round(dim(2)/2+length*s/2),height+pos(1,3)-1];

plane = sym('plane',[1,6]);
plane(1) = getPlane(pos(1,:),pos(2,:),pos(8,:));
plane(2) = getPlane(pos(2,:),pos(8,:),pos(3,:));
plane(3) = getPlane(pos(4,:),pos(9,:),pos(3,:));
syms x
plane(4) = subs(plane(1),x,2*pos(3,1)-x);
plane(5) = getPlane(pos(5,:),pos(6,:),pos(7,:));
plane(6) = getPlane(pos(1,:),pos(6,:),pos(7,:));

z1 = double(pos(8,3));
z2 = double(pos(1,3));
x1 = double(pos(4,1));
x2 = double(pos(1,1));
y1 = double(pos(6,2));
y2 = double(pos(3,2));

for z=z1:-1:z2
    for x=x1:x2
        for y=y1:y2
            if eval(plane(1))>=z && eval(plane(2))>=z && eval(plane(3))>=z && eval(plane(4))>=z && eval(plane(5))>=z && eval(plane(6))>=z
                space(x,y,z)=1;
            end
        end
    end
end

space = insertWater(space,ratio);
sixPyramid = space;
    
end

