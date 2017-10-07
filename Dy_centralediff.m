function fy = Dy_centralediff(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[1 0],'replicate','both');
ny=size(f,1); 

fy=zeros(ny0,nx0); 
fy(1:ny0,:)=0.5*(f(3:ny,:)-f(1:ny-2,:)); 

%fy(ny,:)=f(ny,:)-f(ny-1,:);  % for the last row, use the backward difference
%fy(1,:)=f(2,:)-f(1,:); % for the first row, use the forward difference

end

