function [] = View_CRP(fld_processed)
%This function visualizes CRP plots

% Locate all event files
fl = engine('path', fld_processed, 'extension', 'mat');

% Loops thru plots
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    subplot(2,1,1)
    sgtitle(file_name)
    plot(data.CRP_RHip_Knee_full); xline(data.Heelstrike_left_seg)
    title('Hip-Knee CRP on right')

    subplot(2,1,2)
    plot(data.CRP_LHip_Knee_full); xline(data.Heelstrike_left_seg)
    title('Hip-Knee CRP on left')
    
    disp('press any key to continue')
    pause; close
end
end