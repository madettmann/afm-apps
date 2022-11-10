function varargout = RotateCrop(varargin)
% ROTATECROP MATLAB code for RotateCrop.fig
%      ROTATECROP, by itself, creates a new ROTATECROP or raises the existing
%      singleton*.
%
%      H = ROTATECROP returns the handle to a new ROTATECROP or the handle to
%      the existing singleton*.
%
%      ROTATECROP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATECROP.M with the given input arguments.
%
%      ROTATECROP('Property','Value',...) creates a new ROTATECROP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RotateCrop_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RotateCrop_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RotateCrop

% Last Modified by GUIDE v2.5 21-Jun-2018 08:53:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RotateCrop_OpeningFcn, ...
                   'gui_OutputFcn',  @RotateCrop_OutputFcn, ...
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


% --- Executes just before RotateCrop is made visible.
function RotateCrop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RotateCrop (see VARARGIN)

% Choose default command line output for RotateCrop
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global height;
global width;
global vert;
global data;
global spectra;
global hrect;
vert = false;
[file,pathname]= uigetfile('*.xlsx', 'Please select your data file');     
fileName=strcat('\',file);
disp(strcat(pwd,fileName));
fullFile = xlsread(strcat(pathname,file));
fileName=strcat(pwd,fileName);
[rows,cols] = size(fullFile);
for i = 1:rows
    if isnan(fullFile(i,1))
        spectra = fullFile(1:i-1,1:cols);
        break;
    end
    spectra = fullFile;
end
height = i;
width = cols;
data = spectra;
axes(handles.axes1);
contourf(data);
hrect = imrect(gca,[round(width/4), round(height/4), ...
    round(width/2), round(height/2)]);
% setFixedAspectRatioMode(hrect,true);
% UIWAIT makes RotateCrop wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RotateCrop_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global height;
global width;
global vert;
global data;
global spectra;
global hrect;
vert = false;
[file,pathname]= uigetfile('*.xlsx', 'Please select your data file');     
fileName=strcat('\',file);
disp(strcat(pwd,fileName));
fullFile = xlsread(strcat(pathname,file));
fileName=strcat(pwd,fileName);
[rows,cols] = size(fullFile);
for i = 1:rows
    if isnan(fullFile(i,1))
        spectra = fullFile(1:i-1,1:cols);
        break;
    end
    spectra = fullFile;
end
height = i;
width = cols;
data = spectra;
axes(handles.axes1);
contourf(data);
hrect = imrect(gca,[round(width/4), round(height/4), ...
    round(width/2), round(height/2)]);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global width;
global height;
global hrect;
global spectra;
global data;

axes(handles.axes1);
coords = getPosition(hrect);
x1 = round(coords(1));
y1 = round(coords(2));
x2 = round(x1 + coords(3));
y2 = round(y1 + coords(4));
height = y2 - y1;
width = x2 - x1;
spectra = data(y1:y2,x1:x2);
data = spectra;
contourf(data);
hrect = imrect(gca,[round(width/4), round(height/4), ...
    round(width/2), round(height/2)]);
set(handles.slider1,'Value',0);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
[filename, pathname] = uiputfile('*.xlsx', 'Choose a file name');
outname = fullfile(pathname, filename);
xlswrite(outname, data);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global data;
global spectra;
global hrect;

deg = get(hObject,'Value');
data = imrotate(spectra,deg);
axes(handles.axes1);
coords = getPosition(hrect);
contourf(data);
hrect = imrect(gca,coords);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
