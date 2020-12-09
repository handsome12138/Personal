function fishmap=GenerateFishmap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey)
%celllon,celllat are the longitude and latitude of the area
%cellsizex cellsizey are the number of cells
%fishmap is the cellsizex*cellsizey fishmap
fishmap=zeros(cellsizex,cellsizey);
%%
%filename='Herring_Full_UK';%Herring density map
%filename='Mackerel_Full_UK';%Mackerel density map

[A,refmat,bbox] = geotiffread(filename);
info=geotiffinfo(filename);
%refmat=info.RefMatrix;
Height=info.Height;
Width=info.Width;

%[x,y] = pix2map(info.RefMatrix,1 ,1);
%[fishlat0,fishlon0] = projinv(info,x,y);
%from position to latitude and longitude

THR=0.1;%threshold value to generate fishmap
for i=1:1:cellsizex-1
    for j=1:1:cellsizey-1
        lon=celllon0+(celllon1-celllon0)*(j-1)/(cellsizey-1);
        lat=celllat0-(celllat0-celllat1)*(i-1)/(cellsizex-1);
        [x1,y1] =projfwd(info,lat,lon);
        [row,col] =map2pix(refmat,x1,y1);
        row=floor(row);
        col=floor(col);
        if(row>0 && col >0 && row<Height && col < Width)
            if(A(row,col)>THR)
                fishmap(i,j)=floor(A(row,col)/THR);
            end
        end
    end
end
end 


