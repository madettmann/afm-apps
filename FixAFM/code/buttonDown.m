function D = buttonDown (object, eventdata)
    global data;
    global lnh;
    global blur;
    global width;
    
    
    [numRows,numCols] = size(data);
    D = get (gca, 'CurrentPoint');
    h = gcf;
    row = round(D(1,2));
    tHold = 2;
    for i = row-width:row+width
        dif = mean(data(i+1,:)) - mean(data(i,:));
        if dif > tHold
            data(i+1:numRows,:) = data(i+1:numRows,:)- dif;
        end
        if dif < -tHold
            data(i+1:numRows,:) = data(i+1:numRows,:)- dif;
        end
    end


%     col = round(D(1,1));
%     tHold = .5;
%     for i = col-width:col+width
%         dif = mean(data(:,i+1)) - mean(data(:,i));
%         if dif > tHold
%             data(:,i+1:numRows) = data(:,i+1:numRows)- dif;
%         end
%         if dif < -tHold
%             data(:,i+1:numRows) = data(:,i+1:numRows)- dif;
%         end
%     end


    lnh.ZData = data;
    refreshdata(h);
end