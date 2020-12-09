function fishes=Getfishes_point(fishmap,D,i,j)
%D radius of circle  temperature map  fishmap;i,j coordinate
%fishes : total fish number
[cellsizex,cellsizey]=size(fishmap);
doubleD=D^2;
fishes=0;
i=floor(i);
j=floor(j);
for x=i-D : i+D
    if(x>0 && x<cellsizex-1)
    for y=j-D : j+D
        if(y>0 && y<cellsizey-1)
        if((x-i)^2+(y-j)^2 < doubleD)
            fishes=fishes+fishmap(x,y);
        end
        end
    end
    end
end
end