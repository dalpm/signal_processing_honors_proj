% Laplacian Blur with an 3 x 3 mask
% mat: image as matlab data structure
% ch: choice of mask 1 or 2
function im = laplacian_blur(mat, ch)
    mask = [];
    % init mask
    if ch==1
        mask = [0 1 0; 1 -4 1; 0 1 0];
    elseif ch==2
        mask = [1 1 1; 1 -8 1; 1 1 1];
    end
    n = 3;
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
    % normalize the image since there are negative values
    ret = ret - min(ret, [],"all");
    ret = ret .* (255 / max(ret, [],"all"));
    im = ret;
end