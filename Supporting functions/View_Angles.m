function [] = View_Angles(fld_processed)
%This function visualizes segmented joint angle data

% Locate all event files
fl = engine('path', fld_processed, 'extension', 'mat');

% Loops thru plots
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    % Rt LE
    sgtitle(file_name)
    subplot(2,2,1); hold on;
    plot(data.RKneeAng_seg(:,1)); xline(data.Heelstrike_right_seg)
    title('Rt Knee flex/ext')
   
    subplot(2,2,2); hold on
    plot(data.RHipAng_seg(:,2)); xline(data.Heelstrike_right_seg)
    title('Rt Hip flex/ext')
    
    % Lt LE
    subplot(2,2,3); hold on;
    plot(data.LKneeAng_seg(:,1)); xline(data.Heelstrike_left_seg)
    title('Lt Knee flex/ext')
   
    subplot(2,2,4); hold on
    plot(data.LHipAng_seg(:,2)); xline(data.Heelstrike_left_seg)
    title('Lt Hip flex/ext')

    disp('press any key to continue')
    pause; close
end
end