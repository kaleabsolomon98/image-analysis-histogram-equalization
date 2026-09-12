function Inew = myhisteq(I)

% Calculate histogram
h = imhist(I);

% Calculate cumulative distribution function
cdf = cumsum(h);

% Create lookup table
T = zeros(256,1);

% Calculate the new value for every gray level
for i = 1:size(cdf,1)

    newValue = round( ...
        ((cdf(i) - cdf(1)) / ...
        (cdf(end) - cdf(1))) * 255);

    T(i) = newValue;

end

% Replace every old pixel with its corresponding new value
Inew = T(double(I) + 1);

% Convert result to uint8
Inew = uint8(Inew);

end