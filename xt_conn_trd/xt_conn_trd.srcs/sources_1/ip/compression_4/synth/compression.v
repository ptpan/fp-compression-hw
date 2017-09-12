// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: UIUC.CSL.iCSL:user:axis_compression:1.9
// IP Revision: 2

(* X_CORE_INFO = "system_design,Vivado 2014.3.1" *)
(* CHECK_LICENSE_TYPE = "compression,system_design,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module compression (
  clk,
  resetn,
  tready,
  tdata,
  tvalid,
  tlast,
  m_axis_mm2s_tready,
  m_axis_mm2s_tdata,
  m_axis_mm2s_tkeep,
  m_axis_mm2s_tvalid,
  m_axis_mm2s_tlast
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 signal_clock CLK" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 signal_reset RST" *)
input wire resetn;
output wire tready;
input wire [255 : 0] tdata;
input wire tvalid;
input wire tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_mm2s TREADY" *)
input wire m_axis_mm2s_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_mm2s TDATA" *)
output wire [255 : 0] m_axis_mm2s_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_mm2s TKEEP" *)
output wire [31 : 0] m_axis_mm2s_tkeep;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_mm2s TVALID" *)
output wire m_axis_mm2s_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_mm2s TLAST" *)
output wire m_axis_mm2s_tlast;

  system_design inst (
    .clk(clk),
    .resetn(resetn),
    .tready(tready),
    .tdata(tdata),
    .tvalid(tvalid),
    .tlast(tlast),
    .m_axis_mm2s_tready(m_axis_mm2s_tready),
    .m_axis_mm2s_tdata(m_axis_mm2s_tdata),
    .m_axis_mm2s_tkeep(m_axis_mm2s_tkeep),
    .m_axis_mm2s_tvalid(m_axis_mm2s_tvalid),
    .m_axis_mm2s_tlast(m_axis_mm2s_tlast)
  );
endmodule
