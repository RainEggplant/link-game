function segments = segment_image(...
    img, BinThreshold, MinPeakProminence, MaxPeakWidth)
    % ��ֵ��ͼ������ȥ��������ǿ�Աȶ�
    img_b = imbinarize(img, BinThreshold);
    % ��ˮƽ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    row_avg = 1-mean(img_b, 1);
    % Ѱ�壬��ô�ֱ�ָ�������
    [~, col_locs] = findpeaks(row_avg, ...
        'MinPeakProminence', MinPeakProminence, ...
        'MaxPeakWidth', MaxPeakWidth);
    n_col = length(col_locs)-1;
    
    % ��ֱ�����ƽ���Ҷ�ֵ������ɫ�Ա�Ѱ��
    col_avg = 1-mean(img_b, 2);  
    % Ѱ�壬���ˮƽ�ָ�������
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