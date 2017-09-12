`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2017 05:49:22 PM
// Design Name: 
// Module Name: 2D_array_pack_unpack
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

`define PACK_ARRAY(WIDTH, LEN, SRC, DST)    genvar idx; generate for (idx=0; idx<(LEN); idx=idx+1) begin; assign DST[(((WIDTH)*idx)+((WIDTH)-1)):((WIDTH)*idx)] = SRC[idx][((WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(WIDTH, LEN, DST, SRC)  genvar idx; generate for (idx=0; idx<(LEN); idx=idx+1) begin; assign DST[idx][((WIDTH)-1):0] = SRC[(((WIDTH)*idx)+((WIDTH)-1)):((WIDTH)*idx)]; end; endgenerate
