% Gaussian Blur with an n x n mask
% mat: image as matlab data structure
% n: size of mask, 3 or 5
function im = gaussian_blur(mat, n)
    mask = [];
    % init mask
    if n==3
        mask = 1/16 * [1 2 1; 2 4 2;  1 2 1];
    elseif n==5
        mask = 1/159 * [2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];
    end
    % return object, borders init to white
    ret = 255 * ones(size(mat));
    [r, c] = size(mat);
    % border adjustment
    t = floor(n / 2) + 1;
    % nested for loop to iterate the whole image
    for i=1:r-(n-1)
        for j=1:c-(n-1)
            temp = mat(i:i+n-1, j:j+n-1);
            temp = sum(temp .* mask, "all");
            ret(i + n - t, j + n - t) = temp;
        end
    end
    im = ret;
end