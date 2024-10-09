function [] = Segment_data(fld_processed)
%This function segments joint angle data based on events, then re-adjusts
%the events. 

fl = engine('path',fld_processed, 'extension', 'mat');
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])

    % Segment RIGHT joint angle data and add a pad for relative phase analyses
    data.RHipAng_seg = data.RHipAng(data.Heelstrike_right(1):data.Heelstrike_right(end),:);
    data.RHipAng_seg_pad = data.RHipAng(data.Heelstrike_right(1)-10:data.Heelstrike_right(end)+10,:);

    data.RKneeAng_seg = data.RKneeAng(data.Heelstrike_right(1):data.Heelstrike_right(end),:);
    data.RKneeAng_seg_pad = data.RKneeAng(data.Heelstrike_right(1)-10:data.Heelstrike_right(end)+10,:);

    data.RKneeAng_ank_seg = data.RKneeAng_ank(data.Heelstrike_right(1):data.Heelstrike_right(end),:);
    
    % Segment LEFT joint angle data and add a pad for relative phase analyses
    data.LHipAng_seg = data.LHipAng(data.Heelstrike_left(1):data.Heelstrike_left(end),:);
    data.LHipAng_seg_pad = data.LHipAng(data.Heelstrike_left(1)-5:data.Heelstrike_left(end)+5,:);

    data.LKneeAng_seg = data.LKneeAng(data.Heelstrike_left(1):data.Heelstrike_left(end),:);
    data.LKneeAng_seg_pad = data.LKneeAng(data.Heelstrike_left(1)-5:data.Heelstrike_left(end)+5,:);

    data.LKneeAng_ank_seg = data.LKneeAng_ank(data.Heelstrike_left(1):data.Heelstrike_left(end),:);

    % re-adjust RIGHT and LEFT heelstrike data (change from 0 to 1)
    data.Heelstrike_right_seg = data.Heelstrike_right-data.Heelstrike_right(1)+1;
    data.Heelstrike_left_seg = data.Heelstrike_left-data.Heelstrike_left(1)+1;

    save(fl{f},'data','-append');
    display(['Segmenting joint angle data and adjusting events for ' file_name])
    clearvars -except f fl fld_processed
end
%
end