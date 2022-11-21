function R = reduceBackground (object, eventdata)
    global data;
    global blur;
    global lnh;
    global spectra;
    h = gcf;
    R = get (gca, 'CurrentPoint');
    [numRows,numCols] = size(data);

    blurred = imgaussfilt(data,blur);
    redRow = 1/3*(blurred(numRows/2,:)+blurred(numRows/2-1,:)+blurred(numRows/2+1,:));
    redCol = 1/3*(blurred(:,numCols/2)+blurred(:,numCols/2-1)+blurred(:,numCols/2+1));
    for j = 1:numRows
        data(j,:) = data(j,:)-redRow;
        if data(j,numCols/2) > 100
            data(j,:) = data(j-1,:);
        end
    end
    for i = 1:numCols
        data(:,i) = data(:,i)-redCol;
        if data(numRows/2,i) > 100
            data(:,i) = data(:,i-1);
        end
    end
    
    data = data-min(min(data));
    a = data<20;
    b = data.*a;
    data = data-imgaussfilt(b,blur);
    a = data < 50;
    a(50:numRows-50,50:numCols-50)=0;
    b = data.*a;
    data = data-imgaussfilt(b,blur);
    
    lnh.ZData = data;
    refreshdata(h);
end