`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2017 02:10:20 PM
// Design Name: 
// Module Name: compression
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


module compression #(
parameter           AXIS_TDATA_WIDTH        = 256, 
parameter           AXIS_TKEEP_WIDTH        = (AXIS_TDATA_WIDTH / 8), 
parameter           MAX_NUM_BYTES           = 512, 
parameter           Tcq                     = 1
)
(
input   [1:0]                            channel_no,
// input signals to data
input                                    axis_tlast, 
input   [AXIS_TDATA_WIDTH-1:0]           axis_tdata,
input   [AXIS_TKEEP_WIDTH-1:0]           axis_tkeep,
input                                    axis_tvalid,
output  reg                              axis_tready, 
input                                    axis_aresetn, 
input                                    axis_aclk,
// output signals to output
output                                   axis_tlast_tmac, 
output  [AXIS_TDATA_WIDTH-1:0]           axis_tdata_tmac, 
output  [AXIS_TKEEP_WIDTH-1:0]           axis_tkeep_tmac, 
output                                   axis_tvalid_tmac,
input                                    axis_tready_tmac,

input                                    user_clk, 
input                                    user_resetn
);

`define STATE_RESET                      5'b00001
`define STATE_IDLE                       5'b00010
`define STATE_ACTIVE                     5'b00100
`define STATE_PROCESS                    5'b01000
`define STATE_SEND                       5'b10000

reg     [4:0]                            state;
reg     [(8*MAX_NUM_BYTES)-1:0]          data;
reg     [15:0]                           data_idx;
//reg     [(8*MAX_NUM_BYTES)-1:0]          result;
//reg     [9:0]                            result_idx;
reg                                      send;
reg                                      start_proc;
wire                                     valid_send;
wire                                     finish_send;
wire                                     finish_proc;
wire    [(8*MAX_NUM_BYTES)-1:0]          data_wire;
wire    [(8*MAX_NUM_BYTES)-1:0]          result_wire;
wire    [15:0]                           result_idx_wire;

wire            [63:0]                           error;

assign error            = 64'h3f8000000000000;


/*dummy_comp comp_inst(
    .start(start_proc),
    .finish(finish_proc),
    .user_clk(axis_aclk),
    .user_resetn(axis_aresetn),
    .data(data), 
    .data_idx(data_idx), 
    .result(result_wire), 
    .result_idx(result_idx_wire)
);
*/
sz_1_4 #(
    .NUM_BYTES(512)
) comp_inst
(
    .START(start_proc),
    .FINISH(finish_proc),
    .clk(axis_aclk),
    .datain(data), 
    .dataL(data_idx),
    .VDD(1'b1),
    .datao(result_wire), 
    .index(result_idx_wire), 
    .error(error)
);


array2axis #(
    .BYTES_PER_BURST(8)
) array2axis_tmac
(
    .data(result_wire), 
    .data_idx(result_idx_wire),
    .tlast(finish_send),
    .tdata(axis_tdata_tmac), 
    .tkeep(axis_tkeep_tmac), 
    .tvalid(valid_send), 
    .tready(axis_tready_tmac),
    .aclk(axis_aclk), 
    .aresetn(axis_aresetn),
    .send(send)
);

assign axis_tlast_tmac = finish_send;
assign axis_tvalid_tmac = valid_send;

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
                    if (axis_tvalid == 1'b1 && axis_tready == 1'b1) begin : gen_data_active
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
/*                        $display("tmac%d original data", channel_no);
                        for (i_ = 0; i_ < data_idx; i_ = i_ + 1) 
                            $display("%h", data[8*i_ +: 8]);
                        $display("tmac%d after comp", channel_no);
                        for (i_ = 0; i_ < data_idx; i_ = i_ + 1)
                            $display("%h", result_wire[8*i_ +: 8]);
*/                    end
                    else
                        state <= #(Tcq) `STATE_PROCESS;
                end
            end
            `STATE_SEND : begin
                if (axis_aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    if (finish_send == 1'b1 && axis_tready_tmac == 1'b1 && valid_send == 1'b1) begin
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

endmodule
