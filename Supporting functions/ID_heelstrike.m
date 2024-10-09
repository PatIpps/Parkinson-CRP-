function [] = ID_heelstrike(fld_processed)

% This function ID's heelstrike using Heelstrike_Detection_IMU function. 

%% STEP 1

% Locate all event files
fl = engine('path', fld_processed, 'extension', 'mat');

% Deletes all files without relevant events
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    %Event Identification for RIGHT HEELSTRIKE
    idx = contains(data.imu_location,'right_ankle');
    idx_2 = find(idx);
    G = data.Gyro_filt(:,3,idx_2); PeakLim = 0.8;
    data.Heelstrike_right = Heelstrike_Detection_IMU(G,PeakLim);

    if size(data.Heelstrike_right,2) < 2 %if not recognizing a single gait cycles
        disp(['MISSING GAIT EVENTS: Deleting ', file_name])
        delete ([file_pth, filesep, file_name, ext])
        continue
    end
    save(fl{f},'data','-append');
    disp(['Calculating and saving Heelstrike RIGHT events for ', file_name])
    clearvars G idx idx_2 PeakLim


    %Event Identification for LEFT HEELSTRIKE
    idx = contains(data.imu_location,'left_ankle');
    idx_2 = find(idx);
    G = data.Gyro_filt(:,3,idx_2); PeakLim = 0.8;
    G = G*-1; % need to reverse sign b/c left LE.
    data.Heelstrike_left = Heelstrike_Detection_IMU(G,PeakLim);

    if size(data.Heelstrike_left,2) < 2 %if not recognizing a single gait cycles
        disp(['MISSING GAIT EVENTS: Deleting ', file_name])
        delete ([file_pth, filesep, file_name, ext])
        continue
    end
    save(fl{f},'data','-append');
    disp(['Calculating and saving Heelstrike LEFT events for ', file_name])
    clearvars -except f fl fld_processed
end
end