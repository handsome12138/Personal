cellsizex=300;
cellsizey=300;
%%元胞的大小
celllat0=63;
celllon0=-18;
celllat1=48;
celllon1=12;
%%元胞的经纬度(左上角与右下角
%%一格长度约10km
M1=zeros(cellsizex,cellsizey);%元胞
M2=zeros(cellsizex,cellsizey);%元胞

%parameters
r=25;%渔场辐射范围
endyear=2070;%模拟终止年份
enditeration=3;%模拟终止迭代次数
fisherynumber=8;

tonnage=[61366,58726,65543,56423,64622;
    239470,199887,188487,179956,153000];
value=[18470,21307,43559,23776,24377;
    194798,130513,168602,161892,163399];
weight=[700,400]*10^-3;
profit=zeros(2,1);
profit(2)=value(1,:)/tonnage(1,:)*weight(1);
profit(1)=value(2,:)/tonnage(2,:)*weight(2);

%%
%filename='Herring_Full_UK';%鲱鱼密度
%filename='Mackerel_Full_UK';%鲭鱼密度
%fishmap=GenerateFishmap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);

% fishmap=load('Fishmap_Mackerel_300300.mat').fishmap;
% M1=fishmap;
% fishmap=load('Fishmap_Herring_300300.mat').fishmap;
% M2=fishmap;
%初始鱼图

% fishmap=load('Fishmap_Mackerel_2019_50_10_tempfit3_fisheryall_stay_UK').M1;
% M1=fishmap;
% fishmap=load('Fishmap_Herring_2019_50_10_tempfit3_fisheryall_stay_UK').M2;
% M2=fishmap;

fishmap=load('Fishmap_Mackerel_20192070_10_20_tempfit5_fisheryall_UK').M1;
M1=fishmap;
fishmap=load('Fishmap_Herring_20192070_10_20_tempfit5_fisheryall_UK').M2;
M2=fishmap;


%filename='MYD28M_2019-10-01_rgb_3600x1800.csv';
%temperaturemap=GetTemperaturemap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
temperaturemap=load('Temperaturemap_300300.mat').temperature;
%海温图
kappa=5;
tempchange=TemperatureChange(kappa);
%此处用于预测海温变化
land=load('landmap.mat').land;
%陆地图
filename='fisherymap_8';
%fisherymap=GetFisherymap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
%fisherymap=load('Fisherymap_8_300300.mat').fisherymap;
fisherymap=GetFisherymap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
%渔场图
FisheryFishamount=zeros(2*fisherynumber,enditeration*(endyear-2018));
%记录渔场范围内鱼数量变化的矩阵

%%
% writerObj=VideoWriter('Fisherysim_Both_20192070_5_10_tempfit55_fisheryall_UK.avi');  %// 定义一个视频文件用来存动画
% %writerObj=VideoWriter('test');  %// 定义一个视频文件用来存动画
% writerObj.FrameRate=10;%帧率，即每秒多少帧
% open(writerObj);                    %// 打开该视频文件

simyear=2070;
iterationtime=3;

    simtempchange=tempchange(simyear-2018);
    temperaturemapchange=temperaturemap+simtempchange*(1-land);

        imagesc(temperaturemapchange)
        hold on;
        for i=2:cellsizex-1
            for j=2:cellsizey-1
                if(mod(i+j,2)==1)
                    if(M1(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),10)+1);                
                    end
                    if(M2(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),10)+1);                
                    end
                else
                    if(M2(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),10)+1);                
                    end
                    if(M1(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),10)+1);                
                    end
                end
                
                
            end
        end   
        %画港口
%         for k=1:fisherynumber
%             jj=fisherymap{k,3};
%             ii=fisherymap{k,2};
%             fisheryname=fisherymap{k,1}(1:length(fisherymap{k,1})-7);
% %             FisheryFishamount(2*k-1,(simyear-2019)*enditeration+iterationtime)=Getfishes_point(M1,r,ii,jj);
% %             FisheryFishamount(2*k,(simyear-2019)*enditeration+iterationtime)=Getfishes_point(M2,r,ii,jj);
% %             %This part is to store the annual catch of fish 
%             theta=0:0.1:2*pi;
%             x=r*cos(theta);y=r*sin(theta);
%             plot(jj,ii,'MarkerEdgeColor', 'y', 'Marker', '.', 'MarkerSize',15);
%             text(jj,ii,fisheryname);
%             plot(x+jj,y+ii,'y.-','LineWidth',1, 'MarkerSize',1);
%         end
        
        
        
        
%         fishamount_mackerel=Getfishes_point(temperaturemap,M1,r,ii,jj);
%         fishamount_herring=Getfishes_point(temperaturemap,M2,r,ii,jj);
%         profit_new=fishamount_mackerel*profit(1)+fishamount_herring*profit(2);
%         text(jj,ii+10,['Mackerel:',num2str(fishamount_mackerel),' Herring:',num2str(fishamount_herring)]);
                
        
%         M1_next=Move_Mackerel(M1,cellsizex,cellsizey,temperaturemapchange);
%         M1=M1_next;
%         M2_next=Move_Herring(M2,cellsizex,cellsizey,temperaturemapchange);
%         M2=M2_next;
        
          text(5,250,['Year:',num2str(simyear)]);
          text(5,260,['\kappa = ',num2str(kappa)]);
%            text(5,260,['Iterations:',num2str(iterationtime),'/year']);
%         text(5,270,['Temperature Rise:',num2str(simtempchange)]);
%         text(5,280,['Mackerel numbers:',num2str(sum(M1(:)))]);
%         text(5,290,['Herring numbers:',num2str(sum(M2(:)))]);
        set(gcf,'unit','pixels','Position',[300 100 620 520]);
        colorbar;
        axis off
        text(5,-15,['longitude : ',num2str(abs(celllon0)),' \circW']);
        text(5,-5,['latitude : ',num2str(celllat0),' \circN']);
        
        text(260,310,['longitude : ',num2str(celllon1),' \circE']);
        text(260,320,['latitude : ',num2str(celllat1),' \circN']);
%         writeVideo(writerObj,getframe(gcf)); %// 将帧写入视频
        hold off


% close(writerObj); %// 关闭视频文件句柄

