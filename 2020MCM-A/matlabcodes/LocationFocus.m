function locations=LocationFocus(cellsizex,cellsizey,fishes,lowerbounder,K)
%fishes = Getfishes(temperature,fishmap,D)
for i=2:cellsizex
    for j=2:cellsizey
        if(fishes(i,j)<lowerbounder)
            fishes(i,j)=0;
        end
    end
end
locations=MyKmeans(cellsizex,cellsizey,fishes,K);