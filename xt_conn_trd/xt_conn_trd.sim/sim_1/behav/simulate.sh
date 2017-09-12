#!/bin/sh -f
xv_path="/home/ppan/Xilinx/Vivado/2014.3.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim board_behav -key {Behavioral:sim_1:Functional:board} -tclbatch ../../../../scripts/xsim_wave_loopback.tcl -log simulate.log -testplusarg TESTNAME=basic_test
