function [] = Redefine_IMU(fld_processed)

%This function modifies the units from Kiel dataset because Matlab FUSE
%function requires Acc data in m/s^2, Gyro data in rad/s, Mag data in uT

%% STEP 1 RE-DEFINE VARIABLES

fl = engine('path',fld_processed, 'extension', 'mat');
for f = 1:length(fl)
    [path, file_name] = fileparts(fl{f});
    load([path,filesep,file_name, '.mat'])

    %Acceleration is multiplied by 9.81, b/c Kiel data is in g.
    data.acc=data.acc.*9.81;

    %Gyro data is converted to rad b/c Kiel data is in °/s
    data.gyro=deg2rad(data.gyro);

    %Magn data is multiplied by 100 b/c Kiel data is in gauss and we need uT.
    data.magn=data.magn*100;

    save(fl{f},'data','-append');
    disp(['Adjusting IMU acc, gyro, and mag data for ', file_name])

end