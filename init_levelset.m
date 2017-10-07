function [ psi0 ] = init_levelset( size_im,shape )

[X,Y] = meshgrid(1:size_im(2),1:size_im(1));
radius = min(size_im(2),size_im(1))/2;
center = [radius*(size_im(1)/size_im(2)) radius];

if strcmp(shape,'circle')
    psi0 = sqrt((X-center(2)).^2+(Y-center(1)).^2)-radius*(7/8);
elseif strcmp(shape,'square')
    psi0 = max( abs(X-center(2)), abs(Y-center(1)) ) - (1/2)*radius;
    % psi0 = max( abs(X-center(2)), abs(Y-center(1)) ) - radius;
else 
    error('ERROR : uncorrect initialization of psi0. Expected : circle or square');
end


end

