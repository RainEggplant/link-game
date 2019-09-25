function segment_camera()
    img = imread('../../resources/process/graycapture.jpg');
    
    % ��ֵ��ͼ������ȥ��������ǿ�Աȶ�
    img_b = imbinarize(img, 0.8);
    % ��ˮƽ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    row_avg = 1-mean(img_b, 1);
    figure;
    plot(row_avg);
    title('��ɫ���ƽ���Ҷ�ֵ��ˮƽ��');
    
    % Ѱ�壬��ô�ֱ�ָ�������
    [~, col_locs] = findpeaks(row_avg, 'MinPeakProminence', 0.3, ...
        'MaxPeakWidth', 10);
    n_col = length(col_locs)-1;
    
    % ��ֱ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    col_avg = 1-mean(img_b, 2);
    figure;
    plot(col_avg);
    title('��ɫ���ƽ���Ҷ�ֵ����ֱ��');
    
    % Ѱ�壬���ˮƽ�ָ�������
    [~, row_locs] = findpeaks(col_avg, 'MinPeakProminence', 0.3, ...
        'MaxPeakWidth', 10);
    n_row = length(row_locs)-1;
    
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