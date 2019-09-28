function step = ai(realcapture)   
    % --------- 输入参数说明  -------- %
    
    %   realcapture是摄像头捕获的图像（矩阵），具体格式是rgb、ycbcr或灰度
    %   由你的user_camera函数的返回值（也叫realcapture）决定
 
    % --------- 输出参数说明  -------- %
    
    %   计算出的操作放在step数组里,格式如下：
    %   若当前已无法找到可以相连的块，则step = -1
    %   否则step里有四个数，代表把(step(1), step(2))与（step(3), step(4)）位置的块相连
    %   示例： step = [1 1 1 2];  
    %   表示当前步骤为把下标为(1,1)和(1,2)的块相连
    
    %   注意下标(a, b)在游戏图像中对应的是以左下角为原点建立直角坐标系，
    %   x轴方向第a个，y轴方向第b个的块
    
    %% --------------  请在下面加入你的代码 ------------ %
    addpath('../../src/linkgame');
    addpath('../../src/process');
    persistent steps;
    persistent counter;
    if isempty(counter)
        % 第一次调用本函数，读取图片，生成所有消除步骤
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
