function [R, G, B] = splitRGBChannels(I)

% Extract the three RGB channels
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% Display the three channels
figure;

subplot(1,3,1);
imshow(R);
title('R channel');

subplot(1,3,2);
imshow(G);
title('G channel');

subplot(1,3,3);
imshow(B);
title('B channel');

end