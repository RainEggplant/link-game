function [segments, segment_locs] = segment_image(...
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
    segment_locs = cell(n_row, n_col);
    for row = 1:n_row    
        for col = 1:n_col
            locs = [col_locs(col), row_locs(row), ...
                col_locs(col+1)-col_locs(col), ...
                row_locs(row+1)-row_locs(row)];
            segment_locs{row, col} = locs;
            segments{row, col} = img( ...
                locs(2):locs(2)+locs(4)-1, ...
                locs(1):locs(1)+locs(3)-1);
        end
    end    
end