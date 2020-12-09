filename='FSM_Herring_Geotiff';
[A,refmat,bbox] = geotiffread(filename);
info=geotiffinfo(filename);
%refmat=info.RefMatrix;
Height=info.Height;
Width=info.Width;

[x,y] = pix2map(info.RefMatrix,1 ,1);
[lat0,lon0] = projinv(info,x,y);
[x,y] = pix2map(info.RefMatrix,Height ,Width);
[lat1,lon1] = projinv(info,x,y);
%%

ax = worldmap([lat1 lat0],[lon0 lon1]);   
setm(ax, 'Origin', [0 0 0]);  %�������������ԣ�[0,0,0]��ʾ��ͼ���ĵľ�γ�ȸ߶�
land = shaperead('landareas', 'UseGeoCoords', true); %����½�ؿ��
geoshow(ax, land, 'FaceColor', [0.5 0.7 0.5]); %չʾ��ͼ
%%lakes = shaperead('worldlakes', 'UseGeoCoords', true);%seas
%%geoshow(lakes, 'FaceColor', lakescolor)


for i=1:2:Height
    for j=1:2:Width
        if(A(i,j)==-1)
            continue
        end
        if(A(i,j)>0.2)
        [x,y] = pix2map(info.RefMatrix,i ,j);
        [lat,lon] = projinv(info,x,y);
        geoshow(lat ,lon,'MarkerEdgeColor', 'r', 'Marker', '.', 'MarkerSize',2 )  %r��ʾ��ɫ 
        end
    end

    
end

