figure(1);
hold on
plot(linspace(1,200,200),energy(4,:),linspace(1,200,200),energy(3,:),...
    linspace(1,200,200),energy(2,:),linspace(1,200,200),energy(1,:));
title('Energy and its decomposition');
legend('Energy from erosion','Total energy','Energy from advection','Energy from diffusion');
hold off