function fourPyramid = createFourPyramid(space,length,width,height,s,d,ratio)

%Éú³ÉËÄÀâÌ¨É³¶Ñ¡£

length = round(length);
width = round(width);
height = round(height);

%s = 0.5;
%d = 10;É³¶Ñ¾àÀëº£°¶µÄ¾àÀë¡£
pos = sym('pos',[4,3]);
dim = size(space);

pos(1,:) = [dim(1)-1-d,round((dim(2)-length)/2),2];
pos(2,:) = [pos(1,1),pos(1,2)+length,2];
pos(3,:) = [pos(1,1)-width,pos(2,2),2];
pos(4,:) = [round((pos(1,1)+pos(3,1))/2 + (width*s)/2),...
                round((pos(1,2)+pos(2,2))/2 + (length*s)/2),...
                height+pos(1,3)-1];

plane = sym('plane',[1,4]);
plane(1) = getPlane(pos(1,:),pos(2,:),pos(4,:));
plane(2) = getPlane(pos(2,:),pos(3,:),pos(4,:));
syms x y
plane(3) = subs(plane(1),x,pos(1,1)+pos(3,1)-x);
plane(4) = subs(plane(2),y,pos(1,2)+pos(2,2)-y);

z1 = double(pos(4,3));
z2 = double(pos(1,3));
x1 = double(pos(3,1));
x2 = double(pos(1,1));
y1 = double(pos(1,2));
y2 = double(pos(3,2));

for z=z1:-1:z2
    for x=x1:x2
        for y=y1:y2
            if eval(plane(1))>=z && eval(plane(2))>=z && eval(plane(3))>=z && eval(plane(4))>=z
                space(x,y,z)=1;
            end
        end
    end
end

space = insertWater(space,ratio);
fourPyramid = space;
    
end

