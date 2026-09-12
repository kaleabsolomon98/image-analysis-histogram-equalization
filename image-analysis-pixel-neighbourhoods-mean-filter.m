clear;
clc;
close all;

%% 1. Load image
toysImage = imread('images/toysflash.png');

%% 2. Convert RGB image to grayscale and double
grayToysImage = rgb2gray(toysImage);
doubleGrayToyImage = im2double(grayToysImage);

%% 3. Crop image to a square

[rows, columns] = size(doubleGrayToyImage);

cropSize = columns - rows;

column1 = 1 + cropSize/2;
column2 = columns - cropSize/2;

squareImage = doubleGrayToyImage(:, column1:column2);

%% 4. Resize image to 128 x 128

imageSize = 128;

resizedImage = imresize(squareImage, [imageSize imageSize]);

%% 5. Create padded image
% We need 2 extra pixels on every side because the window is 5 x 5.

borderSize = 2;

paddedSize = imageSize + 2 * borderSize;

paddedImage = zeros(paddedSize, paddedSize);

%% Put the original 128 x 128 image in the centre

paddedImage(3:130, 3:130) = resizedImage;

%% Replicate the top border

paddedImage(1, 3:130) = resizedImage(1, :);
paddedImage(2, 3:130) = resizedImage(1, :);

%% Replicate the bottom border

paddedImage(131, 3:130) = resizedImage(128, :);
paddedImage(132, 3:130) = resizedImage(128, :);

%% Replicate the left border

paddedImage(:, 1) = paddedImage(:, 3);
paddedImage(:, 2) = paddedImage(:, 3);

%% Replicate the right border

paddedImage(:, 131) = paddedImage(:, 130);
paddedImage(:, 132) = paddedImage(:, 130);

%% Check image sizes

disp('Size of resized image:');
disp(size(resizedImage));

disp('Size of padded image:');
disp(size(paddedImage));

%% 6. Mean filtering

filteredImage = zeros(imageSize, imageSize);

windowSize = 5;

for row = 3:size(paddedImage, 1)-2

    for column = 3:size(paddedImage, 2)-2

        % Take a 5 x 5 neighbourhood
        window = paddedImage(row-2:row+2, column-2:column+2);

        % Calculate the sum of the 25 pixels
        summation = 0;

        for index = 1:numel(window)

            summation = summation + window(index);

        end

        % Calculate the mean
        filteredImage(row-2, column-2) = ...
            summation / (windowSize * windowSize);

    end

end

%% Check filtered image size

disp('Size of filtered image:');
disp(size(filteredImage));

%% 7. Calculate difference image

differenceImage = resizedImage - filteredImage;

%% 8. Display the results

figure;

tiledlayout(1,3);

%% Original image

nexttile;

imshow(resizedImage);

title('Original');

%% Mean filtered image

nexttile;

imshow(filteredImage);

title('Mean Filtered');

%% Difference image

nexttile;

imagesc(differenceImage);

axis image;

colorbar;

title('Difference');