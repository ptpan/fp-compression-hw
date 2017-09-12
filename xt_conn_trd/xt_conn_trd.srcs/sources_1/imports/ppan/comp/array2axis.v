`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2017 04:19:44 PM
// Design Name: 
// Module Name: array2axis
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


module array2axis #(
parameter                                   AXIS_TDATA_WIDTH            = 256,
parameter                                   AXIS_TKEEP_WIDTH            = (AXIS_TDATA_WIDTH / 8), 
parameter                                   MAX_NUM_BYTES               = 512, 
parameter                                   Tcq                         = 1, 
parameter                                   BYTES_PER_BURST             = 32,
parameter                                   MAX_BYTES_PER_BURST         = (AXIS_TDATA_WIDTH / 8) 
)
(
input           [(8*MAX_NUM_BYTES)-1:0]     data,
input           [15:0]                      data_idx, 
output  reg                                 tlast, 
output  reg     [AXIS_TDATA_WIDTH-1:0]      tdata, 
output  reg     [AXIS_TKEEP_WIDTH-1:0]      tkeep,
output  reg                                 tvalid,
input                                       tready, 
input                                       aclk, 
input                                       aresetn,
input                                       send
);

`define         STATE_RESET                 2'b01
`define         STATE_ACTIVE                2'b10

reg             [1:0]                       state;
reg                                         clear_all;
wire                                        is_working;
integer                                     cur_;

assign is_working = send;

always @(posedge aclk or negedge aresetn) begin
    if (aresetn == 1'b0) 
        state <= #(Tcq) `STATE_RESET;
    else begin
        case (state)
            `STATE_RESET : begin
                cur_ <= 0;
                tlast <= 1'b0;
                tvalid <= 1'b0;
                tkeep <= {(AXIS_TKEEP_WIDTH){1'b0}};
                tdata <= {(AXIS_TDATA_WIDTH){1'b0}};
                if (aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else 
                    state <= #(Tcq) `STATE_ACTIVE;
            end
            `STATE_ACTIVE : begin
                if (aresetn == 1'b0)
                    state <= #(Tcq) `STATE_RESET;
                else begin
                    if (clear_all == 1'b1) begin
                        if (tvalid == 1'b1 && tready == 1'b1 && is_working == 1'b1) begin
                            // last byte has been transmitted, reset signals
                            clear_all <= 1'b0;
                            tlast <= 1'b0;
                            tkeep <= {(AXIS_TKEEP_WIDTH){1'b0}};
                            tdata <= {(AXIS_TDATA_WIDTH){1'b0}};
                            tvalid <= 1'b0;
                            cur_ <= 0;
                        end
                    end  
                    else if (is_working == 1'b1 && tvalid == 1'b0) begin
                        // first byte to be sent, tready might be 1'b0
                        tvalid <= 1'b1;
                        if (cur_ + BYTES_PER_BURST >= data_idx) begin
                            // data_idx - cur_ bytes will appear on tdata
                            // tlast = 1
                            tlast <= 1'b1;
                            tkeep <= ~(({(AXIS_TKEEP_WIDTH){1'b1}}) << (data_idx - cur_));
                            tdata <= data >> (8*cur_);
//                            if (tvalid == 1'b1 && tready == 1'b1 && is_working == 1'b1)
                            clear_all <= 1'b1;
                        end
                        else begin
                            // BYTES_PER_BURST bytes will appear on tdata
                            // tlast = 0
                            tlast <= 1'b0;
                            tkeep <= ~(({(AXIS_TKEEP_WIDTH){1'b1}}) << (BYTES_PER_BURST));
                            tdata <= {{(AXIS_TDATA_WIDTH - 8*BYTES_PER_BURST){1'b0}}, data[8*cur_ +: (8*BYTES_PER_BURST)]};
                            cur_ <= cur_ + BYTES_PER_BURST;
                        end
                    end
                    else if ((is_working == 1'b1) && (tready == 1'b1)) begin
                        // transfer the data
                        tvalid <= 1'b1;
                        if (cur_ + BYTES_PER_BURST >= data_idx) begin
                            // data_idx - cur_ bytes will appear on tdata
                            // tlast = 1
                            tlast <= 1'b1;
                            tkeep <= ~(({(AXIS_TKEEP_WIDTH){1'b1}}) << (data_idx - cur_));
                            tdata <= data >> (8*cur_);
//                            if (tvalid == 1'b1 && tready == 1'b1 && is_working == 1'b1)
                            clear_all <= 1'b1;
                        end
                        else begin
                            // BYTES_PER_BURST bytes will appear on tdata
                            // tlast = 0
                            tlast <= 1'b0;
                            tkeep <= ~(({(AXIS_TKEEP_WIDTH){1'b1}}) << (BYTES_PER_BURST));
                            tdata <= {{(AXIS_TDATA_WIDTH - 8*BYTES_PER_BURST){1'b0}}, data[8*cur_ +: (8*BYTES_PER_BURST)]};
                            cur_ <= cur_ + BYTES_PER_BURST;  
                        end
                    end
                    else if (is_working == 1'b0) begin
                        // input data is not ready
                        tlast <= 1'b0;
                        cur_ <= 0;
                        tvalid <= 1'b0;
                        tkeep <= {(AXIS_TKEEP_WIDTH){1'b0}};
                        tdata <= {(AXIS_TDATA_WIDTH){1'b0}};
                        state <= #(Tcq) `STATE_ACTIVE;
                    end
                    // else tready == 1'b0, hold all signals and wait, do nothing
                end // ! reset
            end
        endcase
    end
end

initial begin
    cur_ <= 0;
    tlast <= 1'b0;
    tvalid <= 1'b0;
    tkeep <= {(AXIS_TKEEP_WIDTH){1'b0}};
    tdata <= {(AXIS_TDATA_WIDTH){1'b0}};
    clear_all = 1'b0;
end

endmodule
