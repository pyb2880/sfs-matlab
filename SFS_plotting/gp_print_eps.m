function cmd = gp_print_eps(p)
%GP_PRINT_EPS returns the gnuplot command to print to eps
%
%   See also: plot_wavefield


%*****************************************************************************
% Copyright (c) 2010-2013 Quality & Usability Lab, together with             *
%                         Assessment of IP-based Applications                *
%                         Deutsche Telekom Laboratories, TU Berlin           *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% Copyright (c) 2013      Institut fuer Nachrichtentechnik                   *
%                         Universitaet Rostock                               *
%                         Richard-Wagner-Strasse 31, 18119 Rostock           *
%                                                                            *
% This file is part of the Sound Field Synthesis-Toolbox (SFS).              *
%                                                                            *
% The SFS is free software:  you can redistribute it and/or modify it  under *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% The SFS is distributed in the hope that it will be useful, but WITHOUT ANY *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% The SFS is a toolbox for Matlab/Octave to  simulate and  investigate sound *
% field  synthesis  methods  like  wave  field  synthesis  or  higher  order *
% ambisonics.                                                                *
%                                                                            *
% http://dev.qu.tu-berlin.de/projects/sfs-toolbox       sfstoolbox@gmail.com *
%*****************************************************************************


%% ===== Checking of input parameters ====================================
nargmin = 1;
nargmax = 1;
nargchkin(nargmin,nargmax);


%% ===== Main ============================================================
% converts the size to inches
if strcmp('cm',p.size_unit)
    p.size = cm2in(p.size);
elseif strcmp('px',p.size_unit);
    p.size = px2in(p.size);
end

% get plotting command, including loudspeaker symbols and sound field
cmd_plot = gp_get_plot_command(p);

%% === set common Gnuplot commands
cmd = sprintf([...
'#!/usr/bin/gnuplot\n', ...
'# generated by SFS-Toolbox, see: http://github.com/sfstoolbox/sfs\n', ...
'set t postscript eps size %i,%i enhanced color font ''Helvetica,20''\n', ...
'set output ''%s'';\n', ...
'set style line 1 lc rgb ''#000000'' pt 2 ps 2 lw 2\n\n', ...
'unset key\n', ...
'set size ratio -1\n\n', ...
'# border\n', ...
'set style line 101 lc rgb ''#808080'' lt 1 lw 1\n', ...
'set border front ls 101\n\n', ...
'set colorbox\n', ...
'set palette gray negative\n', ...
'set xrange [%f:%f]\n', ...
'set yrange [%f:%f]\n', ...
'set cbrange [%f:%f]\n', ...
'set tics scale 0.75\n', ...
'set cbtics scale 0\n', ...
'set xtics 1\n', ...
'set ytics 1\n', ...
'set cbtics %f\n', ...
'set xlabel ''%s''\n', ...
'set ylabel ''%s''\n', ...
'set label ''%s'' at screen 0.84,0.09\n', ...
'%s\n', ...
'%s\n'], ...
p.size(1),p.size(2), ...
p.file, ...
p.xmin,p.xmax, ...
p.ymin,p.ymax, ...
p.caxis(1),p.caxis(2), ...
p.cbtics, ...
p.xlabel, ...
p.ylabel, ...
gp_get_label(p.dim,p.unit,'eps'), ...
p.cmd, ...
cmd_plot ...
);
