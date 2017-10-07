function fx=Dx_forward(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[0 1],'replicate','post');
nx=size(f,2); 
fx=zeros(ny0,nx0); 
fx(:,1:nx0)=f(:,2:nx)-f(:,1:nx-1); 

%fx(:,nx) = f(:,nx)-f(:,nx-1);  % for the last column, use the backward difference 
end

