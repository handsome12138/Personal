[num]=csvread('MYD28M_2019-10-01_rgb_3600x1800.csv') ;

%%
[row col]=size(num);
[x0 temp]=lat2x(lat0);
[x1 temp]=lat2x(lat1);
[y0 temp]=lon2y(lon0);
[y1 temp]=lon2y(lon1);
temperature=zeros(x1-x0+1,y1-y0+1);
for i=x0:x1
    for j=y0:y1
        if(num(i,j)==99999)
        temperature(i-x0+1,j-y0+1)=0;
        else
        temperature(i-x0+1,j-y0+1)=num(i,j);
        end
    end
end

h=heatmap(temperature);
grid off;
axis off;
hold on;

%%

function [x,frac]=lat2x(lat)
t=(90.15-lat)*10;
x=floor(t);
frac=t-x;
end

function [y,frac]=lon2y(lon)
t=(180.15+lon)*10;
y=floor(t);
frac=t-y;
end