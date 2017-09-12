`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2017 02:10:20 PM
// Design Name: 
// Module Name: decompression
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


module decompression #(
parameter           AXIS_TDATA_WIDTH        = 256, 
parameter           AXIS_TKEEP_WIDTH        = (AXIS_TDATA_WIDTH / 8), 
parameter           MAX_NUM_BYTES           = 512, 
parameter           Tcq                     = 1
)
(
input   [1:0]                            channel_no,
// input signals, to be converted to data
input                                    axis_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_tkeep,
input                                    axis_tvalid,
output                                   axis_tready, 
input                                    axis_aresetn, 
input                                    axis_aclk,
// output signals to C2S
output                                   axis_tlast_c2s, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_tdata_c2s, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_tkeep_c2s, 
output                                   axis_tvalid_c2s,
input                                    axis_tready_c2s
);

reg   [31:0]           file_ptr;
reg   [1023:0]         buffer;
integer cur;
integer valid_bytes;
integer i;

assign axis_tlast_c2s = axis_tlast;
assign axis_tdata_c2s = axis_tdata;
assign axis_tkeep_c2s = axis_tkeep;
assign axis_tvalid_c2s = axis_tvalid;
assign axis_tready = axis_tready_c2s;
/*

always@ (posedge axis_aclk or negedge axis_aresetn) begin
    if (axis_aresetn == 1'b0) begin
        cur <= 0;
        valid_bytes <= 0;
        buffer <= 1024'b0;
    end
    else begin
        if (axis_tready == 1'b1 && axis_tvalid == 1'b1) begin
            if (axis_tlast == 1'b1) begin
                valid_bytes = 0;
                for (i = 0; i < 32; i = i + 1) begin
                    if (axis_tkeep[i] == 1)
                        valid_bytes = valid_bytes + 1;
                end
                for (i = 0; i < valid_bytes; i = i + 1) begin
                    buffer[cur +: 8] = axis_tdata[(8*i) +: 8];
                    cur = cur + 8;
                end
                $display("before fdisplay");
                $fdisplay(file_ptr, "[Decompression%d] %d bytes received, buffer = %h", channel_no, cur, buffer);
                cur = 0;
                buffer = 1024'b0;
            end
            else begin
                buffer[cur +: 256] = axis_tdata;
                cur = cur + 256;
            end
        end
    end
end

initial begin   
    cur = 0;
    buffer = 1024'b0;
    if (channel_no == 2'b00)
        file_ptr = $fopen("compressed0.dat");
    else if (channel_no == 2'b01)
        file_ptr = $fopen("compressed1.dat");
    else if (channel_no == 2'b10)
        file_ptr = $fopen("compressed2.dat");
    else
        file_ptr = $fopen("compressed3.dat");

    if (!file_ptr) begin
        $write("ERROR: Could not open compressed.dat.\n");
        $finish;
    end
    $display("compressed.dat opened!");
end
*/
/*
`define STATE_RESET                      5'b00001
`define STATE_IDLE                       5'b00010
`define STATE_ACTIVE                     5'b00100
`define STATE_PROCESS                    5'b01000
`define STATE_SEND                       5'b10000

reg     [4:0]                            state;
reg     [(8*MAX_NUM_BYTES)-1:0]          data;
reg     [9:0]                            data_idx;
//reg     [(8*MAX_NUM_BYTES)-1:0]          result;
//reg     [9:0]                            result_idx;
reg                                      send;
reg                                      start_proc;
wire                                     valid_send;
wire                                     finish_send;
wire                                     finish_proc;
wire    [(8*MAX_NUM_BYTES)-1:0]          data_wire;
wire    [(8*MAX_NUM_BYTES)-1:0]          result_wire;
wire    [9:0]                            result_idx_wire;

dummy_decomp decomp_inst(
    .start(start_proc),
    .finish(finish_proc),
    .user_clk(axis_aclk),
    .user_resetn(axis_aresetn),
    .data(data), 
    .data_idx(data_idx), 
    .result(result_wire), 
    .result_idx(result_idx_wire)
);

array2axis array2axis(
    .data(result_wire), 
    .data_idx(result_idx_wire),
    .tlast(finish_send),
    .tdata(axis_tdata_c2s), 
    .tkeep(axis_tkeep_c2s), 
    .tvalid(valid_send), 
    .tready(axis_tready_c2s),
    .aclk(axis_aclk), 
    .aresetn(axis_aresetn),
    .send(send)
);

assign axis_tlast_c2s = finish_send;
assign axis_tvalid_c2s = valid_send;

always @(posedge axis_aclk or negedge axis_aresetn) begin
    if (axis_aresetn == 1'b0)
        state <= #(Tcq) `STATE_RESET;
    else begin
        case (state)
            `STATE_RESET : begin
                if (axis_aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else
                    state <= #(Tcq) `STATE_IDLE;
                data_idx = 0;
                axis_tready <= 1'b1;
            end
            `STATE_IDLE : begin
                if (axis_aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    axis_tready <= 1'b1;
                    data_idx = 0;
                    if ((axis_tvalid == 1'b1) && (axis_tready == 1'b1)) begin : gen_data_idle
                        integer i_;
                        for (i_ = 0; i_ < AXIS_TKEEP_WIDTH; i_ = i_ + 1)
                            if (axis_tkeep[i_] == 1'b1) begin
                                data[8*data_idx +: 8] = axis_tdata[8*i_ +: 8];
                                data_idx = data_idx + 1;
                            end
                        if (axis_tlast == 1'b1) begin
                            // origianl data received
                            state <= #(Tcq) `STATE_PROCESS;
                            axis_tready <= 1'b0;
                        end
                        else begin
                            // not last
                            state <= #(Tcq) `STATE_ACTIVE;
                        end
                    end
                    else begin
                        // not valid or not ready
                        state <= #(Tcq) `STATE_IDLE;
                        data_idx = 0;
                    end
                end // ! reset
            end
            `STATE_ACTIVE : begin
                if (axis_aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    if ((axis_tvalid == 1'b1) && (axis_tready == 1'b1)) begin : gen_data_active
                        integer i_;
                        for (i_ = 0; i_ < AXIS_TKEEP_WIDTH; i_ = i_ + 1)
                            if (axis_tkeep[i_] == 1'b1) begin
                                data[8*data_idx +: 8] = axis_tdata[8*i_ +: 8];
                                data_idx = data_idx + 1;
                            end
                        if (axis_tlast == 1'b1) begin
                            // origianl data received
                            state <= #(Tcq) `STATE_PROCESS;
                            axis_tready <= 1'b0;
                        end
                        else begin
                            // not last
                            state <= #(Tcq) `STATE_ACTIVE;
                        end
                    end
                    else begin
                        // not valid or not ready
                        // keep current state
                        state <= #(Tcq) `STATE_ACTIVE;
                    end
                end // ! reset
            end
            `STATE_PROCESS : begin
                if (axis_aresetn == 1'b0)   
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    start_proc <= finish_proc ? 1'b0 : 1'b1;
                    send <= finish_proc ? 1'b1 : 1'b0;
                    if (finish_proc == 1'b1) begin : display_data
                        integer i_;
                        state <= #(Tcq) `STATE_SEND;
                    end
                    else
                        state <= #(Tcq) `STATE_PROCESS;
                end
            end
            `STATE_SEND : begin
                if (axis_aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    if (finish_send == 1'b1 && axis_tready_c2s == 1'b1 && valid_send == 1'b1) begin
                        state <= #(Tcq) `STATE_IDLE;
                        send <= 1'b0;
                    end
                    else
                        state <= #(Tcq) `STATE_SEND;
                end
            end
        endcase
    end
end

initial begin
    data = {(8*MAX_NUM_BYTES){1'b0}};
    data_idx = 0;
    state = `STATE_RESET;
    axis_tready = 1'b1;
    send = 1'b0;
    start_proc = 1'b0;
end
*/

endmodule
