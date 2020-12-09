cellsizex=300;
cellsizey=300;
%%cell size
celllat0=63;
celllon0=-18;
celllat1=48;
celllon1=12;
%%cell longitude and latitude northwest and southeast

%parameters
r=25;%radius of circle
endyear=2070;
enditeration=24;%\tau
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
%filename='Herring_Full_UK';%Herring density
%filename='Mackerel_Full_UK';%Mackerel density
%fishmap=GenerateFishmap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
fishmap=load('Fishmap_Mackerel_300300.mat').fishmap;
M1=fishmap;
fishmap=load('Fishmap_Herring_300300.mat').fishmap;
M2=fishmap;
temperaturemap=load('Temperaturemap_300300.mat').temperature;
tempchange=TemperatureChange(3);
land=load('landmap.mat').land;%landmap
filename='fisherymap_8'
fisherymap=GetFisherymap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
FisheryFishamount=zeros(2*fisherynumber,enditeration*(endyear-2018));
%%
writerObj=VideoWriter('Fisherysim_Both_20192070_24_24_tempfit3_fisherynone_stay_UK.avi');  %// define a video file
%writerObj=VideoWriter('test');  %// define a video file
%name rule  'script_fishtype_years_\tau_framerate_\kappa_others_area'
writerObj.FrameRate=24;%frame rate
open(writerObj);        
for simyear=2019:endyear
    simtempchange=tempchange(simyear-2018);
    temperaturemapchange=temperaturemap+simtempchange*(1-land);
    for iterationtime=1:enditeration
        imagesc(temperaturemapchange)
        hold on;
        for i=2:cellsizex-1
            for j=2:cellsizey-1
                if(mod(iterationtime,2)==1)
                    if(M1(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),15)+1);                
                    end
                    if(M2(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),15)+1);                
                    end
                else
                    if(M2(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),15)+1);                
                    end
                    if(M1(i,j)>=1)
                        plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),15)+1);                
                    end
                end
            end
        end   
        %draw the habours
%         for k=1:fisherynumber
%             jj=fisherymap{k,3};
%             ii=fisherymap{k,2};
%             fisheryname=fisherymap{k,1}(1:length(fisherymap{k,1})-7);
% %             FisheryFishamount(2*k-1,(simyear-2019)*enditeration+iterationtime)=Getfishes_point(M1,r,ii,jj);
% %             FisheryFishamount(2*k,(simyear-2019)*enditeration+iterationtime)=Getfishes_point(M2,r,ii,jj);
% %             %store Fishery fish amount
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
                
        M1_next=Move_Mackerel(M1,cellsizex,cellsizey,temperaturemapchange);
        M1=M1_next;
        M2_next=Move_Herring(M2,cellsizex,cellsizey,temperaturemapchange);
        M2=M2_next;
        
        text(5,250,['Year:',num2str(simyear)]);
        text(5,260,['Iterations:',num2str(iterationtime)]);
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
        writeVideo(writerObj,getframe(gcf)); %// write frame into video
        hold off
    end
end
close(writerObj); %// close video file
save('Fishmap_Mackerel_20192070_24_24_tempfit3_fisheryall_stay_UK','M1')
save('Fishmap_Herring_20192070_24_24_tempfit3_fisheryall_stay_UK','M2')
save('FisheryFishamount_both_20192070_5_10_tempfit55_fisheryall_UK','FisheryFishamount')