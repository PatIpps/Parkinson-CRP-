function [] = extract_jointAng(fld_processed)

% Locate all participant files
fl = engine('path', fld_processed, 'extension', 'mat');

% Deletes all files without relevant events
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    % Calculates ROM
    data.RKneeROM = abs(max(data.RKneeAng_seg(:,1)) - min(data.RKneeAng_seg(:,1)));
    data.RHipROM = abs(max(data.RHipAng_seg(:,2)) - min(data.RHipAng_seg(:,2)));
    data.LKneeROM = abs(max(data.LKneeAng_seg(:,1)) - min(data.LKneeAng_seg(:,1)));
    data.LHipROM = abs(max(data.LHipAng_seg(:,2)) - min(data.LHipAng_seg(:,2))); 

    save(fl{f},'data','-append');
    disp(['Extracting ROM values for ', file_name])
    clearvars -except f fl fld_processed
end