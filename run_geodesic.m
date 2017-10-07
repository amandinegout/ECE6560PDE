clear all
close all;

% IMAGE
I0 = imread('cortex.png');  %-- load the image
SZ = size(I0);
I0 = rgb2gray(I0);
I0 = double(I0);

% Smoothing the image
sigma=1.2;    % scale parameter in Gaussian kernel 
I=imgaussfilt(I0,sigma);

% PARAMETERS
alpha = 0.4; % balloon force coefficient
niter = 4000; % Approximatively the number of required iterations. 
              % Size used to create vectors where results/measures are stored
redist_inter = 10; % Redistancing period

% INIT LEVEL SET 0
psi = init_levelset(SZ,'circle'); % Options : 'circle' or 'square'
% INIT LEVEL SET WITH A PRELOADED MAT
% psi_mat = load('./results/level_sel_psi.mat','psi');
% psi = psi_mat.psi;
plot_image_psi(I0,psi,1);

% POTENTIAL FUNCTION : EDGE DETECTOR
[Ix,Iy]=gradient(I); 
f=Ix.^2+Iy.^2; 
potential=(1./(1.0+f));
[grad_Ex,grad_Ey] = gradient(potential);

% REFERENCE CONTOUR
ref_contour = imread('cortex6.png');
ref_contour = im2bw(rgb2gray(ref_contour));

% MESURES
n_interval = 25; % Divisor of niter
energy_grad = zeros([4,niter/n_interval]);
contour_error = zeros([1,niter/n_interval]);
energy = zeros([1,niter/n_interval]);
test_alpha = zeros([3,9]);

% COMPUTE PHI
phi = potential;
grad_phiX = grad_Ex;
grad_phiY = grad_Ey;

% INITIALIZAION OF ERROR
psi_bw = 1-im2bw(psi);

% LEVEL FLOW UPDATE
current_error = sum(sum((psi_bw-ref_contour)));
stop_criterium = false;
i = 1;
while stop_criterium == false
    i
    if mod(i,redist_inter)==0
        psi=redistancing(psi, 10);
    end
    % LEVEL SET GRADIENT DESCENT 
    [psi,diffusion_energy_grad,advection_energy_grad,erosion_energy_grad] = ...
        gradient_descent(psi,phi,grad_phiX,grad_phiY,alpha);
    % Compute measures : energy gradient, energy, contour error
    if mod(i,n_interval)==0
        % Energy gradient
        energy_grad(1,i/n_interval) = diffusion_energy_grad;
        energy_grad(2,i/n_interval) = advection_energy_grad;
        energy_grad(3,i/n_interval) = erosion_energy_grad;
        energy_grad(4,i/n_interval) = diffusion_energy_grad+advection_energy_grad+...
            erosion_energy_grad;
        % Energy
        energy(i/n_interval) = compute_energy( psi,phi,alpha );
        % Normalized contour error (relative to object surface)
        psi_bw = 1-im2bw(psi);
        norm = sum(sum(ref_contour));
        current_error = sum(sum((psi_bw-ref_contour)))/norm;
        contour_error(i/n_interval) = current_error;
        % Stopping criterium
        if (i>n_interval*3)&&...
                (abs(energy_grad(4,i/n_interval)+energy_grad(4,i/n_interval-1)...
                -energy_grad(4,i/n_interval-2)-energy_grad(4,i/n_interval-3))<0.1)
            stop_criterium = true;
        end
    end
    i = i+1;
end
% FINAL CONTOUR PLOT
plot_image_psi(I0,psi,2);
save_pdf_image('final_contour');

save('./results/level_sel_psi.mat','psi');
save('./results/contour_error.mat','contour_error');
save('./results/energy_grad.mat','energy_grad');
save('./results/energy_.mat','energy');






