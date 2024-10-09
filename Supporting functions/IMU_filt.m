function [] = IMU_filt(fld_processed,filt)
%Filters IMU data using biomechzoo filter_line function

fl = engine('path',fld_processed, 'extension', 'mat');
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path, filesep, file_name, '.mat'])
    
    fsamp = data.fs;

    data.Acc_filt = filter_line(data.acc,filt,fsamp);
    data.Gyro_filt = filter_line(data.gyro,filt,fsamp);
    data.Magn_filt = filter_line(data.magn,filt,fsamp);
    
    save(fl{f},'data','-append');
    disp(['Filtering IMU acc, gyro, and mag data for ', file_name])
end