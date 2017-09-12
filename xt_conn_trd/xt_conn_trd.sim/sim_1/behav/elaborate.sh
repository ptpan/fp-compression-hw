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
ExecStep $xv_path/bin/xelab -wto 4e57f5d0fdd943e8bf19049d914c2457 -m64 --debug typical --relax --include "../../../../../sources/ip_catalog/axi4lite_crossbar/axi_infrastructure_v1_1/hdl/verilog" --include "../../../../../sources/ip_catalog/axis_ic_rd/axis_interconnect_v1_1/hdl/verilog" --include "../../../../../sources/ip_catalog/axis_ic_wr/axis_interconnect_v1_1/hdl/verilog" -i /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/testbench -i /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/testbench/dsport -i /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/testbench/include -i /home/ppan/vc709/v7_xt_conn_trd/hardware/sources/hdl/gen_chk -d "USE_PIPE_SIM=1" -d "SIMULATION=1" -d "USE_XPHY=1" -d "NW_PATH_ENABLE=1" -L xbip_utils_v3_0 -L axi_utils_v2_0 -L xbip_pipe_v3_0 -L xbip_dsp48_wrapper_v3_0 -L xbip_dsp48_addsub_v3_0 -L xbip_bram18k_v3_0 -L mult_gen_v12_0 -L floating_point_v7_0 -L xil_defaultlib -L axi_bram_ctrl_v4_0 -L lib_pkg_v1_0 -L fifo_generator_v12_0 -L lib_fifo_v1_0 -L lib_srl_fifo_v1_0 -L lib_cdc_v1_0 -L axi_datamover_v5_1 -L axi_sg_v4_1 -L axi_dma_v7_1 -L blk_mem_gen_v8_2 -L generic_baseblocks_v2_1 -L axi_infrastructure_v1_1 -L axi_register_slice_v2_1 -L axi_data_fifo_v2_1 -L axi_crossbar_v2_1 -L axis_interconnect_v1_1 -L ten_gig_eth_mac_v14_0 -L ten_gig_eth_pcs_pma_v5_0 -L unisims_ver -L unimacro_ver -L secureip --snapshot board_behav xil_defaultlib.board xil_defaultlib.glbl -log elaborate.log
