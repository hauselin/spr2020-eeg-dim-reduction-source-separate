function [cfg] = dipole_project(cfg)
% diapole_project
% 
% requires emptyEEG.mat and leadfield matrix
% emptyEEG.mat contains EEG and lf structures
% lf structure projects 2004 dipoles/sources to 64 EEG scalp channels
%
% Written in MATLAB R2018b
% Last modified by Hause Lin 19-10-06 12:40 hauselin@gmail.com

if nargin == 0 % if no input provided, return function argument information
    disp('dipole_project function parameters: ');
    struct('EEG','eeglab data structure (default: loads from emptyEEG.mat)',...
        'lf','leadfield matrix (default: loads from emptyEEG.mat)',...
        'nrandom','number of random dipoles (default: 2)',...
        'dipoleIdx','dipole index (default: random)',...
        'dipoleOri','dipole position: 1, 2, 3 (default: [1 2 3])',...
        'view','plot view (e.g., [0 90], default: 3d)',...
        'fig','figure number (default: next)',...
        'chans','channels to project to (default: all channels)')
    return
end

load emptyEEG;

cfg.EEG = EEG;
cfg.lf = lf;

if ~isfield(cfg,'dipoleIdx') % if no dipoleIdx provided, randomly select dipoleIdx
    if ~isfield(cfg,'nrandom')
        cfg.nrandom = 2; % default plots 2 random dipoles
    end
    cfg.dipoleIdx = randi([1 size(lf.Gain,3)],1,cfg.nrandom); % generate random dipoleIdx for plotting
else
    cfg.nrandom = 0;
end

if ~isfield(cfg,'dipoleOri') % 3 dipoles per location (can be 1, 2, or 3)
    cfg.dipoleOri = [1 2 3]; % default [1 2 3]
end

if ~isfield(cfg,'chans')
    cfg.chans = {EEG.chanlocs.labels};
    cfg.chanIdx = 1:EEG.nbchan;
else
    cfg.chanIdx = find(ismember({EEG.chanlocs.labels},cfg.chans));
end
    
if isfield(cfg,'fig') % determine figure number
    figure(cfg.fig); clf
else
    figure % default next figure
end

if ~isfield(cfg,'view') % e.g., view: [0 90]
    cfg.view = '3d';
end

subplotr = 1 + length(cfg.dipoleOri); % number of rows in subplot

% plot dipoles
for d=1:length(cfg.dipoleIdx)
    % plot all dipoles
    subplot(subplotr,length(cfg.dipoleIdx),d)
    plot3(lf.GridLoc(:,1), lf.GridLoc(:,2), lf.GridLoc(:,3), '.','markerfacecolor','w')
    
    % locate dipole
    hold on
    plot3(lf.GridLoc(cfg.dipoleIdx(d),1),lf.GridLoc(cfg.dipoleIdx(d),2),lf.GridLoc(cfg.dipoleIdx(d),3),'ro','markerfacecolor','r','markersize',10)
    title(['Dipole ' num2str(cfg.dipoleIdx(d))])
    rotate3d on, axis square
    try
        view(cfg.view(1),cfg.view(2))
    end
    
    % plot dipole scalp projection
    for sp=1:length(cfg.dipoleOri)
        plotidx = d+length(cfg.dipoleIdx) * sp;
        subplot(subplotr,length(cfg.dipoleIdx),plotidx)
        topoplotIndie(-lf.Gain(cfg.chanIdx,cfg.dipoleOri(sp),cfg.dipoleIdx(d)),EEG.chanlocs(cfg.chanIdx),'numcontour',0,'electrodes','off','shading','interp');
        title(['Dipole orientation ' num2str(cfg.dipoleOri(sp))])
    end
end

end

