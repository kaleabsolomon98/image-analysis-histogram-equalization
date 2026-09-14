function Inew = myhisteq(I)

% Calculate histogram
h = imhist(I);

% Calculate cumulative distribution function
probailityVector = h / sum(h);
cdf = cumsum(probailityVector);

% Create lookup table
T = zeros(256,1);

% Calculate the new value for every gray level
% in this formula we need non-zero minimum for cdf
cdfNonZeroMIN = min(cdf(cdf > 0));
for i = 1:256

    newValue = round( ...
        (cdf(i) - cdfNonZeroMIN) / ...
        (1 - cdfNonZeroMIN) * 255);

    T(i) = newValue;

end

% Replace every old pixel with its corresponding new value
Inew = T(I + 1);

% Convert result to uint8 to convert negative values to zero
Inew = uint8(Inew);

end