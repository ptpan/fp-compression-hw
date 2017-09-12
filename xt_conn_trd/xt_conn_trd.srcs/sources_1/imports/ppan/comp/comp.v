`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2017 01:42:07 PM
// Design Name: 
// Module Name: comp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comp #(
parameter           AXIS_TDATA_WIDTH        = 256, 
parameter           AXIS_TKEEP_WIDTH        = (AXIS_TDATA_WIDTH / 8)
)
(
// input signals, to be converted to data
input                                    axis_s2c0_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_s2c0_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_s2c0_tkeep,
input                                    axis_s2c0_tvalid,
output                                   axis_s2c0_tready, 
input                                    axis_s2c0_aresetn, 
input                                    axis_s2c0_aclk,
// output signals to VFIFO
output                                   axis_s2c0_tlast_2vfifo, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_s2c0_tdata_2vfifo, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_s2c0_tkeep_2vfifo, 
output                                   axis_s2c0_tvalid_2vfifo,
input                                    axis_s2c0_tready_2vfifo,  

// input signals, to be converted to data
input                                    axis_s2c1_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_s2c1_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_s2c1_tkeep,
input                                    axis_s2c1_tvalid,
output                                   axis_s2c1_tready, 
input                                    axis_s2c1_aresetn, 
input                                    axis_s2c1_aclk,
// output signals to s2c1
output                                   axis_s2c1_tlast_2vfifo, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_s2c1_tdata_2vfifo, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_s2c1_tkeep_2vfifo, 
output                                   axis_s2c1_tvalid_2vfifo,
input                                    axis_s2c1_tready_2vfifo,  

// input signals, to be converted to data
input                                    axis_s2c2_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_s2c2_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_s2c2_tkeep,
input                                    axis_s2c2_tvalid,
output                                   axis_s2c2_tready, 
input                                    axis_s2c2_aresetn, 
input                                    axis_s2c2_aclk,
// output signals to s2c2
output                                   axis_s2c2_tlast_2vfifo, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_s2c2_tdata_2vfifo, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_s2c2_tkeep_2vfifo, 
output                                   axis_s2c2_tvalid_2vfifo,
input                                    axis_s2c2_tready_2vfifo,  

// input signals, to be converted to data
input                                    axis_s2c3_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_s2c3_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_s2c3_tkeep,
input                                    axis_s2c3_tvalid,
output                                   axis_s2c3_tready, 
input                                    axis_s2c3_aresetn, 
input                                    axis_s2c3_aclk,
// output signals to s2c3
output                                   axis_s2c3_tlast_2vfifo, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_s2c3_tdata_2vfifo, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_s2c3_tkeep_2vfifo, 
output                                   axis_s2c3_tvalid_2vfifo,
input                                    axis_s2c3_tready_2vfifo,  

input                                    user_clk, 
input                                    user_reset
);

compression s2c0_compression_inst(//    .channel_no(2'd0),
    .clk(axis_s2c0_aclk), 
    .resetn(axis_s2c0_aresetn),

    .tdata(axis_s2c0_tdata),
//    .tkeep(axis_s2c0_tkeep),
    .tvalid(axis_s2c0_tvalid),
    .tlast(axis_s2c0_tlast),

    .m_axis_mm2s_tlast(axis_s2c0_tlast_2vfifo),
    .m_axis_mm2s_tdata(axis_s2c0_tdata_2vfifo), 
    .m_axis_mm2s_tkeep(axis_s2c0_tkeep_2vfifo),
    .m_axis_mm2s_tvalid(axis_s2c0_tvalid_2vfifo), 
    .m_axis_mm2s_tready(axis_s2c0_tready_2vfifo),
    .tready(axis_s2c0_tready)
);

assign axis_s2c1_tlast_2vfifo = axis_s2c1_tlast; 
assign axis_s2c1_tdata_2vfifo = axis_s2c1_tdata;
assign axis_s2c1_tkeep_2vfifo = axis_s2c1_tkeep;
assign axis_s2c1_tvalid_2vfifo = axis_s2c1_tvalid;
assign axis_s2c1_tready = axis_s2c1_tready_2vfifo;

assign axis_s2c2_tlast_2vfifo = axis_s2c2_tlast; 
assign axis_s2c2_tdata_2vfifo = axis_s2c2_tdata;
assign axis_s2c2_tkeep_2vfifo = axis_s2c2_tkeep;
assign axis_s2c2_tvalid_2vfifo = axis_s2c2_tvalid;
assign axis_s2c2_tready = axis_s2c2_tready_2vfifo;

assign axis_s2c3_tlast_2vfifo = axis_s2c3_tlast; 
assign axis_s2c3_tdata_2vfifo = axis_s2c3_tdata;
assign axis_s2c3_tkeep_2vfifo = axis_s2c3_tkeep;
assign axis_s2c3_tvalid_2vfifo = axis_s2c3_tvalid;
assign axis_s2c3_tready = axis_s2c3_tready_2vfifo;


/*
compression s2c1_compression_inst(
    //.channel_no(2'd1),
    .clk(axis_s2c1_aclk), 
    .resetn(axis_s2c1_aresetn),

    .tdata(axis_s2c1_tdata),
//    .tkeep(axis_s2c1_tkeep),
    .tvalid(axis_s2c1_tvalid),
    .tlast(axis_s2c1_tlast),

    .m_axis_mm2s_tlast(axis_s2c1_tlast_2vfifo),
    .m_axis_mm2s_tdata(axis_s2c1_tdata_2vfifo), 
    .m_axis_mm2s_tkeep(axis_s2c1_tkeep_2vfifo),
    .m_axis_mm2s_tvalid(axis_s2c1_tvalid_2vfifo), 
    .m_axis_mm2s_tready(axis_s2c1_tready_2vfifo),
    .tready(axis_s2c1_tready)
);
compression s2c2_compression_inst(
    //.channel_no(2'd2),
    .clk(axis_s2c2_aclk), 
    .resetn(axis_s2c2_aresetn),

    .tdata(axis_s2c2_tdata),
//    .tkeep(axis_s2c2_tkeep),
    .tvalid(axis_s2c2_tvalid),
    .tlast(axis_s2c2_tlast),

    .m_axis_mm2s_tlast(axis_s2c2_tlast_2vfifo),
    .m_axis_mm2s_tdata(axis_s2c2_tdata_2vfifo), 
    .m_axis_mm2s_tkeep(axis_s2c2_tkeep_2vfifo),
    .m_axis_mm2s_tvalid(axis_s2c2_tvalid_2vfifo), 
    .m_axis_mm2s_tready(axis_s2c2_tready_2vfifo),
    .tready(axis_s2c2_tready)
);
compression s2c3_compression_inst(
    //.channel_no(2'd3),
    .clk(axis_s2c3_aclk), 
    .resetn(axis_s2c3_aresetn),

    .tdata(axis_s2c3_tdata),
//    .tkeep(axis_s2c3_tkeep),
    .tvalid(axis_s2c3_tvalid),
    .tlast(axis_s2c3_tlast),

    .m_axis_mm2s_tlast(axis_s2c3_tlast_2vfifo),
    .m_axis_mm2s_tdata(axis_s2c3_tdata_2vfifo), 
    .m_axis_mm2s_tkeep(axis_s2c3_tkeep_2vfifo),
    .m_axis_mm2s_tvalid(axis_s2c3_tvalid_2vfifo), 
    .m_axis_mm2s_tready(axis_s2c3_tready_2vfifo),
    .tready(axis_s2c3_tready)
);
*/
endmodule
