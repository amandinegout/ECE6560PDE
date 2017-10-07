function [ norm_grad ] = entropy_upwind(phi,f)

fxb = Dx_backward(f);
fxf = Dx_forward(f);
fyb = Dy_backward(f);
fyf = Dy_forward(f);

norm_grad = max(phi,0).*sqrt(max(fxb,0).^2+min(fxf,0).^2+max(fyb,0).^2+ ...
    min(fyf,0).^2)+ min(phi,0).*sqrt(min(fxb,0).^2+max(fxf,0).^2+ ...
    min(fyb,0).^2+ max(fyf,0).^2);
% norm_grad = (phi>0).*sqrt(max(fxb,0).^2+min(fxf,0).^2+max(fyb,0).^2+ ...
%     min(fyf,0).^2)+ (phi<0).*sqrt(min(fxb,0).^2+max(fxf,0).^2+ ...
%     min(fyb,0).^2+ max(fyf,0).^2);


end

