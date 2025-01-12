% Box Blur with an n x n mask
% mat: image as matlab data structure
% n: size of mask, odd positive integer
function im = box_blur(mat, n)
    % init mask
    mask = 1/(n*n) * ones(n,n);
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