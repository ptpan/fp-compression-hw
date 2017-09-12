`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2017 03:17:24 PM
// Design Name: 
// Module Name: mm2s_dma_cmd
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


module mm2s_dma_cmd(
    input                  clk, 
    input                  aresetn,
    
    input                  valid, 
    input   [31:0]         addr, 
    input   [22:0]         bytes, 
    
    output  reg            m_axi_lite_wvalid, 
    output  reg [31:0]     m_axi_lite_wdata,
    input                  m_axi_lite_wready,
    output  reg            m_axi_lite_awvalid, 
    output  reg [9:0]      m_axi_lite_awaddr,
    input                  m_axi_lite_awready
    );
    
reg     [3:0]       state;    
reg     [31:0]      addr_i;
reg     [22:0]      bytes_i;

`define STATE_RECV          4'b0001
`define STATE_SEND_CONTROL  4'b0010
`define STATE_SEND_ADDR     4'b0100
`define STATE_SEND_BYTES    4'b1000


always @(posedge clk or negedge aresetn) begin
    if (aresetn == 1'b0) begin
        state <= `STATE_RECV;
        addr_i <= 32'b0;
        bytes_i <= 23'b0;
        m_axi_lite_wvalid <= 1'b0;
        m_axi_lite_wdata <= 32'b0;
        m_axi_lite_awvalid <= 1'b0;
        m_axi_lite_awaddr <= 10'b0;
    end
    else begin
        case (state)
            `STATE_RECV : begin
                if (valid == 1'b1) begin
                    state <= `STATE_SEND_CONTROL;
                    addr_i <= addr;
                    bytes_i <= bytes;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= 32'h0000_7001;
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'b0;
                end
                else begin
                    state <= `STATE_RECV;
                    addr_i <= 32'b0;
                    bytes_i <= 23'b0;
                    m_axi_lite_wvalid <= 1'b0;
                    m_axi_lite_wdata <= 32'b0;
                    m_axi_lite_awvalid <= 1'b0;
                    m_axi_lite_awaddr <= 10'b0;
                end
            end
            `STATE_SEND_CONTROL : begin
                if (m_axi_lite_awready == 1'b1 && m_axi_lite_wready == 1'b1) begin
                    state <= `STATE_SEND_ADDR;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= addr_i;
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'h18;
                end
                else begin
                    state <= `STATE_SEND_CONTROL;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= 32'h0000_7001;
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'h0;
                end
            end
            `STATE_SEND_ADDR : begin
                if (m_axi_lite_awready == 1'b1 && m_axi_lite_wready == 1'b1) begin
                    state <= `STATE_SEND_BYTES;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= {9'b0, bytes_i};
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'h28;
                end
                else begin
                    state <= `STATE_SEND_ADDR;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= addr_i;
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'h18;
                end
            end
            `STATE_SEND_BYTES : begin
                if (m_axi_lite_awready == 1'b1 && m_axi_lite_wready == 1'b1) begin
                    state <= `STATE_RECV;
                    m_axi_lite_wvalid <= 1'b0;
                    m_axi_lite_wdata <= 32'b0;
                    m_axi_lite_awvalid <= 1'b0;
                    m_axi_lite_awaddr <= 10'b0;
                end
                else begin
                    state <= `STATE_SEND_BYTES;
                    m_axi_lite_wvalid <= 1'b1;
                    m_axi_lite_wdata <= {9'b0, bytes_i};
                    m_axi_lite_awvalid <= 1'b1;
                    m_axi_lite_awaddr <= 10'h28;
                end
            end
        endcase
    end
end

initial begin
    state = `STATE_RECV;
    addr_i = 32'b0;
    bytes_i = 23'b0;
    m_axi_lite_wvalid = 1'b0;
    m_axi_lite_wdata = 32'b0;
    m_axi_lite_awvalid = 1'b0;
    m_axi_lite_awaddr = 10'b0;
end
    
    
endmodule