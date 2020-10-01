# SPR 2020 symposium talk: generalized eigendecomposition


This repository contains the code and presentation slides for my talk at the 2020 [Society for Psychophysiological Research (SPR) Annual Meeting's](https://sprweb.org/general/custom.asp?page=2020_Program) symposium—To predict or not to predict: Modeling EEG data, promises, and limitations. 

Talk title: **Hypothesis-driven dimension reduction and source separation for time-domain EEG data** 

This project is possible thanks to [SPR's research training grant](https://sprweb.org/page/Grants_Awards).

## Instructions

[Download the entire repository here](https://github.com/hauselin/spr2020-eeg-dim-reduction-source-separate/archive/master.zip). To run the demo/tutorial, simulations, and analyses, open `simulations.m` in MATLAB.

Remember to set up your working directory or add folder to path first.

This `simulations.m` MATLAB script simulates different sine waves at different sources/dipoles, mixes their activity and projects them to 64 scalp EEG electrodes, and performs generalized eigendecomposition (GED) on the simulated scalp EEG data (with sources mixed) to recover the simulated spatiotemporal and frequency characteristics.

Helper functions called by `simulations.m`: `dipole_project.m`, `filterFGx.m`, `topoplotIndie.m`

`emptyEEG.mat` contains two structures:
- `EEG` (empty EEGLAB structure for storing EEG data)
- `lf` (leadfield matrix for projecting dipole activity to 64 channels)

## Symposium talk abstract

**Hypothesis-driven dimension reduction and source separation for time-domain EEG data** 

Authors
- Hause Lin - University of Toronto, Canada
- Mike X Cohen - Donders Institute for Brain, Cognition and Behavior, Radboud University Nijmegen, The Netherlands

We introduce a flexible multivariate analytic framework that can potentially uncover further spatiotemporal neural dynamics that supplement what can be learned from conventional event-related potential (ERP) analyses. This technique—generalized eigen-decomposition (GED)—is conceptually simple and computationally efficient. Like principal or independent components analysis, it leverages the spatiotemporal structure of EEG data and uses matrix decomposition (i.e., eigendecomposition) to reduce data dimension and separate sources. But unlike these methods which are merely descriptive decomposition techniques, GED explicitly incorporates hypothesis testing, allowing re-searchers to flexibly contrast experimental manipulations or cognitive states. Here, we gently introduce the GED framework and show how to implement it. We present a simulation study that demonstrates why and how it is superior to other dimension reduction methods; then, we present two case studies that focus on ERP components related to conflict-monitoring and feedback processes. Our results show that GED recovers single-trial dynamics that may be lost or attenuated during trial-averaging (ERPs) and unmixes overlapping temporal and spatial information. We hope ERP researchers will now have yet another simple but versatile tool that not only complements existing methods but also provides further insights into spatiotemporal dynamics in time-domain EEG data.