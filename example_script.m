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
electrodes = {[11]};
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
% comb = cell2table({"minsq", "get_normalized_weights", "none", "none", 0, "p3_flanker", "positive", [11], [200 650]}}

comb = combinations(possible_approaches, possible_weights, ...
    possible_penalty, possible_normalization, possible_derivative, ...
    component_names, polarity, electrodes, windows ...
    );

% add peak/area with no weights/normalization/penalty
comb(end+1, :) = {"peak", "none", "none", "none", 0, component_names(1), polarity(1), electrodes{1}, windows{1}};
comb(end+1, :) = {"area", "none", "none", "none", 0,  component_names(1), polarity(1), electrodes{1}, windows{1}};
comb(end+1, :) = {"liesefeld_area", "none", "none", "none", 0,  component_names(1), polarity(1), electrodes{1}, windows{1}};

column_names = {'approach', 'weight', 'penalty', 'normalization', 'use_derivative', 'component_name', 'polarity', 'electrodes', 'window'};
comb.Properties.VariableNames = column_names;

file = strcat("saved_data/", "example_data.mat");
load(file)

erp_data = erp_mat(:, :, :, condition_bins); % Only fit data for the condition bins that are relevant
[n_subjects, n_chans, n_times, n_bins] = size(erp_data);

% If you can use the Parallel Computing Toolbox
results_mat = run_template_matching(erp_data, time_vec, comb, 3); % Run the third (3) method saved in comb. You can run any 
% results_mat = run_template_matching_serial(erp_data, time_vec, comb, 3); % Much slower!

% The results matrix will consist of 5 columns and n_subjects rows
% the columns will be: a_param, b_param, latency, fit_cor, fit_dist

% Initialize the review app
% review_app
