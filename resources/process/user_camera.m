function realcapture = user_camera()
% ʹ��imaqhwinfo�ɷ��ظ���Ƶ����������Ϣ��
% ���磺
% InstalledAdaptors: {'matrox'  'winvideo'}
%         MATLABVersion: '7.4 (R2007a)'
%           ToolboxName: 'Image Acquisition Toolbox'
%        ToolboxVersion: '2.1 (R2007a)'

% ʹ�� info = imaqhwinfo(adaptor)�ɷ�����������Ϣ 
% ���磺
% info = imaqhwinfo('winvideo') ����
%        AdaptorDllName: [1x73 char]
%     AdaptorDllVersion: '2.1 (R2007a)'
%           AdaptorName: 'winvideo'
%             DeviceIDs: {[1]}
%            DeviceInfo: [1x1 struct]

% ʹ�� info = imaqhwinfo(adaptor, device_id) �ɷ��ض�Ӧ�豸��Ϣ
% ���磺
% dev_info = imaqhwinfo('winvideo', 1)����
%           DefaultFormat: 'RGB555_128x96'
%     DeviceFileSupported: 0
%              DeviceName: 'IBM PC Camera'
%                DeviceID: 1
%   VideoInputConstructor: 'videoinput('winvideo', 1)'
%  VideoDeviceConstructor: 'imaq.VideoDevice('winvideo', 1)'       
%        SupportedFormats: {1x34 cell}

% �� obj = videoinput(adaptor, device_id)�ɻ���豸����
% �磺obj = videoinput('winvideo', 1);
% Ȼ�� imaqhwinfo(obj)�ɷ��ض�����Ϣ
% ���磺
% obj_info = imaqhwinfo(obj)����
%                 AdaptorName: 'winvideo'
%                  DeviceName: 'IBM PC Camera'
%                   MaxHeight: 96
%                    MaxWidth: 128
%              NativeDataType: 'uint8'
%                TotalSources: 1
%     VendorDriverDescription: 'Windows WDM Compatible Driver'
%         VendorDriverVersion: 'DirectX 9.0'

% ��img = getsnapshot(obj);�ɻ������ͷ��ͼ���õ�����
% RGBͼ����YCbCrͼ��������ͷ�йأ���ͨ�������������imaqhwinfo�鿴

%% ���������޸���Ĵ���
    
    persistent obj;   % obj�Ǿ�̬����
    if isempty(obj)   % �������˵����һ�ε��ñ������������µ���Ƶ������������Ϊ�˱����ظ����ɣ����ִ���ٶ�
        obj = videoinput('winvideo', 1);
    end

    realcapture = getsnapshot(obj);
    
end