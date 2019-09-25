function varargout = show_matches_gui(varargin)
% SHOW_MATCHES_GUI MATLAB code for show_matches_gui.fig
%      SHOW_MATCHES_GUI, by itself, creates a new SHOW_MATCHES_GUI or raises the existing
%      singleton*.
%
%      H = SHOW_MATCHES_GUI returns the handle to a new SHOW_MATCHES_GUI or the handle to
%      the existing singleton*.
%
%      SHOW_MATCHES_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_MATCHES_GUI.M with the given input arguments.
%
%      SHOW_MATCHES_GUI('Property','Value',...) creates a new SHOW_MATCHES_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_matches_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_matches_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show_matches_gui

% Last Modified by GUIDE v2.5 25-Sep-2019 15:14:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @show_matches_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @show_matches_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before show_matches_gui is made visible.
function show_matches_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to show_matches_gui (see VARARGIN)

% Choose default command line output for show_matches_gui
handles.output = hObject;
handles.index = 0;
handles.segments = evalin('base','segments');
handles.corrs = evalin('base','corrs');
set(handles.text_total, 'String', ['/', num2str(length(handles.corrs))]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes show_matches_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = show_matches_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_prev.
function pushbutton_prev_Callback(hObject, eventdata, handles)
k = handles.index-1;
if k >= 1
    axes(handles.axes_left);
    imshow(handles.segments{handles.corrs(k, 2)});
    ylabel(['r=', num2str(handles.corrs(k, 1), 4)]);
    title(['index: ', num2str(handles.corrs(k, 2))]);
    axes(handles.axes_right);
    imshow(handles.segments{handles.corrs(k, 3)});
    title(['index: ', num2str(handles.corrs(k, 3))]);
    handles.index = k;
    set(handles.edit_index, 'String', num2str(k));
    guidata(hObject, handles);  
end


% --- Executes on button press in pushbutton_next.
function pushbutton_next_Callback(hObject, eventdata, handles)
k = handles.index+1;
if k <= length(handles.corrs)
    axes(handles.axes_left);
    imshow(handles.segments{handles.corrs(k, 2)});
    ylabel(['r=', num2str(handles.corrs(k, 1), 4)]);
    title(['index: ', num2str(handles.corrs(k, 2))]);
    axes(handles.axes_right);
    imshow(handles.segments{handles.corrs(k, 3)});
    title(['index: ', num2str(handles.corrs(k, 3))]);
    handles.index = k;
    set(handles.edit_index, 'String', num2str(k));
    guidata(hObject, handles);
end


function edit_index_Callback(hObject, eventdata, handles)
%handles.jump_index = str2num(get(hObject,'String'));
%guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_jump.
function pushbutton_jump_Callback(hObject, eventdata, handles)
k = str2double(get(handles.edit_index, 'String'));
if k >= 1 && k <= length(handles.corrs)
    axes(handles.axes_left);
    imshow(handles.segments{handles.corrs(k, 2)});
    ylabel(['r=', num2str(handles.corrs(k, 1), 4)]);
    title(['index: ', num2str(handles.corrs(k, 2))]);
    axes(handles.axes_right);
    imshow(handles.segments{handles.corrs(k, 3)});
    title(['index: ', num2str(handles.corrs(k, 3))]);
    handles.index = k;
    set(handles.edit_index, 'String', num2str(k));
    guidata(hObject, handles);
end
