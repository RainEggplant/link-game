function realcapture = user_camera()
    global cam_ip;    % 需要提前在工作区定义全局变量 cam_ip
    persistent cam;   % cam 是静态变量
    % 如果空则说明第一次调用本函数，创建新的视频对象，这样做是为了避免重复生成，提高执行速度
    if isempty(cam)
        cam = ipcam(cam_ip);
        pause(5);
    end
    realcapture = snapshot(cam);
    realcapture = rgb2gray(realcapture);
    width = size(realcapture, 1);
    realcapture = realcapture(:, 1:round(width*1.32));
end
