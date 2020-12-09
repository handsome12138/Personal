cellsizex=300;
cellsizey=300;
%%Ԫ���Ĵ�С
celllat0=63;
celllon0=-18;
celllat1=48;
celllon1=12;
%%Ԫ���ľ�γ��(���Ͻ������½�
%%һ�񳤶�Լ10km
M1=zeros(cellsizex,cellsizey);%Ԫ��
M2=zeros(cellsizex,cellsizey);%Ԫ��
%%
%filename='Herring_Full_UK';%�����ܶ�
%filename='Mackerel_Full_UK';%�����ܶ�
%fishmap=GenerateFishmap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
fishmap=load('Fishmap_Mackerel_300300.mat').fishmap;
M1=fishmap;
fishmap=load('Fishmap_Herring_300300.mat').fishmap;
M2=fishmap;
%��ͼ

%filename='MYD28M_2019-10-01_rgb_3600x1800.csv';
%temperaturemap=GetTemperaturemap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
temperaturemap=load('Temperaturemap_300300.mat').temperature;
%����ͼ
%%
%�˴�����Ԥ�⺣�±仯
C=load('HadSST_annual_nh.mat').M;
year=C(:,1)';
temp=C(:,2)';
model1=fit(year',temp','poly5');
simtemp2019=feval(model1,2019);
%%
writerObj=VideoWriter('CellSimu_Herring_20192070_10_10_UK.avi');  %// ����һ����Ƶ�ļ������涯��
%writerObj=VideoWriter('test');  %// ����һ����Ƶ�ļ������涯��
%�������򣺰汾_��_���_ÿ���������_֡��_��ע_����Χ
writerObj.FrameRate=10;%֡�ʣ���ÿ�����֡
open(writerObj);                    %// �򿪸���Ƶ�ļ�

for simyear=2019:2070
    simtempchange=feval(model1,simyear)-simtemp2019;
    temperaturemapchange=temperaturemap+simtempchange;
    for diedai=1:10
        imagesc(temperaturemapchange)
        hold on;
        for i=2:cellsizex-1
            for j=2:cellsizey-1
                if(M2(i,j)>=1)
                    %plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),15)+1)
                    plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),15)+1)
                end
            end
        end   
        %do not forget !!!!! 
        %M1_next=Move_Mackerel(M1,cellsizex,cellsizey,temperaturemapchange);
        %M1=M1_next;
        M2_next=Move_Herring(M2,cellsizex,cellsizey,temperaturemapchange);
        M2=M2_next;
        %do not forget !!!!! 
        
        text(197,250,['Year:',num2str(simyear)]);
        text(197,260,['Iterations:',num2str(diedai)]);
        text(197,270,['Temperature increse:',num2str(simtempchange)]);
        text(197,280,['Mackerel numbers:',num2str(sum(M1(:)))]);
        text(197,290,['Herring numbers:',num2str(sum(M2(:)))]);
        set(gcf,'unit','pixels','Position',[300 100 620 520]);
        colorbar;
        axis off
        text(5,-15,['longitude : ',num2str(abs(celllon0)),' \circW']);
        text(5,-5,['latitude : ',num2str(celllat0),' \circN']);
        
        text(260,310,['longitude : ',num2str(celllon1),' \circE']);
        text(260,320,['latitude : ',num2str(celllat1),' \circN']);
        writeVideo(writerObj,getframe(gcf)); %// ��֡д����Ƶ
        hold off
    end
end

close(writerObj); %// �ر���Ƶ�ļ����
%%

%run6
clear;
clc;

cellsizex=300;
cellsizey=300;
%%Ԫ���Ĵ�С
celllat0=63;
celllon0=-18;
celllat1=48;
celllon1=12;
%%Ԫ���ľ�γ��(���Ͻ������½�
%%һ�񳤶�Լ10km
M1=zeros(cellsizex,cellsizey);%Ԫ��
M2=zeros(cellsizex,cellsizey);%Ԫ��
%%
%filename='Herring_Full_UK';%�����ܶ�
%filename='Mackerel_Full_UK';%�����ܶ�
%fishmap=GenerateFishmap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
fishmap=load('Fishmap_Mackerel_300300.mat').fishmap;
M1=fishmap;
fishmap=load('Fishmap_Herring_300300.mat').fishmap;
M2=fishmap;
%��ͼ

%filename='MYD28M_2019-10-01_rgb_3600x1800.csv';
%temperaturemap=GetTemperaturemap(filename,celllat0,celllon0,celllat1,celllon1,cellsizex,cellsizey);
temperaturemap=load('Temperaturemap_300300.mat').temperature;
%����ͼ
%%
%�˴�����Ԥ�⺣�±仯
tempchange=TemperatureChange(2);
%%
writerObj=VideoWriter('CellSimu_Herring_20192070_12_24_tempfit2_UK.avi');  %// ����һ����Ƶ�ļ������涯��
%writerObj=VideoWriter('test');  %// ����һ����Ƶ�ļ������涯��
%�������򣺰汾_��_���_ÿ���������_֡��_��ע_����Χ
writerObj.FrameRate=24;%֡�ʣ���ÿ�����֡
open(writerObj);                    %// �򿪸���Ƶ�ļ�

for simyear=2019:2070
    simtempchange=tempchange(simyear-2018);
    temperaturemapchange=temperaturemap+simtempchange;
    for diedai=1:12
        imagesc(temperaturemapchange)
        hold on;
        for i=2:cellsizex-1
            for j=2:cellsizey-1
                if(M2(i,j)>=1)
                    %plot(j,i,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',min(M1(i,j),15)+1)
                    plot(j,i,'MarkerEdgeColor', 'm', 'Marker', '.', 'MarkerSize',min(M2(i,j),15)+1)
                end
            end
        end   
        %do not forget !!!!! 
%         M1_next=Move_Mackerel(M1,cellsizex,cellsizey,temperaturemapchange);
%         M1=M1_next;
        M2_next=Move_Herring(M2,cellsizex,cellsizey,temperaturemapchange);
        M2=M2_next;
        %do not forget !!!!! 
        
        text(197,250,['Year:',num2str(simyear)]);
        text(197,260,['Iterations:',num2str(diedai)]);
        text(197,270,['Temperature Rise:',num2str(simtempchange)]);
        text(197,280,['Mackerel numbers:',num2str(sum(M1(:)))]);
        text(197,290,['Herring numbers:',num2str(sum(M2(:)))]);
        set(gcf,'unit','pixels','Position',[300 100 620 520]);
        colorbar;
        axis off
        text(5,-15,['longitude : ',num2str(abs(celllon0)),' \circW']);
        text(5,-5,['latitude : ',num2str(celllat0),' \circN']);
        
        text(260,310,['longitude : ',num2str(celllon1),' \circE']);
        text(260,320,['latitude : ',num2str(celllat1),' \circN']);
        writeVideo(writerObj,getframe(gcf)); %// ��֡д����Ƶ
        hold off
    end
end

close(writerObj); %// �ر���Ƶ�ļ����
save('fishmap_Herring_2070_tempfit2_UK','M2');

