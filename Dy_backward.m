function  fy=Dy_backward(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[1 0],'replicate','pre');
ny=size(f,1); 
fy=zeros(ny0,nx0); 
fy(1:ny0,:)=f(2:ny,:)-f(1:ny-1,:); 
 
%fy(1,:)=f(2,:)-f(1,:); % for the first row, use the forward difference

end

