function fy=Dy_forward(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[1 0],'replicate','post');
ny=size(f,1); 
fy=zeros(ny0,nx0); 
fy(1:ny0,:)=f(2:ny,:)-f(1:ny-1,:); 
 
%fy(ny,:)=f(ny,:)-f(ny-1,:);  % for the last row, use the backward difference


end

