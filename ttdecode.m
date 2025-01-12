% ttdecode
% frq: discrete frequencies for touch-tone signals 
% sig: touch-tone signal, 1x7600
function num=ttdecode(frq, sig)
    phone_no = zeros(1, 7);
    tones = zeros(7, 1000);
    start = 1;
    
    for i=1:7
        tones(i, :) = sig(start : start+999);
        start = start + 1100;
    end

    for r = 1:7
        r_ind = 0;
        c_ind = 0;
        sig = tones(r, :);
        Y_sig = abs(fftshift(fft(sig, 2048))).^2;
        Y_sig_pos = Y_sig(1025:end);
        % col value is the highest freq
        % find the index of the two strongest
        % frequencies
        % assign the larger index to col
        % smaller one to row
        [max_1, max_1_ind] = max(Y_sig_pos);
        Y_sig_pos(max_1_ind) = 0;
        max_1_ind = max_1_ind * 2 * pi / 2048; % scale index
        
        [max_2, max_2_ind] = max(Y_sig_pos);
        max_2_ind = max_2_ind * 2 * pi / 2048; % scale index
        if max_2_ind >  max_1_ind
            c_ind = max_2_ind;
            r_ind = max_1_ind;
        else
            c_ind = max_1_ind;
            r_ind = max_2_ind;
        end
        for j = 1:10
            % can do numerical approximation since 
            % none of the r, c values are 1% within any other value
            if (((frq(j, 1) * 99/100)<r_ind) && (r_ind < (frq(j, 1) * 101/100)))...
                    && (((frq(j, 2) * 99/100)<c_ind) && (c_ind < (frq(j, 2) * 101/100)))
                phone_no(r) = j-1;%0 vs 1 indexing
                break;
            end
        end
    end
    num = phone_no;
end