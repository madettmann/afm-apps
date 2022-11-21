function A = resetButton (object, eventdata)
    global data;
    global spectra;
    global blur;
    global lnh;
    h = gcf;
    A = get (gca, 'CurrentPoint');
    data = spectra;
    lnh.ZData = imgaussfilt(data,blur);
    refreshdata(h);
end