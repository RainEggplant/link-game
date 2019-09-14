function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== ����˵�� ==========================
    
    % ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % ��ͬ�����ִ�����ͬ��ͼ����0 ����˴�û�п顣
    % ������ [m, n] = size(mtx) ��ȡ������������
    % (x1, y1) �� (x2, y2) Ϊ���жϵ�������±꣬���ж� mtx(x1, y1) ��
    % mtx(x2, y2) �Ƿ������ȥ��
    
    % ע�� mtx ��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±� (x1, y1) ��������������
    % ������������½�Ϊԭ�㽨������ϵ��x �᷽��� x1 ����y �᷽��� y1 ��
    
    % ������� bool = 1 ��ʾ������ȥ��bool = 0 ��ʾ������ȥ��
    
    %% �����������Ĵ��� O(��_��)O
    
    % [m, n] = size(mtx);
    
    bool = mtx(x1, y1) == mtx(x2, y2) && ...
            (direct_link(mtx, x1, y1, x2, y2) || ...
            turn_link(mtx, x1, y1, x2, y2) || ...
            double_turn_link(mtx, x1, y1, x2, y2));
end

function bool = direct_link(mtx, x1, y1, x2, y2)
    if (x1 == x2)
        bool = ~any(mtx(x1, min(y1, y2)+1 : max(y1, y2)-1));
    elseif (y1 == y2)
        bool = ~any(mtx(min(x1, x2)+1 : max(x1, x2)-1, y1));
    else
        bool = false;
    end
end

function bool = turn_link(mtx, x1, y1, x2, y2)
    bool = (mtx(x1, y2) == 0 && ...
            direct_link(mtx, x1, y1, x1, y2) && ...
            direct_link(mtx, x1, y2, x2, y2)) || ...
            (mtx(x2, y1) == 0 && ...
            direct_link(mtx, x1, y1, x2, y1) && ...
            direct_link(mtx, x2, y1, x2, y2));
end

function bool = double_turn_link(mtx, x1, y1, x2, y2)
    % �� mtx �������ĸ���������չ 1 ��
    mtx_ext = padarray(mtx, [1, 1]);
    [m, n] = size(mtx_ext);
    x1_ext = x1+1;
    y1_ext = y1+1;
    x2_ext = x2+1;
    y2_ext = y2+1;
    x_min = x1_ext;
    x_max = x1_ext;
    y_min = y1_ext;
    y_max = y1_ext;
    
    while x_min > 1 && mtx_ext(x_min-1, y1_ext) == 0
        x_min = x_min-1;
    end
    
    while x_max < m && mtx_ext(x_max+1, y1_ext) == 0
        x_max = x_max+1;
    end
    
    while y_min > 1 && mtx_ext(x1_ext, y_min-1) == 0
        y_min = y_min-1;
    end
    
    while y_max < n && mtx_ext(x1_ext, y_max+1) == 0
        y_max = y_max+1;
    end
    
    for x = x_min:x_max
       if (turn_link(mtx_ext, x, y1_ext, x2_ext, y2_ext))
           bool = true;
           return;
       end
    end
    
    for y = y_min:y_max
       if (turn_link(mtx_ext, x1_ext, y, x2_ext, y2_ext))
           bool = true;
           return;
       end
    end
    
    bool = false;
end