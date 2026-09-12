%% QUESTION 1 - Histogram Equalization

% Load the image
I = imread('images/greytoys.png');


%% Original image

figure;

subplot(2,3,1);
imshow(I);
title('Original Image');


%% Original histogram

h = imhist(I);

subplot(2,3,2);
bar(0:255, h);
xlim([0 255]);
xlabel('Gray value');
ylabel('Number of pixels');
title('Original Histogram');


%% Original empirical CDF

cdf = cumsum(h);

% Normalize CDF
cdfNormalized = cdf / cdf(end);

subplot(2,3,3);
plot(0:255, cdfNormalized);
xlim([0 255]);
ylim([0 1]);
xlabel('Gray value');
ylabel('CDF');
title('Original CDF');


%% My histogram equalization

Inew = myhisteq(I);


%% Equalized image

subplot(2,3,4);
imshow(Inew);
title('My Equalized Image');


%% Equalized histogram

h1 = imhist(Inew);

subplot(2,3,5);
bar(0:255, h1);
xlim([0 255]);
xlabel('Gray value');
ylabel('Number of pixels');
title('My Equalized Histogram');


%% Equalized empirical CDF

cdf1 = cumsum(h1);

% Normalize CDF
cdf1Normalized = cdf1 / cdf1(end);

subplot(2,3,6);
plot(0:255, cdf1Normalized);
xlim([0 255]);
ylim([0 1]);
xlabel('Gray value');
ylabel('CDF');
title('Equalized CDF');


%% Compare with MATLAB's histeq

Ihisteq = histeq(I, 64);

figure;

subplot(1,2,1);
imshow(Inew);
title('My Histogram Equalization');

subplot(1,2,2);
imshow(Ihisteq);
title('MATLAB histeq (64 bins)');