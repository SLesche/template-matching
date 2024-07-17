function [problem] = define_optim_problem(objective_func)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
lb = [0.20, 0.33];
ub = [20, 2];

rng default % For reproducibility
opts = optimoptions(@fmincon,'Algorithm','sqp');

problem = createOptimProblem('fmincon','objective',...
    @(x) objective_func(x(1), x(2)),'x0',[1 1] + normrnd(0, 0.01, 1, 2),'lb',lb,'ub',ub,'options',opts);

end