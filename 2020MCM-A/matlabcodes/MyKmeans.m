function Ctrs = MyKmeans(cellsizex,cellsizey,M,K)
%M: fishmap  K: number of accumulation points
%Ctrs K*2 matrix storing the coordinate of the points
fishnumber=floor(sum(M(:)));
X=zeros(fishnumber,2);
m=1;
for i=2:cellsizex-1
        for j=2:cellsizey-1
            if(M(i,j)>=1)
                while(M(i,j)>=1)
                    X(m,1)=i;X(m,2)=j;
                    m=m+1;
                    M(i,j)=M(i,j)-1;
                end
            end
        end
end
opts=statset('Display','final');
[Idx,Ctrs,SumD,D] = kmeans(X,K,'Replicates',K,'Options',opts); 
end
