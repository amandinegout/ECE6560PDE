function [ output_advection ] = upwind_diff( V1,V2,psi)

% x_term = max(V1,0).*Dx_backward(psi)+min(V1,0).*Dx_forward(psi);
% y_term = max(V2,0).*Dy_backward(psi)+min(V2,0).*Dy_forward(psi);
x_term = max(V1,0).*Dx_forward(psi)+min(V1,0).*Dx_backward(psi);
y_term = max(V2,0).*Dy_forward(psi)+min(V2,0).*Dy_backward(psi);


output_advection = x_term+y_term;

end

