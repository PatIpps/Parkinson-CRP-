function [] = organize_export(fld_processed)

fl = engine('path',fld_processed, 'extension', 'mat');

for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path,filesep,file_name, '.mat'])

    cond = {'fast','slow','preferred'};
    for c = 1:length(cond)

            %Right
            eval(['Ens.HipAng_right_' cond{c} ' = mean(data.RHipAng_seg)']);
            %Ens.CRP_right_fast = data.Avg_Right_CRP;
            %Ens.DP_right_fast = data.Avg_Right_DP; 

            % eval([ 'Ens._KneeAng_right_', cond{c}, '(', num2str(p), ',:) = data.Avg_Right_KneeAng; '])
            % eval([ 'Ens.', group{g},'_CRP_right_', cond{c}, '(', num2str(p), ',:) = data.Avg_Right_CRP; '])
            % eval([ 'Ens.', group{g},'_DP_right_', cond{c}, '(', num2str(p), ',:) = data.Avg_Right_DP; '])
            % eval([ 'Ens.', group{g},'_ROMhip_right_' cond{c}, '(', num2str(p), ',:) = mean(data.RHipROM);'])
            % eval([ 'Ens.', group{g},'_ROMknee_right_' cond{c}, '(', num2str(p), ',:) = mean(data.RKneeROM);'])
            % 
            % %Left
            % eval([ 'Ens.', group{g},'_HipAng_left_', cond{c}, '(', num2str(p), ',:) = data.Avg_Left_HipAng; '])
            % eval([ 'Ens.', group{g},'_KneeAng_left_', cond{c}, '(', num2str(p), ',:) = data.Avg_Left_KneeAng; '])
            % eval([ 'Ens.', group{g},'_CRP_left_', cond{c}, '(', num2str(p), ',:) = data.Avg_Left_CRP; '])
            % eval([ 'Ens.', group{g},'_DP_left_', cond{c}, '(', num2str(p), ',:) = data.Avg_Left_DP; '])
            % eval([ 'Ens.', group{g},'_ROMhip_left_' cond{c}, '(', num2str(p), ',:) = mean(data.LHipROM);'])
            % eval([ 'Ens.', group{g},'_ROMknee_left_' cond{c}, '(', num2str(p), ',:) = mean(data.LKneeROM);'])

        end

    end
    clear data file_pth file_name
end
clear fl



% Clear rows of 0
name = fieldnames(Ens);
for fn = 1:length(name)
    eval(['data_temp = Ens.' char(name(fn)) ';']);
    data_temp( ~any(data_temp,2), : ) = [];  %rows
    eval(['Ens.' char(name(fn)) '= data_temp;';])
end
