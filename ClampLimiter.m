classdef ClampLimiter < handle
    %CLAMPLIMITER Class for clamp-limiting signals
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (Access = private)
        y_min;  % Minimum output
        y_max;  % Maximum output
    end
    
    methods (Access = public)
        function obj = ClampLimiter(varargin)
            %CLAMPLIMITER Construct an instance of this class
            %   
            %   obj = CLAMPLIMITER(x_min, x_max) will limit inputs x to
            %       range [y_min, y_max]
            %   
            %   obj = CLAMPLIMITER(y_max) will limit inputs x to
            %       range [-y_max, +y_max]
            if nargin == 2
                obj.y_min = varargin{1};
                obj.y_max = varargin{2};
            elseif nargin == 1
                obj.y_min = -varargin{1};
                obj.y_max = +varargin{1};
            else
                error('Invalid number of arguments.')
            end
        end
        
        function set_min(obj, y_min)
            %SET_MIN(obj, y_min) Sets minimum output to y_min
            obj.y_min = y_min;
        end
        
        function set_max(obj, y_max)
            %SET_MAX(obj, y_max) Sets maximum output to y_max
            obj.y_max = y_max;
        end
        
        function y = update(obj, x)
            %y = UPDATE(obj, x) Returns x clamped to range [y_min, y_max]
            y = clamp(x, obj.y_min, obj.y_max);
        end
    end
end