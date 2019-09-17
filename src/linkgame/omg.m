function steps = omg(mtx)
    % -------------- 输入参数说明 --------------
    
    %   输入参数中，mtx 为图像块的矩阵，类似这样的格式：
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   相同的数字代表相同的图案，0代表此处没有块。
    %   可以用 [m, n] = size(mtx) 获取行数和列数。
    
    %   注意mtx矩阵与游戏区域的图像不是位置对应关系。下标 (x1, y1) 在连连看界面中
    %   代表的是以左下角为原点建立坐标系，x 轴方向第 x1 个，y 轴方向第 y1 个
    
    % --------------- 输出参数说明 --------------- %
    
    %   要求最后得出的操作步骤放在 steps 数组里,格式如下：
    %   steps(1) 表示步骤数。
    %   之后每四个数 x1 y1 x2 y2，代表把 mtx(x1,y1) 与 mtx(x2, y2) 表示的块相连。
    %   示例： steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   表示一共有两步，第一步把 mtx(1, 1) 和 mtx(1, 2) 表示的块相连，
    %   第二步把 mtx(2, 1) 和 mtx(3, 1) 表示的块相连。
    
    %% --------------  请在下面加入你的代码 O(∩_∩)O~  ------------
    
    steps(1) = 0;
    
    % 获取图案种类
    patterns = unique(mtx);
    patterns = patterns(patterns ~= 0);
    
    % 获取每种图案出现的位置
    pos_of_pattern = {};
    for pattern = patterns'
        [x, y] = find(mtx == pattern);
        pos_of_pattern(end+1) = {[x, y]};
    end
    
    while true
        available = false;
        for k = 1:length(pos_of_pattern)
           pairs = pos_of_pattern{k};
           
           % 两两比对
           p1 = 1;
           while p1 <= length(pairs)
              p2 = p1+1;
              while p2 <= length(pairs)
                 pos_1 = pairs(p1, :);
                 pos_2 = pairs(p2, :);    
                 if detect(mtx, pos_1(1), pos_1(2), ...
                         pos_2(1), pos_2(2))
                     % 消除成功，输出到 steps
                     steps(1) = steps(1) + 1;
                     steps = cat(2, steps, pos_1, pos_2);
                     
                     % 从矩阵与坐标记录中移除消除的块
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
            % 整轮循环都没有检测到可消除块，则跳出并返回
            break;
        end
    end
end

