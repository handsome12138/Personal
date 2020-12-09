function fishes=Getfishes(temperature,fishmap,D)
%D radius of circle; temperature map fishmap
%fishes cellsizex*cellsizey matrix storing fish number in the circle
[cellsizex,cellsizey]=size(temperature);
doubleD=D^2;
fishes=zeros(cellsizex,cellsizey);
for i=2:cellsizex-1
    for j=2:cellsizey-1
        if( (temperature(i,j)==0) && ( (temperature(i-1,j)~=0)||(temperature(i+1,j)~=0) ) &&...
                i>80 && i<260 && j>90 && j <193)
            %make sure is in UK
            for x=i-D : i+D
                if(x>0 && x<cellsizex-1)
                for y=j-D : j+D
                    if(y>0 && y<cellsizey-1)
                    if((x-i)^2+(y-j)^2 < doubleD)
                        fishes(i,j)=fishes(i,j)+fishmap(x,y);
                    end
                    end
                end
                end
            end
        end
    end
end