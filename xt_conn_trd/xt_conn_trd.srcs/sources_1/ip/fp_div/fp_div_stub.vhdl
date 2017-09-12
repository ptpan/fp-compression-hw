-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
-- Date        : Tue Jul 25 13:16:05 2017
-- Host        : leopard-ubuntu running 64-bit Ubuntu 14.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/fp_div/fp_div_stub.vhdl
-- Design      : fp_div
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fp_div is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );

end fp_div;

architecture stub of fp_div is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_a_tvalid,s_axis_a_tdata[63:0],s_axis_b_tvalid,s_axis_b_tdata[63:0],m_axis_result_tvalid,m_axis_result_tdata[63:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "floating_point_v7_0,Vivado 2014.3.1";
begin
end;
