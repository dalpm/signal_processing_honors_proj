%% Question 1(b)
[img cmap] = imread("boy_noisy.gif", 'Frames', 'all');

s1 = 512*512;
sort_m = zeros(1, s1);
Y = fft2(img);
abs_Y = abs(Y);
k = 1;
for i=1:512
    for j=1:512
        sort_m(k) = abs_Y(i, j);
        % trial and error
        if abs_Y(i, j) > 2000000
            Y(i, j) = 0;
        end
        k = k + 1;
    end
end
% only to investigate the magnitudes
sorted = sort(sort_m, "descend");
Z = ifft2(Y);

tiledlayout(1, 2);
nexttile
imshow(img, cmap)
title("Noisy Image")
nexttile
% increasing brightness in the image
Z = Z + 60; 
imshow(Z, cmap)
title("Image after De-Noising")