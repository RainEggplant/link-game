function segment_screenshot()
    img = imread('../../resources/process/graygroundtruth.jpg');

    % ��ˮƽ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    row_avg = 255-mean(img, 1);
    figure;
    plot(row_avg);
    title('��ɫ���ƽ���Ҷ�ֵ��ˮƽ��');
    
    % Ѱ�壬��ô�ֱ�ָ�������
    [~, col_locs] = findpeaks(row_avg, 'MinPeakProminence', 128);
    n_col = length(col_locs)-1;
    
    % ��ֱ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    col_avg = 255-mean(img, 2);
    figure;
    plot(col_avg);
    title('��ɫ���ƽ���Ҷ�ֵ����ֱ��');
    
    % Ѱ�壬���ˮƽ�ָ�������
    [~, row_locs] = findpeaks(col_avg, 'MinPeakProminence', 128);
    n_row = length(row_locs)-1;
    row_width = (row_locs(end)-row_locs(1))/n_row;
    
    % ����ָ���ͼ��
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