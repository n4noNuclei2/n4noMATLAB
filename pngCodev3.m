clc; clear; home;

fName = '3a.png';

[A, map, trans] = imread(fName);

loadTemp = load('colorMat.mat');
colorMat = loadTemp.colorMat;
loadTemp = load('colorList.mat');
colorList = loadTemp.colorList;

lineStr{1} = '#####smaller';
lineStr{size(lineStr, 2) + 1} = '#####smaller';
lineStr{size(lineStr, 2) + 1} = '#####smaller';
lineStr{size(lineStr, 2) + 1} = '#####smaller';
lineStr{size(lineStr, 2) + 1} = '####start image';

for hIndex = 1 : size(A, 1)
    
    lineStr{size(lineStr, 2) + 1} = ''; %new line
    prevPix = -1;
                
    for wIndex = 1 : size(A, 2);
        
        if trans(hIndex, wIndex) == 0
            thisPix = 149; %Transparent Index
        else
            thisPix = colorMat(double(A(hIndex, wIndex, 1)) * 256 * 256 + double(A(hIndex, wIndex, 2)) * 256 + double(A(hIndex, wIndex, 3)) + 1);
        end
        
        if ((thisPix ~= prevPix) || (prevPix == -1))
            if wIndex ~= 1
                lineStr{size(lineStr, 2)} = [lineStr{size(lineStr, 2)}, '[', repmat('.', 1, thisCount * 2), '](//', colorList{prevPix, 1}, ')'];
            end
            
            thisCount = 1;
        else
            thisCount = thisCount + 1;
        end
        
        prevPix = thisPix;
    end
    
    lineStr{size(lineStr, 2)} = [lineStr{size(lineStr, 2)}, '[', repmat('.', 1, thisCount * 2), '](//', colorList{prevPix, 1}, ')'];
    lineStr{size(lineStr, 2) + 1} = ''; %spacer line

end
    
lineStr{size(lineStr, 2) + 1} = '####end image';
  
    
clipboard('copy', sprintf('%s\n',lineStr{:}));
