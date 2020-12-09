function Desire=MoveDesire_Mackerel(i,j,temperaturemap,fishmap)
x=[temperaturemap(i-1,j-1),temperaturemap(i-1,j),temperaturemap(i-1,j+1),...
    temperaturemap(i,j-1),temperaturemap(i,j),temperaturemap(i,j+1),...
    temperaturemap(i+1,j-1),temperaturemap(i+1,j),temperaturemap(i+1,j+1)];
mu=13.526;
sigma=1.2683;
expect=1/sqrt(2*pi)/sigma*exp(-(x-mu).^2/(2*sigma*sigma));
Corner=(sqrt(2)-1)/2;
Population=[fishmap(i-1,j-1),fishmap(i-1,j),fishmap(i-1,j+1),...
    fishmap(i,j-1),fishmap(i,j),fishmap(i,j+1),...
    fishmap(i+1,j-1),fishmap(i+1,j),fishmap(i+1,j+1)]+1;
for i=1:9
    if(x(i)==0)
        expect(i)=0;
    end
end
Desire=expect.*[Corner,1,Corner,1,1,1,Corner,1,Corner]./Population;
Desire=Desire/sum(Desire);
end
