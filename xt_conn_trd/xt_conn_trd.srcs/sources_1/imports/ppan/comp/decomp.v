`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2017 02:44:42 PM
// Design Name: 
// Module Name: decomp
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


module decomp #(
parameter           AXIS_TDATA_WIDTH        = 256, 
parameter           AXIS_TKEEP_WIDTH        = (AXIS_TDATA_WIDTH / 8), 
parameter           MAX_NUM_BYTES           = 512, 
parameter           Tcq                     = 1
)
(
// input signals, to be converted to data
input                                    axis_c2s0_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_c2s0_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_c2s0_tkeep,
input                                    axis_c2s0_tvalid,
output                                   axis_c2s0_tready, 
input                                    axis_c2s0_aresetn, 
input                                    axis_c2s0_aclk,
// output signals to C2S0
output                                   axis_c2s0_tlast_2c2s, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_c2s0_tdata_2c2s, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_c2s0_tkeep_2c2s, 
output                                   axis_c2s0_tvalid_2c2s,
input                                    axis_c2s0_tready_2c2s,  

// input signals, to be converted to data
input                                    axis_c2s1_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_c2s1_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_c2s1_tkeep,
input                                    axis_c2s1_tvalid,
output                                   axis_c2s1_tready, 
input                                    axis_c2s1_aresetn, 
input                                    axis_c2s1_aclk,
// output signals to C2S1
output                                   axis_c2s1_tlast_2c2s, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_c2s1_tdata_2c2s, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_c2s1_tkeep_2c2s, 
output                                   axis_c2s1_tvalid_2c2s,
input                                    axis_c2s1_tready_2c2s,  

// input signals, to be converted to data
input                                    axis_c2s2_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_c2s2_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_c2s2_tkeep,
input                                    axis_c2s2_tvalid,
output                                   axis_c2s2_tready, 
input                                    axis_c2s2_aresetn, 
input                                    axis_c2s2_aclk,
// output signals to C2S2
output                                   axis_c2s2_tlast_2c2s, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_c2s2_tdata_2c2s, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_c2s2_tkeep_2c2s, 
output                                   axis_c2s2_tvalid_2c2s,
input                                    axis_c2s2_tready_2c2s,  

// input signals, to be converted to data
input                                    axis_c2s3_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_c2s3_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_c2s3_tkeep,
input                                    axis_c2s3_tvalid,
output                                   axis_c2s3_tready, 
input                                    axis_c2s3_aresetn, 
input                                    axis_c2s3_aclk,
// output signals to C2S3
output                                   axis_c2s3_tlast_2c2s, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_c2s3_tdata_2c2s, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_c2s3_tkeep_2c2s, 
output                                   axis_c2s3_tvalid_2c2s,
input                                    axis_c2s3_tready_2c2s,  

input                                    user_clk, 
input                                    user_reset
);

decompression c2s0_decompression_inst(
    .channel_no(2'd0),
    .axis_tlast(axis_c2s0_tlast),
    .axis_tdata(axis_c2s0_tdata),
    .axis_tkeep(axis_c2s0_tkeep),
    .axis_tvalid(axis_c2s0_tvalid),
    .axis_tready(axis_c2s0_tready),
    .axis_aresetn(axis_c2s0_aresetn),
    .axis_aclk(axis_c2s0_aclk), 
    .axis_tlast_c2s(axis_c2s0_tlast_2c2s),
    .axis_tdata_c2s(axis_c2s0_tdata_2c2s), 
    .axis_tkeep_c2s(axis_c2s0_tkeep_2c2s),
    .axis_tvalid_c2s(axis_c2s0_tvalid_2c2s), 
    .axis_tready_c2s(axis_c2s0_tready_2c2s) 
);
decompression c2s1_decompression_inst(
    .channel_no(2'd1),
    .axis_tlast(axis_c2s1_tlast),
    .axis_tdata(axis_c2s1_tdata),
    .axis_tkeep(axis_c2s1_tkeep),
    .axis_tvalid(axis_c2s1_tvalid),
    .axis_tready(axis_c2s1_tready),
    .axis_aresetn(axis_c2s1_aresetn),
    .axis_aclk(axis_c2s1_aclk), 
    .axis_tlast_c2s(axis_c2s1_tlast_2c2s),
    .axis_tdata_c2s(axis_c2s1_tdata_2c2s), 
    .axis_tkeep_c2s(axis_c2s1_tkeep_2c2s),
    .axis_tvalid_c2s(axis_c2s1_tvalid_2c2s), 
    .axis_tready_c2s(axis_c2s1_tready_2c2s) 
);
decompression c2s2_decompression_inst(
    .channel_no(2'd2),
    .axis_tlast(axis_c2s2_tlast),
    .axis_tdata(axis_c2s2_tdata),
    .axis_tkeep(axis_c2s2_tkeep),
    .axis_tvalid(axis_c2s2_tvalid),
    .axis_tready(axis_c2s2_tready),
    .axis_aresetn(axis_c2s2_aresetn),
    .axis_aclk(axis_c2s2_aclk), 
    .axis_tlast_c2s(axis_c2s2_tlast_2c2s),
    .axis_tdata_c2s(axis_c2s2_tdata_2c2s), 
    .axis_tkeep_c2s(axis_c2s2_tkeep_2c2s),
    .axis_tvalid_c2s(axis_c2s2_tvalid_2c2s), 
    .axis_tready_c2s(axis_c2s2_tready_2c2s) 
);
decompression c2s3_decompression_inst(
    .channel_no(2'd3),
    .axis_tlast(axis_c2s3_tlast),
    .axis_tdata(axis_c2s3_tdata),
    .axis_tkeep(axis_c2s3_tkeep),
    .axis_tvalid(axis_c2s3_tvalid),
    .axis_tready(axis_c2s3_tready),
    .axis_aresetn(axis_c2s3_aresetn),
    .axis_aclk(axis_c2s3_aclk), 
    .axis_tlast_c2s(axis_c2s3_tlast_2c2s),
    .axis_tdata_c2s(axis_c2s3_tdata_2c2s), 
    .axis_tkeep_c2s(axis_c2s3_tkeep_2c2s),
    .axis_tvalid_c2s(axis_c2s3_tvalid_2c2s), 
    .axis_tready_c2s(axis_c2s3_tready_2c2s) 
);

endmodule
