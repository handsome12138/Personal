%Normal distribution simulation
%filename='Herring_Full_UK';% herring density
%filename='Mackerel_Full_UK';% mackerel density
[A,refmat,bbox] = geotiffread(filename);
info=geotiffinfo(filename);
Height=info.Height;
Width=info.Width;
k=1;
temp=zeros(2,cellsizex*cellsizey);
for i=1:cellsizex
    for j=1:cellsizey
        lon=celllon0+(celllon1-celllon0)*(j-1)/(cellsizey-1);
        lat=celllat0-(celllat0-celllat1)*(i-1)/(cellsizex-1);
        [x1,y1] =projfwd(info,lat,lon);
        [row,col] =map2pix(refmat,x1,y1);
        row=floor(row);
        col=floor(col);
        if(row>0 && col >0 && row < Height && col <Width)
            if(A(row,col)>0.05)
            temp(1,k)=temperaturemap(i,j);
            temp(2,k)=A(row,col);
            k=k+1;
            end
        end
    end
end
B=temp(1:2,1:k-1);
G=sortrows(B')';
save('fishdensity-temperature_Mackerel.mat','G');
%%
%draw Normal distribution Graph
G=load('fishdensity-temperature_Mackerel.mat').G;
z=find(G(1,:)==0);
[~,left]=size(z);
[~, right]=size(G);
B=G(1:2,left+1:right);
plot(B(1,:),B(2,:),'k.','MarkerSize',1);
hold on;
x0=B(1,:);y0=B(2,:);
[miu,sigma]=normfit(x0,y0);
x=linspace(min(B(1,:))-1,max(B(1,:))+1);
expect=1/sqrt(2*pi)/sigma*exp(-(x-mu).^2/(2*sigma*sigma));
plot(x,expect,'r.-','MarkerSize',1);
axis([min(x),max(x),0,0.75])

text(9,0.7,strcat('\mu = ',num2str(mu)));
text(9,0.65,strcat('\sigma = ',num2str(sigma)));
xlabel('Temperature \circC');
ylabel('Probability of Finding Mackerel')
title('Mackerel : Probability Density - Temperature Fitting')
legend('Sample Points','Fitted Curve')
%%

%clustering Analysis and draw points
K=10;
%  fishes1=Getfishes(temperaturemap,M1,25);
%  fishes2=Getfishes(temperaturemap,M2,25);
% Ctrs1 = LocationFocus(cellsizex,cellsizey,fishes1*profit(1)+fishes2*profit(2),60,10) %new fishery location
Ctrs1 = MyKmeans(cellsizex,cellsizey,M1,K)  
Ctrs2 = MyKmeans(cellsizex,cellsizey,M2,K)%fish gathering points location
hold on
for i=1:10
        plot(Ctrs1(i,2),Ctrs1(i,1),'MarkerEdgeColor', 'b', 'Marker', '.', 'MarkerSize',20);
        plot(Ctrs2(i,2),Ctrs2(i,1),'MarkerEdgeColor', 'c', 'Marker', '.', 'MarkerSize',20); 
end
%%

%fisherfishamount and draw graph
FisheryFishamount_temp=load('FisheryFishamount_both_20192070_10_20_tempfit3_fisheryall_52_UK.mat').FisheryFishamount;
FisheryFishamount=FisheryFishamount_temp(:,1:1:52);
year=2019:2070;
    for k=1:8
        pp=FisheryFishamount(2*k-1,1)*profit(1)+FisheryFishamount(2*k,1)*profit(2);
        p=(FisheryFishamount(2*k-1,1:52)*profit(1)+FisheryFishamount(2*k,1:52)*profit(2))/pp;
        hold on
        plot(year,p)
    end 
    axis([2019,2070,0,3])
    title('Profit performance when \kappa = 3')
    legend(fisherymap{1:8,1},'location','northwest')
    xlabel('year')
    ylabel('The ratio of profit of each year to the profit of 2019')
    
    %%
    %draw elapsedyear_kappa graph
    far=0.9;%\lambda
    faryear_tempfit=zeros(8,8);%1 1.5 2 3 4 5 5.5 6
    fisheryfishamount_tempfit1=load('FisheryFishamount_both_20192070_5_10_tempfit1_fisheryall_260_UK.mat').FisheryFishamount;
    for k=1:8       
        initial=fisheryfishamount_tempfit1(2*k-1,1)*profit(1)+fisheryfishamount_tempfit1(2*k,1)*profit(2);
        for i=1:5:260
            if ((fisheryfishamount_tempfit1(2*k-1,i)*profit(1)+fisheryfishamount_tempfit1(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,1)=2019+floor(i/5);
    end
    fisheryfishamount_tempfit15=load('FisheryFishamount_both_20192070_5_10_tempfit1_5_fisheryall_260_UK.mat').FisheryFishamount;
    for k=1:8       
        initial=fisheryfishamount_tempfit15(2*k-1,1)*profit(1)+fisheryfishamount_tempfit15(2*k,1)*profit(2);
        for i=1:5:260
            if ((fisheryfishamount_tempfit15(2*k-1,i)*profit(1)+fisheryfishamount_tempfit15(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,2)=2019+floor(i/5);
    end 
    fisheryfishamount_tempfit2=load('FisheryFishamount_both_20192070_10_20_tempfit2_fisheryall_520_UK.mat').FisheryFishamount;
    for k=1:8
        
        initial=fisheryfishamount_tempfit2(2*k-1,1)*profit(1)+fisheryfishamount_tempfit2(2*k,1)*profit(2);
        for i=1:10:520
            if ((fisheryfishamount_tempfit2(2*k-1,i)*profit(1)+fisheryfishamount_tempfit2(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,3)=2019+floor(i/10);
    end
    fisheryfishamount_tempfit3=load('FisheryFishamount_both_20192070_10_20_tempfit3_fisheryall_52_UK.mat').FisheryFishamount;
    for k=1:8
        initial=fisheryfishamount_tempfit3(2*k-1,1)*profit(1)+fisheryfishamount_tempfit3(2*k,1)*profit(2);
        for i=1:1:52
            if ((fisheryfishamount_tempfit3(2*k-1,i)*profit(1)+fisheryfishamount_tempfit3(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,4)=2018+i;
    end
    fisheryfishamount_tempfit4=load('FisheryFishamount_both_20192070_10_20_tempfit4_fisheryall_52_UK.mat').FisheryFishamount;
    for k=1:8
        initial=fisheryfishamount_tempfit4(2*k-1,1)*profit(1)+fisheryfishamount_tempfit4(2*k,1)*profit(2);
        for i=1:1:52
            if ((fisheryfishamount_tempfit4(2*k-1,i)*profit(1)+fisheryfishamount_tempfit4(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,5)=2018+i;
    end
    fisheryfishamount_tempfit5=load('FisheryFishamount_both_20192070_10_20_tempfit5_fisheryall_520_UK.mat').FisheryFishamount;
    for k=1:8       
        initial=fisheryfishamount_tempfit5(2*k-1,1)*profit(1)+fisheryfishamount_tempfit5(2*k,1)*profit(2);
        for i=1:10:520
            if ((fisheryfishamount_tempfit5(2*k-1,i)*profit(1)+fisheryfishamount_tempfit5(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,6)=2019+floor(i/10);
    end
    fisheryfishamount_tempfit55=load('FisheryFishamount_both_20192070_5_10_tempfit55_fisheryall_260_UK.mat').FisheryFishamount;
    for k=1:8       
        initial=fisheryfishamount_tempfit55(2*k-1,1)*profit(1)+fisheryfishamount_tempfit55(2*k,1)*profit(2);
        for i=1:5:260
            if ((fisheryfishamount_tempfit55(2*k-1,i)*profit(1)+fisheryfishamount_tempfit55(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,7)=2019+floor(i/5);
    end
    fisheryfishamount_tempfit6=load('FisheryFishamount_both_20192070_5_10_tempfit6_fisheryall_260_UK.mat').FisheryFishamount;
    for k=1:8       
        initial=fisheryfishamount_tempfit6(2*k-1,1)*profit(1)+fisheryfishamount_tempfit6(2*k,1)*profit(2);
        for i=1:5:260
            if ((fisheryfishamount_tempfit6(2*k-1,i)*profit(1)+fisheryfishamount_tempfit6(2*k,i)*profit(2))<initial*far)
                break
            end
        end
        faryear_tempfit(k,8)=2019+floor(i/5);
    end
    x=[1,1.5,2,3,4,5,5.5,6];
    plot(x,faryear_tempfit','MarkerSize',10);
    legend(fisherymap{1:8,1})
    xlabel('\kappa')
    ylabel('elapsed year')
    title(strcat('elapsed year - \kappa Graph (\lambda = ',num2str(far),')'))
%%
