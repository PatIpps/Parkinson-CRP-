function [] = Extract_gait_cycles(fld_processed)

% This extracts individual gait cycles for all participants

%% STEP 1 - GET GAIT CYCLES

% Locate all participant files
fl = engine('path', fld_processed, 'extension', 'mat');

% Deletes all files without relevant events
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    %Right LE
    for i = 1:size(data.Heelstrike_right_seg,2)
        if i+1 > size(data.Heelstrike_right_seg,2)
            [];
        else

            %Joint angles and ROM
            data.RHipAng_cycles{i} = data.RHipAng_seg(data.Heelstrike_right_seg(i):data.Heelstrike_right_seg(i+1),:);
            data.RKneeAng_cycles{i} = data.RKneeAng_seg(data.Heelstrike_right_seg(i):data.Heelstrike_right_seg(i+1),:);
   
            %Phase angles
            data.PA_RHip_cycles{i} = data.PA_RHip_full(data.Heelstrike_right_seg(i):data.Heelstrike_right_seg(i+1),:);
            data.PA_RKnee_cycles{i} = data.PA_RKnee_full(data.Heelstrike_right_seg(i):data.Heelstrike_right_seg(i+1),:);
            data.CRP_RHip_Knee_cycles{i} = data.CRP_RHip_Knee_full(data.Heelstrike_right_seg(i):data.Heelstrike_right_seg(i+1),:);

            

        end
    end
    
    % LEFT LE
    for i = 1:size(data.Heelstrike_left_seg,2)
        if i+1 > size(data.Heelstrike_left_seg,2)
            [];
        else

            %Joint angles
            data.LHipAng_cycles{i} = data.LHipAng_seg(data.Heelstrike_left_seg(i):data.Heelstrike_left_seg(i+1),:);
            data.LKneeAng_cycles{i} = data.LKneeAng_seg(data.Heelstrike_left_seg(i):data.Heelstrike_left_seg(i+1),:);

            %Phase angles
            data.PA_LHip_cycles{i} = data.PA_LHip_full(data.Heelstrike_left_seg(i):data.Heelstrike_left_seg(i+1),:);
            data.PA_LKnee_cycles{i} = data.PA_LKnee_full(data.Heelstrike_left_seg(i):data.Heelstrike_left_seg(i+1),:);
            data.CRP_LHip_Knee_cycles{i} = data.CRP_LHip_Knee_full(data.Heelstrike_left_seg(i):data.Heelstrike_left_seg(i+1),:);

        end
    end

    save(fl{f},'data','-append');
    disp(['Extracting and saving individual gait cycles for ', file_name])
    clearvars -except f fl fld_processed
end
end