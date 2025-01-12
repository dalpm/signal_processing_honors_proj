% ttdecode_hard
% frq: discrete frequencies for touch-tone signals 
% sig: touch-tone signal, length unknown
function num=ttdecode_hard(frq, sig)
    phone_no = zeros(1, 7);
    tones = {}; % using a cell since length of a single tone is unknown
    start = 1;
    seen = 0;
    i = 1;
    %skip the zeros at the beginning
    while i < length(sig)
        if sig(i) == 0
            i = i + 1;
        else
            break
        end
    end
    sig = sig(i:end);
    j = 1;
    while j < length(sig)
        % skip zeros if not continuous
        % do not need to check for out of bounds indexing 
        % since the start and end of signals are non-zero tones
        if sig(j)==0 && sig(j-1)~=0 && sig(j+1)~=0
            j=j+1;
        end
        % rest of the logic for detectinf 
        if sig(j)~=0 && seen
            seen = 0;
            start = j;
            j = j + 100;
        elseif sig(j)~=0 && ~seen
            j = j + 1;
        elseif sig(j)==0 && seen
            j = j + 1;
        else
            tones = [tones; sig(start:j-1)];
            seen = 1;
            j = j + 100;
        end
    end
    % for the last digit
    tones = [tones; sig(start:end)];

    for r = 1:7
        r_ind = 0;
        c_ind = 0;
        sig = tones{r};
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
                phone_no(r) = j-1; %0 vs 1 indexing
                break;
            end
        end
    end
    num = phone_no;
end