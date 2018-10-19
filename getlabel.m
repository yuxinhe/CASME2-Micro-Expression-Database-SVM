function label = getlabel(xlsfile)
% 从文件xls中读取label信息
% happiness=0，disgust=1，surprise=2，repression=3，others=4
[~,label] = xlsread(xlsfile,1,'I2:I256');
l = zeros(size(label));
s0 = 'happiness';
s1 = 'disgust';
s2 = 'surprise';
s3 = 'repression';
s4 = 'others';
for i = 1:length(label)
    if strcmp(label{i},s0)
        l(i) = 0;
    elseif strcmp(label{i},s1)
        l(i) = 1;
    elseif strcmp(label{i},s2)
        l(i) = 2;
    elseif strcmp(label{i},s3)
        l(i) = 3;
    elseif strcmp(label{i},s4)
        l(i) = 4;
    end
end
label = l;