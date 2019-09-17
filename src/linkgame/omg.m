function steps = omg(mtx)
    % -------------- �������˵�� --------------
    
    %   ��������У�mtx Ϊͼ���ľ������������ĸ�ʽ��
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    %   ������ [m, n] = size(mtx) ��ȡ������������
    
    %   ע��mtx��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±� (x1, y1) ��������������
    %   ������������½�Ϊԭ�㽨������ϵ��x �᷽��� x1 ����y �᷽��� y1 ��
    
    % --------------- �������˵�� --------------- %
    
    %   Ҫ�����ó��Ĳ���������� steps ������,��ʽ���£�
    %   steps(1) ��ʾ��������
    %   ֮��ÿ�ĸ��� x1 y1 x2 y2������� mtx(x1,y1) �� mtx(x2, y2) ��ʾ�Ŀ�������
    %   ʾ���� steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   ��ʾһ������������һ���� mtx(1, 1) �� mtx(1, 2) ��ʾ�Ŀ�������
    %   �ڶ����� mtx(2, 1) �� mtx(3, 1) ��ʾ�Ŀ�������
    
    %% --------------  �������������Ĵ��� O(��_��)O~  ------------
    
    steps(1) = 0;
    
    % ��ȡͼ������
    patterns = unique(mtx);
    patterns = patterns(patterns ~= 0);
    
    % ��ȡÿ��ͼ�����ֵ�λ��
    pos_of_pattern = {};
    for pattern = patterns'
        [x, y] = find(mtx == pattern);
        pos_of_pattern(end+1) = {[x, y]};
    end
    
    while true
        available = false;
        for k = 1:length(pos_of_pattern)
           pairs = pos_of_pattern{k};
           
           % �����ȶ�
           p1 = 1;
           while p1 <= length(pairs)
              p2 = p1+1;
              while p2 <= length(pairs)
                 pos_1 = pairs(p1, :);
                 pos_2 = pairs(p2, :);    
                 if detect(mtx, pos_1(1), pos_1(2), ...
                         pos_2(1), pos_2(2))
                     % �����ɹ�������� steps
                     steps(1) = steps(1) + 1;
                     steps = cat(2, steps, pos_1, pos_2);
                     
                     % �Ӿ����������¼���Ƴ������Ŀ�
                     mtx(pos_1(1),  pos_1(2)) = 0;
                     mtx(pos_2(1),  pos_2(2)) = 0;
                     pairs(p1, :) = [];
                     pairs(p2-1, :) = [];
                     p1 = p1-1;
                     
                     available = true;
                     break;
                 else
                    p2 = p2+1;
                 end
              end
              p1 = p1+1;
           end
           pos_of_pattern{k} = pairs;
        end
        
        if ~available
            % ����ѭ����û�м�⵽�������飬������������
            break;
        end
    end
end

