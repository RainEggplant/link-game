function realcapture = user_camera()
    global cam_ip;    % ��Ҫ��ǰ�ڹ���������ȫ�ֱ��� cam_ip
    persistent cam;   % cam �Ǿ�̬����
    % �������˵����һ�ε��ñ������������µ���Ƶ������������Ϊ�˱����ظ����ɣ����ִ���ٶ�
    if isempty(cam)
        cam = ipcam(cam_ip);
        pause(5);
    end
    realcapture = snapshot(cam);
    realcapture = rgb2gray(realcapture);
    width = size(realcapture, 1);
    realcapture = realcapture(:, 1:round(width*1.32));
end
