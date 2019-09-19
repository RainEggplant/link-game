function segment_screenshot()
    img = imread('../../resources/process/graygroundtruth.jpg');

    % 求水平方向的平均灰度值，并反色以便寻峰
    row_avg = 255-mean(img, 1);
    figure;
    plot(row_avg);
    title('反色后的平均灰度值（水平）');
    
    % 寻峰，获得垂直分割线坐标
    [~, col_locs] = findpeaks(row_avg, 'MinPeakProminence', 128);
    n_col = length(col_locs)-1;
    
    % 求垂直方向的平均灰度值，并反色以便寻峰
    col_avg = 255-mean(img, 2);
    figure;
    plot(col_avg);
    title('反色后的平均灰度值（垂直）');
    
    % 寻峰，获得水平分割线坐标
    [~, row_locs] = findpeaks(col_avg, 'MinPeakProminence', 128);
    n_row = length(row_locs)-1;
    row_width = (row_locs(end)-row_locs(1))/n_row;
    
    % 输出分割后的图像
    figure('Position',  [200 200 500 400]);
    idx = 1;
    for row = 1:n_row    
        for col = 1:n_col
            subplot(n_row, n_col, idx);
            imshow(img(row_locs(row):row_locs(row+1)-1, ...
                col_locs(col):col_locs(col+1)-1));
            idx = idx+1;
        end
    end    
end