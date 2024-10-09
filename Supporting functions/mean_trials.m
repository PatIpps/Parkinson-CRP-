function [] = mean_trials(fld_processed)

% Gets the means of joint angle and CRP trials

fl = engine('path',fld_processed, 'extension', 'mat');

for f = 1:length(fl)
    load(fl{f})
    [~, file_name] = fileparts(fl{f});

    % extract subject/condition from file name
    cond = {'fast','slow','preferred'};

    if contains(file_name, cond)

        disp(['Collecting Hip and Knee Joint angles and CRP angles for : ', file_name])
        for i = 1:size(data.LHipAng_cycles,2)
            temp_hip_L(:,i) = normalize_line(data.LHipAng_cycles{:,i}(:,2),100); %2nd column is sag plane
            temp_knee_L(:,i) = normalize_line(data.LKneeAng_cycles{:,i}(:,1),100); %1st column in sag plane
            temp_CRP_L(:,i) = normalize_line(data.CRP_LHip_Knee_cycles{:,i},100);
        end

        for i = 1:size(data.RHipAng_cycles,2)
            temp_hip_R(:,i) = normalize_line(data.RHipAng_cycles{:,i}(:,2),100); %2nd column is sag plane
            temp_knee_R(:,i) = normalize_line(data.RKneeAng_cycles{:,i}(:,1),100); %1st column in sag plane
            temp_CRP_R(:,i) = normalize_line(data.CRP_RHip_Knee_cycles{:,i},100);
        end

        disp(['Averaging joint angles and CRP for ', file_name])

        % Left
        data.Avg_Left_HipAng = mean(temp_hip_L,2);
        data.Avg_Left_KneeAng = mean(temp_knee_L,2);
        data.Avg_Left_CRP = mean(temp_CRP_L,2);
        data.Avg_Left_DP = std(temp_CRP_L,0,2);

        % Right
        data.Avg_Right_HipAng = mean(temp_hip_R,2);
        data.Avg_Right_KneeAng = mean(temp_knee_R,2);
        data.Avg_Right_CRP = mean(temp_CRP_R,2);
        data.Avg_Right_DP = std(temp_CRP_R,0,2);

        save(fl{f},'data','-append');
        clear data temp_hip_L temp_knee_L temp_CRP_L temp_hip_R temp_knee_R temp_CRP_R
    else
        disp(['******* No condition listed for ', file_name]); %do nothing

    end
end
end

