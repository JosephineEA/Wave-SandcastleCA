function threePyramid=createThreePyramid(space, long, width, height, s, d, ratio)

%Éú³ÉÈýÀâÌ¨É³¶Ñ¡£

long  = round(long);
width = round(width);
height = round(height);

%s = 0.5
%d = 10,É³¶Ñ¾àÀëº£°¶µÄ¾àÀë
dim = size(space); 

pos = sym('pos',[5,3]);
pos(1,:) = [dim(1)-1-d,round(dim(2)/2),2];
pos(2,:) = [pos(1,1)-width,pos(1,2)-round(long/2),2];
pos(3,:) = [pos(2,1),pos(1,2)+round(long/2),2];
pos(4,:) = [pos(1,1)+round((2/3)*width*(s-1)),pos(1,2),height+pos(1,3)-1];
pos(5,:) = [pos(4,1)-width*s,pos(4,2)+round((long*s)/2),pos(4,3)];

plane = sym('plane',[1,3]);
plane(1) = getPlane(pos(1,:),pos(2,:),pos(4,:));
plane(2) = getPlane(pos(1,:),pos(3,:),pos(4,:));
plane(3) = getPlane(pos(3,:),pos(2,:),pos(5,:));

z1 = double(pos(4,3));
z2 = double(pos(1,3));
x1 = double(pos(3,1));
x2 = double(pos(1,1));
y1 = double(pos(2,2));
y2 = double(pos(3,2));

for z = z1:-1:z2
    for x = x1:x2
        for y = y1:y2
            if eval(plane(1))>=z && eval(plane(2))>=z && eval(plane(3))>=z
                space(x,y,z) = 1;
            end
        end
    end
end
space = insertWater(space,ratio);
threePyramid = space;

end

