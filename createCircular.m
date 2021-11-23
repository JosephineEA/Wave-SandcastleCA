function circular = createCircular(space,length,width,height,d,ratio)

%Éú³ÉÔ²Ì¨É³¶Ñ¡£

length = round(length);
width = round(width);
height = round(height);

%d = 10;É³¶Ñ¾àº£°¶µÄ¾àÀë¡£
dim = size(space);
a = width/2;
b = length/2;
c = dim(3)-1;

pos = sym('pos',[4,3]);
pos(1,:) = [dim(1)-1-d,ceil(dim(2)/2),2];
pos(2,:) = [ceil(pos(1,1)-a),ceil(pos(1,2)+b),2];
pos(3,:) = [ceil(pos(1,1)-2*a),pos(1,2),2];
pos(4,:) = [pos(2,1),ceil(pos(1,2)-b),2];

x1 = double(pos(3,1));
x2 = double(pos(1,1));
y1 = double(pos(4,2));
y2 = double(pos(2,2));

for z = height+1:-1:2
    for x = x1:x2
        for y = y1:y2
            if z <= c+1-sqrt(c^2*((x-pos(2,1))^2/a^2+(y-pos(1,2))^2/b^2))
                space(x,y,z) = 1;
            end
        end
    end
end

space = insertWater(space,ratio);
circular = space;
    
end

