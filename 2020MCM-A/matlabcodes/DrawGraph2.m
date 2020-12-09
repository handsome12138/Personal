%temperature fitting curve and simulation
C=load('HadSST_annual_nh.mat').M;

[right,~]=size(C(:,1));
left=find(C(:,1)==1961);

year=C(left:right,1)';
temp=C(left:right,2)';

ft = fittype('fitfunction(x,a1,b1,c1,a2,b2,c3,a3,b3,c3,k,s)');
model2 = fit(year',temp',ft);
x=1961:2070;
y=feval(model2,x);

plot(year,temp,'k.-');
hold on
xlabel('year')
ylabel('sea-surface temperature anomaly (relative to 1961-1990)')
title('temperature prediction with parameter \kappa')
% y2=y';
% plot(x,y2)
%%
for i=[1,1.5,2,3,4,5,5.5,6]
    k=i/4/51*12;
    s=[zeros(1,2019-1961),k*(0:2070-2019)];
    y1=y'+s;
    result=y1(2019-1961+1:2070-1961+1);
    result=result-result(1);
    plot(x,y1','r.-','MarkerSize',1);
    text(2060,y1(110)-1.5,strcat('\kappa = ',num2str(i)))
    axis([1961 2070 -1 18])
end
legend('actual data','location','northwest')
%%
subplot(1,3,1)
a=imread('2070_10times_tempfit2_bothfish_nocompany_kmeans.jpg');
imshow(a)
subplot(1,3,2)
a=imread('2070_10times_tempfit4_bothfish_nocompany_kmeans.jpg');
imshow(a)
subplot(1,3,3)
a=imread('2070_10times_tempfit5_bothfish_nocompany_kmeans.jpg');
imshow(a)