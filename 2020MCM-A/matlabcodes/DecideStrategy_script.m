NewFishery=load('NewFishery_tempfit3_UK.mat').Ctrs1;
M1_2070=load('Fishmap_Mackerel_20192070_10_20_tempfit3_fisheryall_UK').M1;
M2_2070=load('Fishmap_Herring_20192070_10_20_tempfit3_fisheryall_UK').M2;
fishmap=load('Fishmap_Mackerel_300300.mat').fishmap;
M1=fishmap;
fishmap=load('Fishmap_Herring_300300.mat').fishmap;
M2=fishmap;
result=zeros(8,7);
%column1:strategy  
%column2:target accumulation point number
%column 3456 :profit of 1 2 3 4 respectively
cost1=0.2;%\alpha
cost2=0.2/100;%\beta
for k=1:8
    x=fisherymap{k,2};
    y=fisherymap{k,3};
    [result(k,1), result(k,2),result(k,3:6), result(k,7)]= DecideStrategy(M1,M2,M1_2070,M2_2070,NewFishery,10,x,y,cost1,cost2,profit);
end
function [beststrategy, bestfocus,profit_s,profit2070]= DecideStrategy(fishmap_origin1,fishmap_origin2,M1,M2,location_k,k,location_x,location_y,cost1,cost2,profit)
%fishmap_origin1/2,M1/2,fishmap in 2019/2070
%location_k,k£¬accumulation points matrix, k*2£¬points number
%D1,D2 radius before and after upgrading ship
%location_x,location_y,coordinate of habour
%profit profit(1):Mackerel,Profit(2):Herring
profit_s=zeros(1,4);
D1=25;D2=floor(sqrt(2)*25);
upbound=1.2;%$a$
ratelower=0.9;%\bata
updateship=1.7;%$b/a$
gatherlower=0.8;%\delta
baitup=1.1;%\zeta+1
baitcost=0.1;%\epsilon
%strategy 1 
fishes1_origin = Getfishes_point(fishmap_origin1, D1, location_x, location_y);
fishes2_origin = Getfishes_point(fishmap_origin2, D1, location_x, location_y);
fishes1_later = Getfishes_point(M1, D2, location_x, location_y);
fishes2_later = Getfishes_point(M2, D2, location_x, location_y);
profit_origin = (profit(1) * fishes1_origin + profit(2) * fishes2_origin);
profit_later = (profit(1) * fishes1_later + profit(2) * fishes2_later);
fishes1_2070 = Getfishes_point(M1, D1, location_x, location_y);
fishes2_2070 = Getfishes_point(M2, D1, location_x, location_y);
profit2070 =(profit(1) * fishes1_2070 + profit(2) * fishes2_2070)/profit_origin-1;
if(profit_later > profit_origin * upbound * updateship)
    profit_later = profit_origin * upbound * updateship;
end
profit_s(1) = (profit_later * ratelower- cost1*profit_origin) / profit_origin - 1;
%strategy 4 
profit_s(4)= (profit2070 * baitup - baitcost * profit_origin) / profit_origin - 1;
%strategy 2
cost_k=zeros(k,1);
profit_k = zeros(k,1);
for i=1:k
    fishes1_focus = Getfishes_point(M1, D1, location_k(i,1), location_k(i,2));
    fishes2_focus = Getfishes_point(M2, D1, location_k(i,1), location_k(i,2));
    cost_k(i)= cost2 * (sqrt((location_x - location_k(i,1))^2 + (location_y - location_k(i,2))^2));
    profit_focus=(profit(1) * fishes1_focus + profit(2) * fishes2_focus);
    if(profit_focus > profit_origin * upbound)
        profit_focus = profit_origin * upbound;
    end
    profit_k(i) = ( profit_focus- cost_k(i) * profit_origin) / profit_origin - 1;
end
[profit_s(2),bestfocus2] = max(profit_k(:));
%strategy 3
profit_k3=zeros(k,1);
for i = 1:k
    fishes1_focus = Getfishes_point(M1, D2, location_k(i,1), location_k(i,2));
    fishes2_focus = Getfishes_point(M2, D2, location_k(i,1), location_k(i,2));
    profit_focus=profit(1) * fishes1_focus + profit(2) * fishes2_focus;
    if(profit_focus > profit_origin * upbound * updateship)
        profit_focus = profit_origin * upbound * updateship;
    end
    profit_k3(i) = ( profit_focus * ratelower * gatherlower- (cost_k(i) - cost1) * profit_origin) / profit_origin - 1;
end
[profit_s(3),bestfocus3] = max(profit_k3(:));
[maxprofit,beststrategy] = max(profit_s);
if(beststrategy==3)
    bestfocus=bestfocus3;
elseif(beststrategy==2)
    bestfocus=bestfocus2;
else
    bestfocus=0;
end
if( max(profit_s) < profit2070 )
    beststrategy=5;
end
if( max(profit_s) < 0 )
    beststrategy=6;    
end
end