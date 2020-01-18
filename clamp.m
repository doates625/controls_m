function y = clamp(x, y_min, y_max)
%y = CLAMP(x, y_min, y_max) Clamp limits x to range [y_min, y_max]
%   
%   Inputs:
%       x = Array of m n-dimensional inputs [n x m]
%       y_min = Minimum output vector [n x 1]
%       y_max = Maximum output vector [n x 1]
%   Outputs:
%       y = Limited outputs [n x m]
%   
%   Author: Dan Oates (WPI Class of 2020)

y = min(max(y_min, x), y_max);

end