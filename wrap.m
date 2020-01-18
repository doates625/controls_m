function y = wrap(x, y_min, y_max)
%y = wrap(x, y_min, y_max) Modulo wraps x to range [y_min, y_max]
%
%   Inputs:
%       x = Array of m n-dimensional inputs [n x m]
%       y_min = Minimum output vector [n x 1]
%       y_max = Maximum output vector [n x 1]
%   Outputs:
%       y = wrapped outputs [n x m]
%   
%   Author: Dan Oates (WPI Class of 2020)

y = mod(x - y_min, y_max - y_min) + y_min;

end