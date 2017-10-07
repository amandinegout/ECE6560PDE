function fx = Dx_centralediff(f0)

[ny0,nx0]=size(f0); 
f = padarray(f0,[0 1],'replicate','both');
nx=size(f,2); 

fx=zeros(ny0,nx0); 
fx(:,1:nx0)=0.5*(f(:,3:nx)-f(:,1:nx-2)); 

%fx(:,nx) = f(:,nx)-f(:,nx-1);  % for the last column, use the backward difference 
%fx(:,1)=f(:,2)-f(:,1); % for the first column, use the forward difference

end

