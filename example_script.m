clear all

% Setting paths
% Get the directory of the currently executing script
[filepath, ~, ~] = fileparts(mfilename('fullpath'));

% Set the current directory to that directory
cd(filepath);
addpath("./functions") % add template matching functions
addpath("./app") % add app functions

load("saved_data/example_time_vector.mat");

condition_bins = [1, 2];
n_conditions = length(condition_bins);

% Convert to cell array with conditionsXn_subject entries 
component_names = ["p3_flanker"];
n_components = length(component_names);
electrodes = [11];
polarity = ["positive"];
windows = {[250 600]};

% For fitting
possible_approaches = ["maxcor", "minsq"];
possible_weights = ["get_normalized_weights"];
possible_normalization = ["none"];
possible_penalty = ["none"];
possible_derivative = [0, 1];

% This combines all possible approaches
% If you only want one specific approach, only create one row of the comb table:
% method_table = 
comb = combinations(possible_approaches, possible_weights, ...
    possible_penalty, possible_normalization, possible_derivative, ...
    component_names, polarity, electrodes, windows ...
    );

% add peak/area with no weights/normalization/penalty
comb(end+1, :) = {"peak", "none", "none", "none", 0, component_names, polarity, electrodes, windows};
comb(end+1, :) = {"area", "none", "none", "none", 0,  component_names, polarity, electrodes, windows};
comb(end+1, :) = {"liesefeld_area", "none", "none", "none", 0,  component_names, polarity, electrodes, windows};

column_names = {'approach', 'weight', 'penalty', 'normalization', 'use_derivative', 'component_name', 'polarity', 'electrodes', 'window'};
comb.Properties.VariableNames = column_names;

file = strcat("saved_data/", "example_data.mat");
load(file)

erp_data = erp_mat(:, :, :, condition_bins); % Only fit data for the condition bins that are relevant
[n_subjects, n_chans, n_times, n_bins] = size(erp_data);

results_mat = run_template_matching(erp_data, time_vec, comb, 3); % Run the third (3) method saved in comb. You can run any 

% Initialize the review app
% review_app
