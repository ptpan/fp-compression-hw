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
ExecStep $xv_path/bin/xsim compress_unit_tb_behav -key {Behavioral:sim_1:Functional:compress_unit_tb} -tclbatch compress_unit_tb.tcl -log simulate.log
