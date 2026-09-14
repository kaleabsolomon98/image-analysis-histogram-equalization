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

cropSize = min(rows, columns);

startRow = floor((rows - cropSize) / 2) + 1;
startColumn = floor((columns - cropSize) / 2) + 1;

squareImage = doubleGrayToyImage( ...
    startRow:startRow + cropSize - 1, ...
    startColumn:startColumn + cropSize - 1);


%% 4. Resize image to 128 x 128

imageSize = 128;

resizedImage = imresize(squareImage, [imageSize imageSize]);


%% 5. Create padded image

windowSize = 5;

% A 5 x 5 window needs 2 extra pixels on every side
borderSize = floor(windowSize / 2);

paddedSize = imageSize + 2 * borderSize;

paddedImage = zeros(paddedSize, paddedSize);


%% Put the original 128 x 128 image in the centre

paddedImage( ...
    borderSize + 1:borderSize + imageSize, ...
    borderSize + 1:borderSize + imageSize) = resizedImage;


%% Replicate the top border

paddedImage( ...
    1:borderSize, ...
    borderSize + 1:borderSize + imageSize) = ...
    repmat(resizedImage(1, :), borderSize, 1);


%% Replicate the bottom border

paddedImage( ...
    borderSize + imageSize + 1:end, ...
    borderSize + 1:borderSize + imageSize) = ...
    repmat(resizedImage(end, :), borderSize, 1);


%% Replicate the left border

paddedImage(:, 1:borderSize) = ...
    repmat(paddedImage(:, borderSize + 1), 1, borderSize);


%% Replicate the right border

paddedImage(:, borderSize + imageSize + 1:end) = ...
    repmat(paddedImage(:, borderSize + imageSize), 1, borderSize);


%% Check image sizes

disp('Size of resized image:');
disp(size(resizedImage));

disp('Size of padded image:');
disp(size(paddedImage));


%% 6. Mean filtering

filteredImage = zeros(imageSize, imageSize);

for row = borderSize + 1:size(paddedImage, 1) - borderSize

    for column = borderSize + 1:size(paddedImage, 2) - borderSize

        % Take a 5 x 5 neighbourhood
        window = paddedImage( ...
            row - borderSize:row + borderSize, ...
            column - borderSize:column + borderSize);

        % Calculate the sum of the 25 pixels manually
        summation = 0;

        for index = 1:numel(window)

            summation = summation + window(index);

        end

        % Calculate the mean and store it
        filteredImage( ...
            row - borderSize, ...
            column - borderSize) = ...
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