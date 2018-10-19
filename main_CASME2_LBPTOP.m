clear all;close all;clc;
%% getlabel happiness=0£¬disgust=1£¬surprise=2£¬repression=3£¬others=4
xlsfile = 'F:\database\CASME2\CASME2-coding-20140508.xlsx'
label = getlabel(xlsfile)
save('CASME2_label','label');

%% read images and extracted features
clc;
clear all;
cd ('F:\database\CASME2\Cropped');
a = dir(); %Layer 1
feature = [];
for i = 1 : length(a)
    if (strcmp(a(i).name, '.') == 1)|| (strcmp(a(i).name, '..') == 1)
        continue;
    end
    b = dir (fullfile(a(i).folder,'\',a(i).name)); %Layer 2
    
    for j = 1 : length(b)
        if (strcmp(b(j).name, '.') == 1)|| (strcmp(b(j).name, '..') == 1)
            continue;    
        end
        cd (fullfile(b(j).folder,'\',b(j).name));
        c = dir('*.jpg');
        
        for k = 1 : length(c)
            Imgdat = imread(getfield(c, {k}, 'name'));
            if size(Imgdat, 3) == 3 % if color images, convert it to gray
                Imgdat = rgb2gray(Imgdat); 
            end
            [height, width] = size(Imgdat);
            if k ==1
                VolData = zeros(height, width, length(c));
            end
            VolData(:, :, k) = Imgdat;        
        end
        
       %% LBP-TOP
        % parameter set
        FxRadius = 1; 
        FyRadius = 1;
        TInterval = 4;
        TimeLength = 4;
        BorderLength = 1;
        bBilinearInterpolation = 1;  % 0: not / 1: bilinear interpolation
        %59 is only for neighboring points with 8. If won't compute uniform
        %patterns, please set it to 0, then basic LBP will be computed
        Bincount = 59; %59 / 0
        NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
        if Bincount == 0
            Code = 0;
            nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic LBP
        else
            % uniform patterns for neighboring points with 8
            cd ('F:\matlab\2014_CASME-II');
            U8File = importdata('UniformLBP8.txt');
            BinNum = U8File(1, 1);
            nDim = U8File(1, 2); %dimensionality of uniform patterns
            Code = U8File(2 : end, :);
            clear U8File;
        end
        %5*5 block
        Histogram_block = [];
        x = floor(height/5);
        y = floor(width/5);
        for ii = 1:5
            for jj = 1:5
                % call LBPTOP
                Histogram = LBPTOP(VolData((ii*x+1-x):(ii*x),(jj*y+1-y):(jj*y),:),FxRadius, FyRadius, TInterval, NeighborPoints, TimeLength, BorderLength, bBilinearInterpolation, Bincount, Code);
                Histogram_block = [Histogram_block,Histogram];
            end
        end

        feature =[feature,Histogram_block(:)];
    end
      
end
save('CASME2_feature_block55_P4','feature');

cd ('F:\matlab\2014_CASME-II');