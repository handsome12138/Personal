function y=fitfunction(x,a1,b1,c1,a2,b2,c2,a3,b3,c3,k,s)
y=a1*sin(b1*x+c1)+a2*sin(b2*x+c2)+a3*sin(b3*x+c3)+k*x+s;
end
