-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
-- Date        : Tue Sep  5 10:47:51 2017
-- Host        : leopard-ubuntu running 64-bit Ubuntu 14.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ppan/vc709/v7_xt_conn_trd/hardware/vivado/runs/xt_conn_trd.srcs/sources_1/ip/compression_4/compression_stub.vhdl
-- Design      : compression
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity compression is
  Port ( 
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    tready : out STD_LOGIC;
    tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    tvalid : in STD_LOGIC;
    tlast : in STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC
  );

end compression;

architecture stub of compression is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,resetn,tready,tdata[255:0],tvalid,tlast,m_axis_mm2s_tready,m_axis_mm2s_tdata[255:0],m_axis_mm2s_tkeep[31:0],m_axis_mm2s_tvalid,m_axis_mm2s_tlast";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "system_design,Vivado 2014.3.1";
begin
end;
