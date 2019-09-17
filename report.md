# MATLAB 连连看实验

> 无 76	RainEggplant	2017\*\*\*\*\*\*



## 制作自己的连连看

### 1. 熟悉游戏

游戏界面如下，图中已经消去了几对方块。

<img src="report.assets/linkgame/1-gameview.png" style="zoom:60%" />



### 2. 实现检测块是否消除的 `detect.m`

连连看可消除的模式如下：

![](report.assets/linkgame/2-link_modes.png)



我们先来关注三种连接方式。对于第一种连接方式，只用判断待连接块间是否全为空即可。代码如下：

```matlab
function bool = direct_link(mtx, x1, y1, x2, y2)
    if (x1 == x2)
        bool = ~any(mtx(x1, min(y1, y2)+1 : max(y1, y2)-1));
    elseif (y1 == y2)
        bool = ~any(mtx(min(x1, x2)+1 : max(x1, x2)-1, y1));
    else
        bool = false;
    end
end
```



对于第二种连接方式，可以这样思考：观察以两个待连接块为对角线构成的矩形的另外两个顶点，若其中任意一个顶点为空且能够与两个待连接块直连，则该种连接方式成立。代码如下：

```matlab
function bool = turn_link(mtx, x1, y1, x2, y2)
    bool = (mtx(x1, y2) == 0 && ...
            direct_link(mtx, x1, y1, x1, y2) && ...
            direct_link(mtx, x1, y2, x2, y2)) || ...
            (mtx(x2, y1) == 0 && ...
            direct_link(mtx, x1, y1, x2, y1) && ...
            direct_link(mtx, x2, y1, x2, y2));
end
```



对于第三种连接方式，判定过程如下：

1. 因为下一步待延伸的块可能处于边缘，所以需要先将矩阵向上下左右四个方向零扩展 1 格，即调用 `padarray(mtx, [1, 1])`。
2. 选取待连接块之一，向上下左右的空白处进行最大可能的延伸。
3. 遍历延伸路径上的块，判断其与另一个待连接块间是否存在第二种连接方式。
4. 若存在，则该种连接方式成立。若遍历结束也没有找到存在第二种连接方式，则该种连接方式不成立。

代码如下：

```matlab
function bool = double_turn_link(mtx, x1, y1, x2, y2)
    % 将 mtx 矩阵向四个方向零扩展 1 格
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
```



因此，`detect` 函数的实现代码如下：

```matlab
function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== 参数说明 ==========================
    
    % 输入参数中，mtx为图像块的矩阵，类似这样的格式：
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % 相同的数字代表相同的图案，0 代表此处没有块。
    % 可以用 [m, n] = size(mtx) 获取行数和列数。
    % (x1, y1) 与 (x2, y2) 为需判断的两块的下标，即判断 mtx(x1, y1) 与
    % mtx(x2, y2) 是否可以消去。
    
    % 注意 mtx 矩阵与游戏区域的图像不是位置对应关系。下标 (x1, y1) 在连连看界面中
    % 代表的是以左下角为原点建立坐标系，x 轴方向第 x1 个，y 轴方向第 y1 个
    
    % 输出参数 bool = 1 表示可以消去，bool = 0 表示不能消去。
    
    %% 在下面添加你的代码 O(∩_∩)O
    
    % [m, n] = size(mtx);
    
    bool = mtx(x1, y1) == mtx(x2, y2) && ...
            (direct_link(mtx, x1, y1, x2, y2) || ...
            turn_link(mtx, x1, y1, x2, y2) || ...
            double_turn_link(mtx, x1, y1, x2, y2));
end
```



以上代码位于 `src/linkgame/detect.m`, 为了能进行测试，我在 `resources/linkgame` 下建立了符号链接，并将 `detect.p` 更名为 `detect.p.example` 。运行 `linkgame.p` 测试一局，算法正确。



### 3. 实现外挂 `omg.m`

外挂的实现采用了一种简单的算法。步骤如下：

1. 统计连连看中包含的方块的种类，即获取 `mtx` 矩阵中出现过的所有非 0 项。

2. 统计每种方块出现位置的坐标，归类放入元胞数组 `pos_of_pattern` 中。

3. 进入循环

   - 从第一种图案开始，将其所有的出现位置两两配对，检查是否能相消。若能，则输出到 `steps` 数组。

   - 一种图案处理完成后，接着处理下一种图案。

   - 所有种类图案都处理完一次后，如果都没有发生消除，则跳出循环并返回；否则，回到 3，开始新一轮循环。



`omg` 函数的代码如下：

```matlab
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
```



以上代码位于 `src/linkgame/omg.m`, 为了能进行测试，我在 `resources/linkgame` 下建立了符号链接，并将 `omg.p` 更名为 `omg.p.example` 。运行 `linkgame.p` 测试一局自动模式，算法正确。

