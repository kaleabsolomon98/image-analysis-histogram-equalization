%% COLOUR SPACES

% Read the image
I = imread('images/toysflash.png');


%% Explore colour spaces

% Original RGB image
figure('Name','Original RGB Image');
imshow(I);
title('Original RGB Image');


% RGB colour space
figure('Name','RGB Colour Space');
colorcloud(I, 'rgb');
title('RGB Colour Space');


% HSV colour space
figure('Name','HSV Colour Space');
colorcloud(I, 'hsv');
title('HSV Colour Space');


% YCbCr colour space
figure('Name','YCbCr Colour Space');
colorcloud(I, 'ycbcr');
title('YCbCr Colour Space');


% L*a*b* colour space
figure('Name','L*a*b* Colour Space');
colorcloud(I, 'lab');
title('L*a*b* Colour Space');


%% Split RGB image into three channels

[R_values, G_values, B_values] = splitRGBChannels(I);


%% Otsu thresholding on R, G and B channels

% Calculate Otsu threshold for each RGB channel
TR = graythresh(R_values);
TG = graythresh(G_values);
TB = graythresh(B_values);

% Create binary segmentation images
binaryImageR = imbinarize(R_values, TR);
binaryImageG = imbinarize(G_values, TG);
binaryImageB = imbinarize(B_values, TB);

% Display segmentation results
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


%% Convert RGB image to HSV

I_hsv = rgb2hsv(I);

% Extract HSV channels
H = I_hsv(:,:,1);
S = I_hsv(:,:,2);
V = I_hsv(:,:,3);


%% Otsu thresholding on H, S and V channels

% Calculate Otsu threshold for each HSV channel
TH = graythresh(H);
TS = graythresh(S);
TV = graythresh(V);

% Create binary segmentation images
binaryImageH = imbinarize(H, TH);
binaryImageS = imbinarize(S, TS);
binaryImageV = imbinarize(V, TV);

% Display segmentation results
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


%% QUESTION 7 - Best single-channel segmentation

% Inspect the RGB and HSV Otsu results above.
% Select the channel where the white ball is segmented best.
%
% Include the best segmentation result in the lab report.


%% QUESTION 8 - R+B segmentation

% Interactive segmentation using Red and Blue channels
colorseg_RB(I);


%% QUESTION 8 - S+V segmentation

% Interactive segmentation using Saturation and Value channels
colorseg_SV(I);