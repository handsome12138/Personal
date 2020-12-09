function result=TemperatureChange(i)
%i : \kappa
C=load('HadSST_annual_nh.mat').M;%temperature data
[right,~]=size(C(:,1));
left=find(C(:,1)==1961);
year=C(left:right,1)';
temp=C(left:right,2)';
ft = fittype('fitfunction(x,a1,b1,c1,a2,b2,c3,a3,b3,c3,k,s)');
model2 = fit(year',temp',ft);
x=1961:2070;
y=feval(model2,x);
k=i/4/51*12;
s=[zeros(1,2019-1961),k*(0:2070-2019)];
y1=y'+s;
result=y1(2019-1961+1:2070-1961+1);
result=result-result(1);
%     plot(x,y1','r.-','MarkerSize',1);
end

