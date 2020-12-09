function nextfishmap=Move_Markerel(fishmap,cellsizex,cellsizey,temperaturemap)
nextfishmap=zeros(cellsizex,cellsizey);
for i=2:cellsizex-1
        for j=2:cellsizey-2
            while(fishmap(i,j)>=1)
                desire=MoveDesire_Mackerel(i,j,temperaturemap,fishmap);
                %desire is 1*9 matrix, storing move posibility from 1 to 9                   
                r=rand();
                k=1;
                while(r>desire(k))
                    r=r-desire(k);
                    k=k+1;
                end
                switch k
                    case 1 ,nextfishmap(i-1,j-1)=nextfishmap(i-1,j-1)+1;
                    case 2 ,nextfishmap(i-1,j)=nextfishmap(i-1,j)+1;
                    case 3 ,nextfishmap(i-1,j+1)=nextfishmap(i-1,j+1)+1;
                    case 4 ,nextfishmap(i,j-1)=nextfishmap(i,j-1)+1;
                    case 5 ,nextfishmap(i,j)=nextfishmap(i,j)+1;
                    case 6 ,nextfishmap(i,j+1)=nextfishmap(i,j+1)+1;
                    case 7 ,nextfishmap(i+1,j-1)=nextfishmap(i+1,j-1)+1;
                    case 8 ,nextfishmap(i+1,j)=nextfishmap(i+1,j)+1;
                    case 9 ,nextfishmap(i+1,j+1)=nextfishmap(i+1,j+1)+1;                                  
                end
                fishmap(i,j)=fishmap(i,j)-1;
             end
   end
end 
end