function [ energy ] = compute_energy( psi,phi,alpha )

energy_mat = (psi<0.5).*(psi>-0.5).*phi + alpha.*(psi<0).*phi;
energy = sum(sum(energy_mat));

end

