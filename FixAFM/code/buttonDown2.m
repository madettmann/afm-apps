function D = buttonDown2 (object, eventdata)
    global data;
    global lnh;
    global blur;
    global width; 
    
    D = get (gca, 'CurrentPoint');
    h = gcf;
    row = round(D(1,2));
    col = round(D(1,1));

%     for i = 1:width
%         a = data(row - width/2:row+width/2,col-width/2:col+width/2);
%         maximum = max(max(a));
%         b = (a == maximum);
%         avg = mean(mean(a));
%         data(b(1) + row,b(2)+col) = mean(mean(a));
%     end
    a = data(row - width/2:row+width/2,col-width/2:col+width/2);
    avg = mean(mean(a));
    tHold = 2;
    for i = row-width:row+width
        for j = col-width:col+width
            val = data(i,j);
            if val > avg + tHold
                data(i,j) = data(i+width,j+width);
            end
        end
    end
    
%     data = data-min(data);
    lnh.ZData = data;
    refreshdata(h);
end