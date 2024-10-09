function Heelstrike = Heelstrike_Detection_IMU(G,PeakLim)

% Heelstrike_Detection(G,PeakLim) finds frames for heel strike based on
% gyroscope IMU data on lateral shank in med/lat direction.

% Based on Fadillioglu et al., "Automated gait event detection for a variety of locomotion tasks using a novel gyroscope-based algorithm".
% Gait & Posture, Vol. 81, Sept 2020, pp. 102-108. 

% This function sets a window between consecutive mid-swing peaks in the gyro data and
% identifies the frame at which this signal first crosses zero (after the first
% of the two consecutive peaks).

%% STEP 1: Determine Peaks

[GRow, ~] = size(G); % Count Row and Columm of Gyro Shank
limitPeakH = PeakLim * max(G,[],'all'); %Set limit peak (X to Max value of Gyro)
limitPeakD = 80; %Min Distance between two peaks (30 was orig)

% Peak ditection Start
[~,GyroPeaks,~,~] = findpeaks(G,[1:GRow],...
    'MinPeakProminence',limitPeakH,...
    'MinPeakDistance',limitPeakD);

%% STEP 2: Determine Heelstrike

GyroPeaks= GyroPeaks.';
[iend, ~] = size(GyroPeaks);

if iend > 1
    for i = 1:iend  
        if i+1 > iend
            TF = G(GyroPeaks(iend-1):GyroPeaks(i),:) < 0;
            V1 = find(TF, 1, 'first');

            if isempty(V1) % There are no zero crossings, so try a 0.5 threshold
                TF = G(GyroPeaks(iend-1):GyroPeaks(i),:) < 0.5;
                V1 = find(TF, 1, 'first');
            %else
                %continue
            end
            
            Heel(i) = V1+GyroPeaks(i);

        else
            TF = G(GyroPeaks(i):GyroPeaks(i+1),:) < 0;
            V1 = find(TF, 1, 'first');
            
            if isempty(V1) % There are no zero crossings, so try a 0.5 threshold
                TF = G(GyroPeaks(iend-1):GyroPeaks(i),:) < 0.5;
                V1 = find(TF, 1, 'first');
            %else
                %continue
            end

            Heel(i) = V1+GyroPeaks(i);
        end
    end
else
    Heel=[];
end
Heelstrike=Heel;
