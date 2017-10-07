function fx=Dx_backward(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[0 1],'replicate','pre');
nx=size(f,2); 
fx=zeros(ny0,nx0); 
fx(:,1:nx0)=f(:,2:nx)-f(:,1:nx-1); 
 
%fx(:,1)=f(:,2)-f(:,1); % for the first column, use the forward difference

end

