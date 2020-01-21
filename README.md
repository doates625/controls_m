# controls_m
Matlab package for control systems and DSP
Written by Dan Oates (WPI Class of 2020)

### Description
This package contains classes and functions relating to control systems and digital signal processing. The files in this package are described below:

- PID : Class for discrete-time PID control
- Integrator : Class for asynchronous numerical integration
- ClampLimiter : Class for clamp-limiting signals
- SlewLimiter : Class for limiting the rate of a signal
- clamp : Function to clamp limit the range of a signal
- wrap : Function to modulo limit the range of a signal

### Package Dependencies
- [timing_m](https://github.com/doates625/timing_m.git)

### Cloning and Submodules
Clone this repo as '+controls' and add the containing dir to the Matlab path.