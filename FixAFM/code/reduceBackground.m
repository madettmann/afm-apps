function R = reduceBackground (object, eventdata)
    global data;
    global blur;
    global lnh;
    global spectra;
    h = gcf;
    R = get (gca, 'CurrentPoint');
    [numRows,numCols] = size(data);

    blurred = imgaussfilt(data,20);
%     redRow = 1/3*(blurred(floor(numRows/2),:)+blurred(floor(numRows/2)-1,:)+blurred(floor(numRows/2)+1,:));
%     redCol = 1/3*(blurred(:,floor(numCols/2))+blurred(:,floor(numCols/2)-1)+blurred(:,floor(numCols/2)+1));
    redRow = blurred(floor(numRows/2+5),:);
    redCol = blurred(:,floor(numCols/2+5));
    for i = 1:numCols
        data(:,i) = data(:,i)-redCol;
%         if data(floor(numRows/2),i) > 100
%             data(:,i) = data(:,i-1);
%         end
    end
    for j = 1:numRows
        data(j,:) = data(j,:)-redRow;
%         if data(j,floor(numCols/2)) > 100
%             data(j,:) = data(j-1,:);
%         end
    end
    data = data-min(min(data));
    a = data<5;
    b = data.*a;
    data = data-imgaussfilt(b,blur);
    a = data < 15;
%     a(75:numRows-75,75:numCols-75)=0;
    b = data.*a;
    data = data-imgaussfilt(b,blur);
    
    lnh.ZData = data;
    refreshdata(h);
end