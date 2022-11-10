function autoSmooth(source,event)
    global data;
    global lnh;
    %*********************Data Cleanup**************************
%     tHold = 5;
%     data = data.*(data<50).*(data>-50);
%     data = smoothdata(data,'sgolay');
%     [numRows,numCols] = size(data);
%     for m = 1:5
%         for j = 1:numCols-4
%             for i = 1:numRows-4
%                 a = data(i:i+3,j:j+3);
%                 a(1,1) = 0;
%                 avg = sum(sum(a))/15;
%                 dif = data(i,j)-avg;
%                 if dif > tHold
%                     data(i,j) = avg;
%                 end
%             end
%         end
%     end
    data = medfilt2(data);
    lnh.ZData = data;
    refreshdata(lnh);
end
