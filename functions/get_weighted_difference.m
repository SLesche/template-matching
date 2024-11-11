function [diff] = get_weighted_difference(signal_1, signal_2, weights)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    
    diff = sum(weights.*abs((signal_1 - signal_2)), "omitnan")/sum(weights, "omitnan");
end