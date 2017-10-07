% C is the matrix containing the data that define the contour lines of phi
% h is the contour object of phi

function [C,h] = plot_image_psi(Iin,psi,i)
    
    figure(i);
    colormap(gray);
    imagesc(uint8(Iin));
    axis([1 size(Iin,2) 1 size(Iin,1)]);
    daspect([1 1 1]);
    hold on
    [C,h] = contour(psi, [0 0], 'r','LineWidth',1); % display isolines of matrix phi
    hold off 
end

