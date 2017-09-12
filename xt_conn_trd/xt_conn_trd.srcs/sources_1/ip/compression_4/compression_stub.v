// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Tue Sep  5 10:47:51 2017
// Host        : leopard-ubuntu running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/compression_stub.v
// Design      : compression
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "system_design,Vivado 2014.3.1" *)
module compression(clk, resetn, tready, tdata, tvalid, tlast, m_axis_mm2s_tready, m_axis_mm2s_tdata, m_axis_mm2s_tkeep, m_axis_mm2s_tvalid, m_axis_mm2s_tlast)
/* synthesis syn_black_box black_box_pad_pin="clk,resetn,tready,tdata[255:0],tvalid,tlast,m_axis_mm2s_tready,m_axis_mm2s_tdata[255:0],m_axis_mm2s_tkeep[31:0],m_axis_mm2s_tvalid,m_axis_mm2s_tlast" */;
  input clk;
  input resetn;
  output tready;
  input [255:0]tdata;
  input tvalid;
  input tlast;
  input m_axis_mm2s_tready;
  output [255:0]m_axis_mm2s_tdata;
  output [31:0]m_axis_mm2s_tkeep;
  output m_axis_mm2s_tvalid;
  output m_axis_mm2s_tlast;
endmodule
