function [] = IMU_phase(fld_processed)

%Calculate phase_angle on entire waveform to manage
%edge-effects

%% STEP 1 - CALCULATED PHASE ANGLE AND CRP

fl = engine('path',fld_processed, 'extension', 'mat');
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    %Phase angle w/ padded data
    data.PA_RHip_full = phase_angle(data.RHipAng_seg_pad(:,2));
    data.PA_RKnee_full = phase_angle(data.RKneeAng_seg_pad(:,1));
    
    %Calculate CRP and remove pads
    data.CRP_RHip_Knee_full = CRP(data.PA_RKnee_full, data.PA_RHip_full);
    data.CRP_RHip_Knee_full = data.CRP_RHip_Knee_full(11:end-10,:);

    %Phase angle w/ padded data
    data.PA_LHip_full = phase_angle(data.LHipAng_seg_pad(:,2));
    data.PA_LKnee_full = phase_angle(data.LKneeAng_seg_pad(:,1));
    
    %Calculate CRP and remove pads
    data.CRP_LHip_Knee_full = CRP(data.PA_LKnee_full, data.PA_LHip_full);
    data.CRP_LHip_Knee_full = data.CRP_LHip_Knee_full(6:end-5,:);
    
    save(fl{f},'data','-append');
    disp(['Calculating and saving CRP Angles for ', file_name])
    clearvars -except f fl fld_processed

end
end