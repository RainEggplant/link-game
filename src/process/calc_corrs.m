function corrs = calc_corrs(segments, order, freq, edge_factor)
    filter_2d = filter_high_pass(order, freq);
    segments_hf = cellfun(@(x) filter2(filter_2d, x, 'same'), ...
       segments, 'UniformOutput', false);
   
    n_segments = numel(segments_hf);
    corrs = zeros(n_segments*(n_segments-1)/2, 3);
    idx = 1;
    for k = 1:numel(segments_hf)-1
       for m = k+1:numel(segments_hf)
           img1 = segments_hf{k};
           img2 = segments_hf{m};
           cut_size = round(size(img1)*edge_factor);
           img1_s = img1(cut_size(1):end-cut_size(1), ...
               cut_size(2):end-cut_size(2));
           cut_size = round(size(img2)*edge_factor);
           img2_s = img2(cut_size(1):end-cut_size(1), ...
               cut_size(2):end-cut_size(2));
           c1 = normxcorr2(img1_s, img2);
           c2 = normxcorr2(img2_s, img1);
           corrs(idx, :) = [max(max(c1(:)), max(c2(:))), k, m];
           idx = idx+1;
       end
    end
    
    corrs = sortrows(corrs, 'descend'); 
end