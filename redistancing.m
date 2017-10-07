function [ psi ] = redistancing( psi0, iterations )

% Sign function
epsilon = 1;
sign_function = psi0./sqrt(psi0.^2+epsilon^2);

% Initialization of psi
psi = psi0;

for it=1:iterations 
    psi_delta = entropy_upwind(sign_function,psi);
    delta_t = compute_CFL_redistancing(sign_function);
    psi = psi + delta_t*(sign_function - psi_delta); 
end


end

function [ dt ] = compute_CFL_redistancing( sig_func ) 
dt = 1/(sqrt(2)); 
end

