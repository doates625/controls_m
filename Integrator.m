classdef Integrator < handle
    %INTEGRATOR Class for asynchronous numerical integration
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties
        x_int;  % Integral [double]
        timer;  % Timer [Timer]
    end
    
    methods
        function obj = Integrator(x_init)
            %INTEGRATOR Construct async integrator
            %   obj = INTEGRATOR(x_init) Initial value = x_init
            %   obj = INTEGRATOR() Initial value = 0
            if nargin < 1, x_init = 0; end
            obj.x_int = x_init;
            obj.timer = Timer();
        end
        
        function x_int = update(obj, x, delta_t)
            %UPDATE Add x to integral
            %   
            %   x_int = UPDATE(obj, x, delta_t) Adds x scaled by delta_t
            %   
            %   x_int = UPDATE(obj, x) Sets delta_t to measured time in
            %   seconds since last call to update(...)
            
            % Handle timing
            if nargin < 3
                delta_t = obj.timer.toc();
            end
            obj.timer.tic();
            
            % Update integral
            obj.x_int = obj.x_int + x * delta_t;
            x_int = obj.x_int;
        end
        
        function set(obj, x_int)
            %SET(obj, x_int) Override integral to x_int and reset timer
            obj.x_int = x_int;
            obj.timer.tic();
        end
    end
end

