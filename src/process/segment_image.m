function segments = segment_image(...
    img, BinThreshold, MinPeakProminence, MaxPeakWidth)
    % 二值化图像，以滤去噪声，增强对比度
    img_b = imbinarize(img, BinThreshold);
    % 求水平方向的平均灰度值，并反色以便寻峰
    row_avg = 1-mean(img_b, 1);
    % 寻峰，获得垂直分割线坐标
    [~, col_locs] = findpeaks(row_avg, ...
        'MinPeakProminence', MinPeakProminence, ...
        'MaxPeakWidth', MaxPeakWidth);
    n_col = length(col_locs)-1;
    
    % 求垂直方向的平均灰度值，并反色以便寻峰
    col_avg = 1-mean(img_b, 2);  
    % 寻峰，获得水平分割线坐标
    [~, row_locs] = findpeaks(col_avg, ...
        'MinPeakProminence', MinPeakProminence, ...
        'MaxPeakWidth', MaxPeakWidth);
    n_row = length(row_locs)-1;
    
    segments = cell(n_row, n_col);
    for row = 1:n_row    
        for col = 1:n_col
            segments{row, col} = img( ...
                row_locs(row):row_locs(row+1)-1, ...
                col_locs(col):col_locs(col+1)-1);
        end
    end    
end