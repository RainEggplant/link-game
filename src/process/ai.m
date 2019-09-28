function step = ai(realcapture)   
    % --------- �������˵��  -------- %
    
    %   realcapture������ͷ�����ͼ�񣨾��󣩣������ʽ��rgb��ycbcr��Ҷ�
    %   �����user_camera�����ķ���ֵ��Ҳ��realcapture������
 
    % --------- �������˵��  -------- %
    
    %   ������Ĳ�������step������,��ʽ���£�
    %   ����ǰ���޷��ҵ����������Ŀ飬��step = -1
    %   ����step�����ĸ����������(step(1), step(2))�루step(3), step(4)��λ�õĿ�����
    %   ʾ���� step = [1 1 1 2];  
    %   ��ʾ��ǰ����Ϊ���±�Ϊ(1,1)��(1,2)�Ŀ�����
    
    %   ע���±�(a, b)����Ϸͼ���ж�Ӧ���������½�Ϊԭ�㽨��ֱ������ϵ��
    %   x�᷽���a����y�᷽���b���Ŀ�
    
    %% --------------  �������������Ĵ��� ------------ %
    addpath('../../src/linkgame');
    addpath('../../src/process');
    persistent steps;
    persistent counter;
    if isempty(counter)
        % ��һ�ε��ñ���������ȡͼƬ������������������
        counter = 1;
        [segments, segment_locs] = segment_image( ...
            realcapture, 0.6, 0.3, 10);
        display(size(segments));
        corrs = calc_corrs(segments, 20, 0.35, 0.1);
        [game_mat, patterns] = map_to_matrix( ...
            size(segments), corrs, 0.8);
        game_mat = flipud(game_mat);
        steps = omg(game_mat);
        display(steps);
    else
        counter = counter+1;
    end
    
    if counter <= steps(1)
        step = steps([counter*4-1, counter*4-2, counter*4+1, counter*4]);
        display(step);
    else
        step = -1;
        clear counter;
    end
end
