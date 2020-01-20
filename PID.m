classdef PID < handle
    %PID Class for discrete-time PID control
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (SetAccess = protected)
        k_p;    % P-gain [double]
        k_i;    % I-gain [double]
        k_d;    % D-gain [double]
        u_min;  % Min output [double]
        u_max;  % Max output [double]
        f_ctrl; % Ctrl frequency [Hz]
        t_ctrl; % Ctrl period [s]
    end
    
    properties (Access = protected)
        u;              % Ctrl output [double]
        u_p;            % P-output [double]
        u_i;            % I-output [double]
        u_d;            % D-output [double]
        err_prev;       % Previous error [double]
        first_frame;    % First-frame flag [logical]
    end
    
    methods
        function obj = PID(k_p, k_i, k_d, u_min, u_max, f_ctrl)
            %obj = PID(k_p, k_i, k_d, u_min, u_max, f_ctrl)
            %   Construct discrete-time PID controller
            %   
            %   Inputs:
            %   - k_p = P-gain
            %   - k_i = I-gain
            %   - k_d = D-gain
            %   - u_min = Min output
            %   - u_max = Max output
            %   - f_ctrl = Ctrl frequency [Hz]
            obj.f_ctrl = f_ctrl;
            obj.t_ctrl = 1 / f_ctrl;
            obj.set_gains(k_p, k_i, k_d);
            obj.set_limits(u_min, u_max);
            obj.reset();
        end
        
        function set_gains(obj, k_p, k_i, k_d)
            %SET_GAINS(obj, k_p, k_i, k_d) Set PID gains
            obj.set_k_p(k_p);
            obj.set_k_i(k_i);
            obj.set_k_d(k_d);
        end
        
        function set_k_p(obj, k_p)
            %SET_K_P(obj, k_p) Set P-gain
            obj.k_p = k_p;
        end
        
        function set_k_i(obj, k_i)
            %SET_K_I(obj, k_i) Set I-gain
            obj.k_i = obj.t_ctrl * k_i;
        end
        
        function set_k_d(obj, k_d)
            %SET_K_D(obj, k_d) Set D-gain
            obj.k_d = obj.f_ctrl * k_d;
        end
        
        function set_limits(obj, u_min, u_max)
            %SET_LIMITS(obj, u_min, u_max) Set output limits
            obj.set_u_min(u_min);
            obj.set_u_max(u_max);
        end
        
        function set_u_min(obj, u_min)
            %SET_U_MIN(obj, u_min) Set min output
            obj.u_min = u_min;
        end
        
        function set_u_max(obj, u_max)
            %SET_U_MAX(obj, u_max) Set max output
            obj.u_max = u_max;
        end
        
        function u = update(obj, err, ff, sat)
            %u = UPDATE(obj, err, ff, sat)
            %   Update controller
            %   Inputs:
            %   - err = Setpoint error
            %   - ff = Feed-forward output [default 0]
            %   - sat = Saturation flag [logical]
            %   
            %   Outputs:
            %   - u = Control output
            %   
            %   The saturation flag defaults to false. If true, integral
            %   accumulation is stopped to prevent windup.
            
            % Imports
            import('controls.clamp');
            
            % P-control
            obj.u_p = obj.k_p * err;
            
            % I-control
            if nargin < 4, sat = false; end
            int_pos = (err > 0 && obj.u < obj.u_max);
            int_neg = (err < 0 && obj.u > obj.u_min);
            if (int_pos || int_neg) && ~sat
                obj.u_i = obj.u_i + obj.k_i * err;
            end
            
            % D-control
            if obj.first_frame
                obj.u_d = 0;
                obj.first_frame = false;
            else
                err_diff = err - obj.err_prev;
                obj.u_d = obj.k_d * err_diff;
            end
            obj.err_prev = err;
            
            % Feed-forward
            if nargin < 3, ff = 0; end
            
            % Combine
            obj.u = obj.u_p + obj.u_i + obj.u_d + ff;
            obj.u = clamp(obj.u, obj.u_min, obj.u_max);
            u = obj.u;
        end
        
        function reset(obj)
            %RESET(obj) Reset PID to startup state
            obj.u = 0;
            obj.u_p = 0;
            obj.u_i = 0;
            obj.u_d = 0;
            obj.err_prev = 0;
            obj.first_frame = false;
        end
    end
end