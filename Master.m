%% MASTER CODE FOR CRP PD PARKINSON MANUSCRIPT

% run startZoo.m and add Toolbox to path
% add Supporting Functions folder to path

%% STEP 0: SET PATHS

% Set paths
clc;clear;close all
fld_root = pwd;                                      % root folder (kiel collab\PD_Project)
fld_raw = [fld_root, filesep, 'raw data'];
fld_processed = [fld_root, filesep, 'processed'];    % setting path for processed folder
copyfile(fld_raw, fld_processed)

%% STEP 1: RE-DEFINE IMU DATA 
% This step modifies the IMU units from Kiel dataset because Matlab FUSE
% function requires Acc data in m/s^2, Gyro data in rad/s, Mag data in uT

% Re-define IMU data using redefine_IMU function
Redefine_IMU(fld_processed)

%% STEP 2: FILTER DATA
% This step filters all IMU data

% Set filter parameters
filt.type = 'butterworth';
filt.cutoff = 6;
filt.order = 4;
filt.pass = 'lowpass';

% Filters data using IMU_filt function
IMU_filt(fld_processed,filt)

%% STEP 3: CALCULATE JOINT ANGLES
% This steps calculates Hip and Knee sagittal plane joint angles using a
% sensor fusion algorithm in MATLAB. 

% This step also fixes labeling issues w/ subj = {'pp091','pp128','pp150'};

% Calculates joint angles using IMU_JointAng function
IMU_JointAng(fld_processed)

%% STEP 4: IDENTIFY HEELSTRIKES
  
% ID Heelstrikes 
ID_heelstrike(fld_processed)

%% STEP 5: SEGMENT DATA

% Segment data and adjust events
Segment_data(fld_processed)

%% STEP 6: VIEW SEGMENTED JOINT ANGLES 

% View segmented joint angles by participant
View_Angles(fld_processed) 

%% STEP 7: CALCULATE PHASE ANGLE AND CRP BASED ON SEGMENTED DATA

% Calculates phase angle and CRP using entire waveform to manage
% edge-effects by padding with 10 frames of extraneous data
IMU_phase(fld_processed)

%% STEP 8: VIEW CRP    

% View segmented joint angles, PA, CRP angles by participants
 View_CRP(fld_processed)

%% STEP 9: EXTRACT AND AVERAGE GAIT CYCLES

% Extract, Segment, and Store Individual Gait cycles
Extract_gait_cycles(fld_processed)

% Takes the mean of hip and knee, and CRP gait cycles
mean_trials(fld_processed)

% Extracts Joint Angle ROM
JtROM(fld_processed)
