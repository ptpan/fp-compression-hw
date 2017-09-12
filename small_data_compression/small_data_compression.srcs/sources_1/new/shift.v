`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2017 12:41:59 PM
// Design Name: 
// Module Name: shift
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


module shift(
    input                                              clk,
    input                                              resetn,
    
//signals for axi4-stream
    input                  [ 255 : 0 ]                 tdata,
  //  input                  [ 31 : 0 ]                  tkeep,
    output                                             tready,
    input                                              tvalid,
    input                                              tlast,
    
//output signals    
    output                 [ 255 : 0 ]                 dout,
//    output                 [ 255 : 0 ]                 header,
    output                                             is_header,
   // output                 [ 31 : 0 ]                  keep,
    input                                              ready,
    output                                             valid,
    output                                             last
                                 
    );
    
    assign valid = valid0;
    assign tready = ready;
    //assign valid = tvalid;
    assign last = last0;
 //   assign keep = tkeep;
    reg                                                valid0;
    reg                                                last0;
    wire                   [ 255 : 0 ]                 shift_reg;
    
  //  reg                    [ 2 : 0 ]                   count_header;
    reg                    [ 255 : 0 ]                 dataout;
    reg                                                isheader;
    reg                    [ 175 : 0 ]                  tail; 
    reg                    [ 4 : 0 ]                   count = 0;
    
    wire                                               finish;
    reg                                                finish0;
    
    assign is_header = isheader;
    assign shift_reg = { tdata[ 79 : 0 ] , tail }; 
    assign dout = ( tvalid == 1 && count == 1 ) ? { dataout[ 255 : 112 ] , 16'h0008 , dataout[ 95 : 0 ] }: dataout;
    assign finish = tlast;
    
always@ ( posedge clk or negedge resetn )
    begin     
        if ( !resetn )
            begin
            
                isheader <= 0;
                count <= 0;
                dataout <= 0;
                finish0 <= 0;
                valid0 <= 0;
                last0 <= 0;
                
            end
            
        else begin
        
        //    if( tvalid == 1 ) $display( "valid=%d\n",valid );
        
            valid0 <= tvalid;
            finish0 <= finish;
            last0 <= tlast;
             
            if ( tvalid == 1 && count <= 2 )
                begin
                    isheader <= 1;
                    dataout <= tdata;
                    count <= count + 1;
                end
            
            else if ( count == 3 )
                begin
                    dataout <= tdata;
                    tail <= tdata[ 255 : 80 ];
                    count <= count + 1;
                end
                
            else if ( count == 4 )
                begin
                    dataout <= shift_reg;
                    isheader <= 0;
                    tail <= tdata[ 255 : 80 ];
                end
            
                
            if ( finish0 == 1 ) 

                begin
                    count <= 0;
                    dataout <= 0;
                end
                
        end
    end
                
                
    
    
endmodule
