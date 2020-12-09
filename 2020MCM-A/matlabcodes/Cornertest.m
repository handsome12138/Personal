Q=zeros(500,500);
Q(250,250)=1;
Q_next=zeros(500,500);
for diedai=1:50
    
    for i=1:500
        for j=1:500
            if(Q(i,j)==1)
                Q_next(i,j)=1;
                Q_next(i-1,j)=1;
                Q_next(i+1,j)=1;
                Q_next(i,j-1)=1;
                Q_next(i,j+1)=1;
                Q_next(i-1,j-1)=1;
                Q_next(i-1,j+1)=1;
                Q_next(i+1,j-1)=1;
                Q_next(i+1,j+1)=1;
                r=rand();
%                 if(r<sqrt(2)/2-0.5)
%                     Q_next(i-1,j-1)=1;
%                 end
%                 r=rand();
%                 if(r<sqrt(2)/2-0.5)
%                     Q_next(i-1,j+1)=1;
%                 end
%                 r=rand();
%                 if(r<sqrt(2)/2-0.5)
%                     Q_next(i+1,j-1)=1;
%                 end
%                 r=rand();
%                 if(r<sqrt(2)/2-0.5)
%                     Q_next(i+1,j+1)=1;
%                 end
                
            end
        end
    end
    Q=Q_next;
end

imshow(Q)