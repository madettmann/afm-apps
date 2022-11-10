% This program reads in an excel file and displays it. The user can also
% manipulate the data through global variables spectra and data which are
% identical. 
function Quickread()
global file;
global spectra;
global data;
global pathname;


[file,pathname]= uigetfile('*.xlsx', 'Please select your data file');     
fileName=strcat('\',file);
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
rows = i;
data = spectra;
close all;
sideLen = str2num(cell2mat(inputdlg('How long was the original image in microns?')));
data(data<0) = 5*rand(size(data(data<0)));
if ~isnan(sideLen) && cols == 1
    X = linspace(0,rows*sideLen/512,rows);
    plot(X,data);
    xlim([0 sideLen]);
    xlabel('\mum');
    ylabel('nm');
elseif ~isnan(sideLen) && rows == 1
    X = linspace(0,cols*sideLen/512,cols);
    plot(X,data);
    xlim([0 sideLen]);
    xlabel('\mum');
    ylabel('nm');
elseif ~isnan(sideLen)
    X = linspace(0,cols*sideLen/512,cols);
    Y = linspace(0,rows*sideLen/512,rows);
    a = figure(1);
    mesh(X,Y,data);
    xlim([0 X(end)]);
    ylim([0 Y(end)]);
    xlabel('\mum');
    ylabel('\mum');
    zlabel('nm');
    zlim([0 max(max(data))]);
    caxis([0 max(max(data))]);
    c1 = colorbar;
    c1.Label.String = 'nm';
    b = figure(2);
    contourf(X,Y,data);
    xlabel('\mum');
    ylabel('\mum');
    caxis([0 max(max(data))]);
    c2 = colorbar;
    c2.Label.String = 'nm';
    movegui(a,'west');
    movegui(b,'east');

end

