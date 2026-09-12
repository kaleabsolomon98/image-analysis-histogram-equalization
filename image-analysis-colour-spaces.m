% Read the image
I = imread('images/toysflash.png');


%% QUESTION 2 - Colour Spaces

% Display the original image
figure('Name','Original RGB Image');
imshow(I);
title('Original RGB Image');


% RGB colour space
figure('Name','RGB Colour Space');
colorcloud(I, 'rgb');
title('RGB Colour Space');


% Convert RGB to HSV
% I_hsv = rgb2hsv(I);
% 
% figure('Name','HSV Colour Space');
% colorcloud(I_hsv, 'hsv');
% title('HSV Colour Space');
% 
% 
% % Convert RGB to YCbCr
% I_ycbcr = rgb2ycbcr(I);
% 
% figure('Name','YCbCr Colour Space');
% colorcloud(I_ycbcr, 'ycbcr');
% title('YCbCr Colour Space');
% 
% 
% % Convert RGB to L*a*b*
% I_lab = rgb2lab(I);
% 
% figure('Name','L*a*b* Colour Space');
% colorcloud(I_lab, 'lab');
% title('L*a*b* Colour Space');


%% QUESTION 3 - Split the RGB image into three channels

[R_values, G_values, B_values] = splitRGBChannels(I);


%% QUESTION 4 - Otsu thresholding on R, G and B

% Calculate Otsu threshold for each channel
TR = graythresh(R_values);
TG = graythresh(G_values);
TB = graythresh(B_values);

% Create binary images
binaryImageR = imbinarize(R_values, TR);
binaryImageG = imbinarize(G_values, TG);
binaryImageB = imbinarize(B_values, TB);

% Display the three Otsu segmentation results
figure('Name','Otsu Thresholding - RGB Channels');

subplot(1,3,1);
imshow(binaryImageR);
title('Otsu - R');

subplot(1,3,2);
imshow(binaryImageG);
title('Otsu - G');

subplot(1,3,3);
imshow(binaryImageB);
title('Otsu - B');


%% QUESTION 5 - Convert RGB to HSV

I_hsv = rgb2hsv(I);

% Extract the three HSV channels
H = I_hsv(:,:,1);
S = I_hsv(:,:,2);
V = I_hsv(:,:,3);


%% QUESTION 6 - Otsu thresholding on H, S and V

% Calculate Otsu threshold for each channel
TH = graythresh(H);
TS = graythresh(S);
TV = graythresh(V);

% Create binary images
binaryImageH = imbinarize(H, TH);
binaryImageS = imbinarize(S, TS);
binaryImageV = imbinarize(V, TV);

% Display the three Otsu segmentation results
figure('Name','Otsu Thresholding - HSV Channels');

subplot(1,3,1);
imshow(binaryImageH);
title('Otsu - H');

subplot(1,3,2);
imshow(binaryImageS);
title('Otsu - S');

subplot(1,3,3);
imshow(binaryImageV);
title('Otsu - V');


%% QUESTION 7a - R + B Colour Segmentation

% Interactive segmentation using Red and Blue channels
colorseg_RB(I);


%% QUESTION 7b - S + V Colour Segmentation

% Interactive segmentation using Saturation and Value channels
colorseg_SV(I);