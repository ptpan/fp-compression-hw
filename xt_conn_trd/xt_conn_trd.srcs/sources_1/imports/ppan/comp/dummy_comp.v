`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2017 01:57:42 PM
// Design Name: 
// Module Name: dummy_comp
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

module dummy_comp #(
parameter           MAX_NUM_BYTES           = 512
)
(
input                                            start,
input                                            user_clk, 
input                                            user_resetn, 
input           [(8*MAX_NUM_BYTES)-1:0]          data, 
input           [9:0]                            data_idx,
//output  reg     [(8*MAX_NUM_BYTES)-1:0]          result,
output          [(8*MAX_NUM_BYTES)-1:0]          result,
output  reg     [9:0]                            result_idx,
output  reg                                      finish
);

integer i_;
generate
    genvar _i;
    for (_i = 0; _i < MAX_NUM_BYTES; _i = _i + 1) begin
        assign result[8*_i +: 8] = ~data[8*_i +: 8];
    end
endgenerate


always @(posedge user_clk or negedge user_resetn) begin : invert
    if (user_resetn == 1'b0) begin
        finish = 1'b0;
        i_ = 0;
        result_idx = 8'h00;
//        result = {(8*MAX_NUM_BYTES){1'b0}};
    end
    else if (start == 1'b1) begin
//        for(i_ = 0; i_ < data_idx; i_ = i_ + 1)
//            result[8*i_ +: 8] = ~data[8*i_ +: 8];
        result_idx = data_idx;
        finish = 1'b1;
    end
    else begin
        finish = 1'b0;
        i_ = 0;
        //result_idx = 8'h00;
        //result = {(8*MAX_NUM_BYTES){1'b0}};
    end
end

initial begin
    finish = 1'b0;
    i_ = 0;
    result_idx = 8'h00;
//    result = {(8*MAX_NUM_BYTES){1'b0}};
end


endmodule
