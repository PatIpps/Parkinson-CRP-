function [] = JtROM(fld_processed)

% Locate all participant files
fl = engine('path', fld_processed, 'extension', 'mat');

% Deletes all files without relevant events
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    for i = 1:size(data.RHipAng_cycles,2)

            data.RHipROM(i,:) = abs(max(data.RHipAng_cycles{:,i}(:,2)) - min(data.RHipAng_cycles{:,i}(:,2)));
            data.RKneeROM(i,:) = abs(max(data.RKneeAng_cycles{:,i}(:,1)) - min(data.RKneeAng_cycles{:,i}(:,1)));
    end

    for j = 1:size(data.LHipAng_cycles,2)

        data.LHipROM(j,:) = abs(max(data.LHipAng_cycles{:,j}(:,2)) - min(data.LHipAng_cycles{:,j}(:,2)));
        data.LKneeROM(j,:) = abs(max(data.LKneeAng_cycles{:,j}(:,1)) - min(data.LKneeAng_cycles{:,j}(:,1)));

    end

    save(fl{f},'data','-append');
    disp(['Extracting ROM values for ', file_name])
    clearvars -except f fl fld_processed
end
end