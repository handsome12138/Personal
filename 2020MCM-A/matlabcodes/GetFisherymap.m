function fisherymap=GetFisherymap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey)
%fisherymap is 8*3 cell storing 8 Habour's name and coordinates
%filename='fisherymap_8';
%filename='fisherymap_full';
[num,name]=xlsread(filename);
[t,~]=size(name);
fisherymap=cell(t,3);
fisherymap(:,1)=name;
lat=num(:,2);lon=num(:,3);
x=(celllat0-lat)/(celllat0-celllat1)*(cellsizex-1)+1;
y=(lon-celllon0)/(celllon1-celllon0)*(cellsizey-1)+1;
x=floor(x);
y=floor(y);
for i=1:t
    fisherymap{i,2}=x(i);
    fisherymap{i,3}=y(i);
end
end

