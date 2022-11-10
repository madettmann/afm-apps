function varargout = Section(varargin)
% SECTION MATLAB code for Section.fig
%      SECTION, by itself, creates a new SECTION or raises the existing
%      singleton*.
%
%      H = SECTION returns the handle to a new SECTION or the handle to
%      the existing singleton*.
%
%      SECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION.M with the given input arguments.
%
%      SECTION('Property','Value',...) creates a new SECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section

% Last Modified by GUIDE v2.5 20-Jun-2018 15:34:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section_OpeningFcn, ...
                   'gui_OutputFcn',  @Section_OutputFcn, ...
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
end

% --- Executes just before Section is made visible.
function Section_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section (see VARARGIN)

% Choose default command line output for Section
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global height;
global width;
global vert;
global data;
global spectra;
global hline;
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
hline = line([0,width], [round(height/4), round(height/4)],...
    'color', 'white', 'linewidth', 3, 'ButtonDownFcn', @startDrag);
end

% set (hObject, 'WindowButtonMotionFcn', @secMouseMove );

% UIWAIT makes Section wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sect;
[filename, pathname] = uiputfile('*.xlsx', 'Choose a file name');
outname = fullfile(pathname, filename);
xlswrite(outname, sect);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vert;
global hline;
x = get(hline,'XData');
y = get(hline,'Ydata');
set(hline,'XData',y);
set(hline,'YData',x);
vert = ~vert;

end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global height;
global hline;
global width;
global data;
global vert;
global spectra;
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
vert = false;
hline = line([0,width], [round(height/4), round(height/4)],...
    'color', 'white', 'linewidth', 3, 'ButtonDownFcn',...
    @(hObject,eventdata)Section('startDrag',hObject,eventdata,guidata(hObject)));
end 
function startDrag(hObject,eventdata,handles)
% set(gca,'WindowButtonMotionFcn',@(hObject,eventdata)Section...
%    ('secMouseMove',hObject,eventdata,guidata(hObject)));
set(hObject.Parent.Parent,'WindowButtonMotionFcn',...
    @(hObject,eventdata)Section('dragging',hObject,eventdata,guidata(hObject)));
set(hObject.Parent.Parent,'WindowButtonUpFcn',...
    @(hObject,eventdata)Section('figure1_WindowButtonUpFcn',hObject,eventdata,guidata(hObject)))
end

function dragging(hObject,eventdata,handles)
    global hline;
    global vert;
    C = get(gca, 'CurrentPoint');
    if vert
        set(hline,'XData',[round(C(1,1)),round(C(1,1))]);
    else
        set(hline,'YData',[round(C(1,2)),round(C(1,2))]);
    end
end


function secMouseMove(hObject, eventdata, handles)
global height;
global width;
global vert;
axes(handles.axes1);
C = get (gca, 'CurrentPoint');
% title(gca, ['(X,Y) = (',num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
axesHandlesToChildObjects = findobj(gca, 'Type', 'line');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end	
if floor(C(1,2)) < height && floor(C(1,2)) > 0
    if floor(C(1,1)) < width && floor(C(1,1)) > 0
        if vert
            hline = line([round(C(1,1)), round(C(1,1))], [0,height]);
        else
            hline = line([0,width], [round(C(1,2)), round(C(1,2))]);
        end
        hline.LineWidth = 1;
        hline.Color = 'white';
        hline.Color(4) = 1;
    end
end
end


% % --- Executes on mouse press over axes background.
% function axes1_ButtonDownFcn(hObject, eventdata, handles)
% % hObject    handle to axes1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global vert;
% global data;
% global sect;
% axes(handles.axes1);
% C = get (gca, 'CurrentPoint');
% if vert
%     sect = data(:,round(C(1,2)));
% else
%     sect = data(round(C(1,1)),:);
% end
% axes(handles.axes2);
% plot(sect);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vert;
global data;
global sect;
axes(handles.axes1);
C = get (gca, 'CurrentPoint');
if vert
    sect = data(round(C(1,1)),:);
else
    sect = data(:,round(C(1,2)));
end

axes(handles.axes2);
plot(sect);
end

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vert;
global data;
global sect;
global width;
global height;
axes(handles.axes1);
C = get (gca, 'CurrentPoint');
if vert
    sect = data(:, round(C(1,1)));
else
    sect = data(round(C(1,2)),:);
end
% title(strcat(num2str(C(1,1)), ',',num2str(C(1,2))));
axes(handles.axes2);
plot(sect);

set(hObject,'WindowButtonMotionFcn','');
set(hObject,'WindowButtonUpFcn','');
end
