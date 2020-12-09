function temperature=GetTemperaturemap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey)
%temperature is cellsizex*cellsizey matrix, storing temperature data
%filename='MYD28M_2019-10-01_rgb_3600x1800.csv';%temperature table
[num]=csvread(filename) ;
[row, col]=size(num);
for i=1:row
    for j=1:col
    if(num(i,j)==99999)
        num(i,j)=0;
    end
    end
end
temperature=zeros(cellsizex,cellsizey);
for i=1:cellsizex
    for j=1:cellsizey
        lon=celllon0+(celllon1-celllon0)*(j-1)/(cellsizey-1);
        lat=celllat0-(celllat0-celllat1)*(i-1)/(cellsizex-1);
        [x,frac1]=temlat2x(lat);
        [y,frac2]=temlon2y(lon);
        if (num(x,y)~=0 && num(x+1,y)~=0 && num(x,y+1)~=0 && num(x+1,y+1)~=0 )
            temperature(i,j)=num(x,y)*(1-frac1)*(1-frac2)+num(x+1,y)*frac1*(1-frac2)+num(x,y+1)*(1-frac1)*frac2+num(x+1,y+1)*frac1*frac2;
        elseif (num(x,y)~=0 && num(x+1,y)~=0)
            temperature(i,j)=num(x,y)*(1-frac1)+num(x+1,y)*frac1;
        elseif (num(x,y)~=0 && num(x,y+1)~=0 )
            temperature(i,j)=num(x,y)*(1-frac2)+num(x,y+1)*frac2;
        else
            temperature(i,j)=num(x,y);
        end
        %%linear interpolation to get temperature map
    end
end

end
function [x,frac]=temlat2x(lat)
t=(90.15-lat)*10;
x=floor(t);
frac=t-x;
end
function [y,frac]=temlon2y(lon)
t=(180.15+lon)*10;
y=floor(t);
frac=t-y;
end
