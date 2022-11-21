%Reduces the steps in AFM Spectra

clc,clear,close all
global fileName; %file read from
global blur; %amount of blur shown in contourf plot
global spectra; %original data, never altered.
global data; %manipulated by user, saved at the end.
global lnh; %plot handle


%*********************file I/O******************************
[file,pathname]= uigetfile('*', 'Please select your data file');     
fileName=strcat('\',file);
if isequal(fileName,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(pathname, fileName)])
end
%*********************Data Selection************************
disp(strcat(pwd,fileName));
fullFile = xlsread(strcat(pwd,fileName));
fileName=strcat(pwd,fileName);
[rows,cols] = size(fullFile);
for i = 1:rows
    if isnan(fullFile(i,1))
        spectra = fullFile(1:i-1,1:cols);
        break;
    end
    spectra = fullFile;
end
%*********************Variable Setting**********************
data = spectra;
blur = 2;
[numRows,numCols] = size(spectra);
%*********************Figure Setup**************************
fgh = figure();
axh = axes('Parent', fgh);
[C,lnh] = contourf(imgaussfilt(data,blur));
btn1 = uicontrol('Style', 'pushbutton',...
    'string', 'Finish',  'Callback', @finishButton );
btn2 = uicontrol('Style', 'pushbutton',...
    'string', 'Reset', 'Callback', @resetButton);
btn3 = uicontrol('Style', 'pushbutton',...
    'string', 'Background Reduce', 'Callback', @reduceBackground);
set (gcf, 'WindowButtonMotionFcn', @mouseMove );
set (gcf, 'WindowButtonDownFcn', @buttonDown);
title (gca, "Click Where You see A Step. Press Finish when done.");
btn1.Position(2) = 5;
btn2.Position(2) = 5;
btn2.Position(1) = 100;
btn3.Position(2) = 5;
btn3.Position(1) = 200;


