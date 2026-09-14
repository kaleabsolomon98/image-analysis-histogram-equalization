%load image
I = imread("images/greytoys.png");
imshow(I)
title('Original Image')

% Original histogram
h = imhist(I);
imhist(I)
title('Original Histogram');

%get probability vector
p = h / sum(h);

%calculate cdf
cdf = cumsum(p);

%our own equalization function
Inew = myhisteq(I);
imshow(Inew)
title('Our new equalized image')
imhist(Inew, 256)
title('Our new equalized histogram')

%compare with MATLAB's histeq 64 bins
Ihisteq = histeq(I, 64);
imshow(Ihisteq)
title('MATLAB histeq (64 bins)');
imhist(Ihisteq)
title('MATLAB histeq histogram (64 bins)');

%compare with MATLAB's histeq 64 bins
%MATLAB historically used 64 because it was usually enough to improve
%contrast. The result picture looks good. 
%So unnecessary calculations could
%be avoided
Ihisteq = histeq(I, 64);
imshow(Ihisteq)
title('MATLAB histeq (64 bins)');
imhist(Ihisteq)
title('MATLAB histeq histogram (64 bins)');

%compare with MATLAB's histeq 256 bins
Ihisteq256 = histeq(I, 256);
imshow(Ihisteq256)
title('MATLAB histeq (256 bins)');
imhist(Ihisteq256)
title('MATLAB histeq histogram (256 bins)');

%calculate new CDF
%get probability vector
hnew = imhist(Inew);
pnew = hnew / sum(hnew);
cdfNew = cumsum(pnew);

%Using subplot
figure
subplot (4, 3, 1)
imshow(I)
title('Original Image')
subplot (4, 3, 2)
imhist(I)
title('Original Histogram');
subplot (4, 3, 3)
plot(cdf)
title('Original CDF');
subplot (4, 3, 4)
imshow(Inew)
title('Our new equalized image')
subplot (4, 3, 5)
imhist(Inew, 256)
title('Our new equalized histogram')
subplot (4, 3, 6)
plot(cdfNew)
title('New equalized CDF');
subplot (4, 3, 7)
Ihisteq = histeq(I, 64);
imshow(Ihisteq)
title('MATLAB histeq (64 bins)');
subplot (4, 3, 8)
imhist(Ihisteq)
title('MATLAB histeq histogram (64 bins)');
subplot (4, 3, 10)
Ihisteq256 = histeq(I, 256);
imshow(Ihisteq256)
title('MATLAB histeq (256 bins)');
subplot (4, 3, 11)
imhist(Ihisteq256)
title('MATLAB histeq histogram (256 bins)');