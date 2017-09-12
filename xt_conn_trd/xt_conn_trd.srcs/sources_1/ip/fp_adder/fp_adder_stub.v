// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Tue Jul 25 13:13:54 2017
// Host        : leopard-ubuntu running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_adder/fp_adder_stub.v
// Design      : fp_adder
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "floating_point_v7_0,Vivado 2014.3.1" *)
module fp_adder(aclk, s_axis_a_tvalid, s_axis_a_tdata, s_axis_b_tvalid, s_axis_b_tdata, m_axis_result_tvalid, m_axis_result_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_a_tvalid,s_axis_a_tdata[63:0],s_axis_b_tvalid,s_axis_b_tdata[63:0],m_axis_result_tvalid,m_axis_result_tdata[63:0]" */;
  input aclk;
  input s_axis_a_tvalid;
  input [63:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  input [63:0]s_axis_b_tdata;
  output m_axis_result_tvalid;
  output [63:0]m_axis_result_tdata;
endmodule
