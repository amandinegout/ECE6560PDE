function [psi2,diffusion_energy,advection_energy,erosion_energy] = gradient_descent(psi1,phi,grad_phiX, ...
    grad_phiY,alpha)

% Diffusion
psi1x = Dx_centralediff(psi1); 
psi1y = Dy_centralediff(psi1);
psi1xy = Dx_centralediff(psi1y);  
psi1xx = Dx_forward(Dx_backward(psi1));
psi1yy = Dy_forward(Dy_backward(psi1));

diffusion_term = phi.*((psi1yy.*psi1x.^2-2*psi1y.*psi1x.*psi1xy + ...
    psi1xx.*psi1y.^2)./(psi1x.^2+psi1y.^2));
diffusion_energy_mat = (-0.5<psi1<0.5).*diffusion_term./sqrt(psi1x.^2+psi1y.^2);
diffusion_energy = sum(sum(diffusion_energy_mat));

% Advection
advection_term = upwind_diff(grad_phiX,grad_phiY,psi1);
advection_energy_mat = (-0.5<psi1<0.5).*advection_term./sqrt(psi1x.^2+psi1y.^2);
advection_energy = sum(sum(advection_energy_mat));

% Dilation/Erosion
erosion_term = alpha*entropy_upwind(phi,psi1);
erosion_energy_mat = (-0.5<psi1<0.5).*erosion_term./sqrt(psi1x.^2+psi1y.^2);
erosion_energy = sum(sum(erosion_energy_mat));

% CFL condition TO CHECK first value 0.1
% delta_t = 0.1; 
delta_t = compute_CFL_GAC(phi,alpha,grad_phiX,grad_phiY);

% Update from Gradient Descent
grad_energy = diffusion_term+advection_term+erosion_term;
psi2 = psi1+delta_t*(grad_energy);

end

function [dt] = compute_CFL_GAC(phi,alpha,grad_phiX,grad_phiY)

dt_diffusion = 0.5/max(max(abs(phi)));
dt_avection = 1/max(max(sqrt(grad_phiX.^2+grad_phiY.^2)));
dt_ern = 1/(sqrt(2)*alpha*max(max(abs(phi))));

dt = min([dt_diffusion,dt_avection,dt_ern]);

end
