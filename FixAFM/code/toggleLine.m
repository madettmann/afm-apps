function B = finishButton (object, eventdata)
    global data;
    global spectra;
    global fileName;
    global line;
    
    
    B = get (gca, 'CurrentPoint');
    h = gcf;
    if line == 1
        set (gcf, 'WindowButtonMotionFcn', @mouseMove2 );
        set (gcf, 'WindowButtonDownFcn', @buttonDown2);
        line = 0;
    else
        set (gcf, 'WindowButtonMotionFcn', @mouseMove );
        set (gcf, 'WindowButtonDownFcn', @buttonDown);
        line = 1;
    end