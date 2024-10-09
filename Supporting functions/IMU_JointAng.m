function [] = IMU_JointAng(fld_processed)
%This function uses a sensor fusion algorithm in Matlab to calculate
%sagittal plane joint angles for the Hip and Knee

    % Sensors are organized in IMU data as (:,:,n), where n corresponds to
    % sensor location in data.imu_location variable

    %% Loop through files

    fl = engine('path',fld_processed, 'extension', 'mat');
    for f = 1:length(fl)
        [path, file_name] = fileparts(fl{f});
        load([path, filesep, file_name, '.mat'])

        fsamp = data.fs;

        % Based on raw Data, these subjects appear to have confused left and
        % right notion for thigh data. This code corrects for that issue
        subj = {'pp091','pp128','pp150'};

        %Rt Shank
        idx_Rshank = contains(data.imu_location,'right_shank');
        is = find(idx_Rshank);

        disp(['Processing Rshank ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QshankR,~] = FUSE(data.Acc_filt(:,:,is), data.Gyro_filt(:,:,is), data.Magn_filt(:,:,is));
        
        %Lt Shank
        idx_Lshank = contains(data.imu_location,'left_shank');
        is = find(idx_Lshank);

        disp(['Processing Lshank ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QshankL,~] = FUSE(data.Acc_filt(:,:,is), data.Gyro_filt(:,:,is), data.Magn_filt(:,:,is));

        %Rt Ankle
        idx_Rankle = contains(data.imu_location,'right_ankle');
        is = find(idx_Rankle);

        disp(['Processing Rankle ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QankleR,~] = FUSE(data.Acc_filt(:,:,is), data.Gyro_filt(:,:,is), data.Magn_filt(:,:,is));
        
        %Lt ankle
        idx_Lankle = contains(data.imu_location,'left_ankle');
        is = find(idx_Lankle);

        disp(['Processing Lankle ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QankleL,~] = FUSE(data.Acc_filt(:,:,is), data.Gyro_filt(:,:,is), data.Magn_filt(:,:,is));

        % Rt Thigh
        if contains(file_name,subj)
            it = 2; % Switches RIGHT and LEFT thigh data
        else
            idx_Rthigh = contains(data.imu_location,'right_thigh');
            it = find(idx_Rthigh);
        end

        disp(['Processing Rthigh ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QthighR,~] = FUSE(data.Acc_filt(:,:,it), data.Gyro_filt(:,:,it), data.Magn_filt(:,:,it));

        % Lt Thigh
        if contains(file_name,subj)
            it = 2; % Switches RIGHT and LEFT thigh data
        else
            idx_Lthigh = contains(data.imu_location,'left_thigh');
            it = find(idx_Lthigh);
        end

        disp(['Processing Lthigh ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [QthighL,~] = FUSE(data.Acc_filt(:,:,it), data.Gyro_filt(:,:,it), data.Magn_filt(:,:,it));

        % Pelvis
        idx_pelvis = contains(data.imu_location,'pelvis');
        ip = find(idx_pelvis);

        disp(['Processing pelvis ', file_name])
        FUSE = complementaryFilter('AccelerometerGain',0.01,'MagnetometerGain',0.01,'SampleRate',fsamp,'HasMagnetometer',true);
        [Qpelvis,~] = FUSE(data.Acc_filt(:,:,ip), data.Gyro_filt(:,:,ip), data.Magn_filt(:,:,ip));


        % CACULATE JOINT ANGLES

        %Rt Knee (using shank)
        QkneeR_sh = conj(QthighR).*QshankR;
        QkneeR_sh_1 = quat2eul(QkneeR_sh);
        RKneeAng = -rad2deg(QkneeR_sh_1);

        %Rt Knee alternate (using ankle)
        QkneeR_ank = conj(QthighR).*QankleR;
        QkneeR_ank_1 = quat2eul(QkneeR_ank);
        RKneeAng_ank = -rad2deg(QkneeR_ank_1);

        %Lt Knee (using shank)
        QkneeL_sh = conj(QthighL).*QshankL;
        QkneeL_sh_1 = quat2eul(QkneeL_sh);
        LKneeAng = rad2deg(QkneeL_sh_1);

        %Lt Knee alternate (using ankle)
        QkneeL_ank = conj(QthighL).*QankleL;
        QkneeL_ank_1 = quat2eul(QkneeL_ank);
        LKneeAng_ank = rad2deg(QkneeL_ank_1);

        %Rt Hip
        QhipR = conj(Qpelvis).*QthighR;
        QhipR_1 = quat2eul(QhipR);
        RHipAng = -rad2deg(QhipR_1);

        %Lt Hip
        QhipL = conj(Qpelvis).*QthighL;
        QhipL_1 = quat2eul(QhipL);
        LHipAng = -rad2deg(QhipL_1);
    

    % Save variables: Quaternions
    data.Qpelvis = Qpelvis;
    data.QthighR = QthighR;
    data.QthighL = QthighL;
    data.QshankR = QshankR;
    data.QshankL = QshankL;
    data.QankleR = QankleR;
    data.QankleL = QankleL;

    % Save variables: Joint angles
    data.RHipAng = RHipAng;
    data.LHipAng = LHipAng;
    data.RKneeAng = RKneeAng;
    data.RKneeAng_ank = RKneeAng_ank;
    data.LKneeAng = LKneeAng;
    data.LKneeAng_ank = LKneeAng_ank;

    save(fl{f},'data','-append');
    disp(['Exporting Joint Angles for ', file_name])
    clearvars -except f fl fld_processed

    end
end