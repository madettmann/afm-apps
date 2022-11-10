%Reduces the steps in AFM Spectra
function StepReduce_V4()

clc,clear,close all
global fileName; %file read from
global blur; %amount of blur shown in contourf plot
global spectra; %original data, never altered.
global data; %manipulated by user, saved at the end.
global lnh; %plot handle
global line;
global width;

%*********************Variable Setting**********************
data = spectra;
width = 20;
blur = 2;
line = 1;
tHold = 5;
[numRows,numCols] = size(spectra);
%*********************file I/O******************************
[file,pathname]= uigetfile('*.xlsx', 'Please select your data file');     
fileName=strcat('\',file);
if isequal(fileName,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(pathname, fileName)])
end
%*********************Data Selection************************
% Selected_region=input('Please define the region in the excel you want to use (e.g.A2:SR513):');
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
%*********************Figure Setup**************************
% a = spectra(50:numCols-50,75:numRows-75);
% spectra = a;
data = spectra;
fgh = figure();
axh = axes('Parent', fgh);
[C,lnh] = contourf(data);
btn1 = uicontrol('Style', 'pushbutton',...
    'string', 'Finish',  'Callback', @finishButton );
btn2 = uicontrol('Style', 'pushbutton',...
    'string', 'Reset', 'Callback', @resetButton);
btn3 = uicontrol('Style', 'pushbutton',...
    'string', 'Flatten', 'Callback', @reduceBackground);
btn4 = uicontrol('Style', 'pushbutton',...
    'string', 'erase/line', 'Callback',@toggleLine);
btn5 = uicontrol('Style','pushbutton',...
    'string', 'Smooth','Callback',@autoSmooth);
slider1 = uicontrol('Style','Slider','Min',2,'Max',100,...
    'Value', 20,'string', 'width','Callback',@setWidth);
set (gcf, 'WindowButtonMotionFcn', @mouseMove );
set (gcf, 'WindowButtonDownFcn', @buttonDown);
title (gca, "Click Where You see A Step. Press Finish when done.");
btn1.Position(2) = 5;
btn1.Position(1) = 5;
btn2.Position(2) = 5;
btn2.Position(1) = 60;
btn3.Position(2) = 5;
btn3.Position(1) = 115;
btn4.Position(2) = 5;
btn4.Position(1) = 170;
btn5.Position(2) = 35;
btn5.Position(1) = 5;
slider1.Position(2) = 5;
slider1.Position(1) = 305;
slider1.Position(3) = 150;
slider1.Position(4) = 15;


