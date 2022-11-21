function D = buttonDown (object, eventdata)
    global data;
    global lnh;
    global blur;
    [numRows,numCols] = size(data);
    D = get (gca, 'CurrentPoint');
    h = gcf;
    row = round(D(1,2));
    tHold = 1;
    width = 5;
    for i = row-width:row+width
        dif = mean(data(i+1,:)) - mean(data(i,:));
        if dif > tHold
            data(i+1:numRows,:) = data(i+1:numRows,:)- dif;
        end
        if dif < -tHold
            data(i+1:numRows,:) = data(i+1:numRows,:)- dif;
        end
    end

    lnh.ZData = imgaussfilt(data,blur);
    refreshdata(h);
end