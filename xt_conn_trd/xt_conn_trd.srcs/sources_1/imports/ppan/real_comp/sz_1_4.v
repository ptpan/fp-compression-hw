`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2017 12:20:31 PM
// Design Name: 
// Module Name: sz_1_4
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


module sz_1_4
#(
   parameter NUM_BYTES = 80,
   parameter SIZE = NUM_BYTES/8 - 3
)
(
    input clk,
    input START,
    input [( NUM_BYTES*8 ) - 1 : 0] datain,
    input [15:0] dataL,
    input VDD,
    input [63:0] error,
    output reg [( NUM_BYTES*8 ) - 1 : 0] datao,
  //  output wire [ NUM_BYTES - 1 : 0] codeout,
    output [15:0]index,
  //  output [NUM_BYTES/8-1:0] state,
    output FINISH

    );
    
   //8 fps
    wire A;
    wire B;
    wire enable = START & A;
    wire [ NUM_BYTES - 1 : 0] codeout;
    wire [( NUM_BYTES*8 ) - 1 : 0] dataout;
    wire [NUM_BYTES/8-1:0] state;
    wire start;//start putting them in the local buffer to be transmitted
    wire [SIZE - 1 : 0] startt;
    
    reg [15 : 0] index0;
    reg a = 1;
    reg b = 1;
    reg finish = 0;
    reg [15 : 0]count = 16;//512codes+10dataL
             
    integer i = 0;
    integer j = 0;
   

    assign A = a;
    assign B = b;
    assign codeout[23:0] = 24'b0;
    assign dataout[191:0] = datain[191 : 0];
    assign state[2:0] = 3'b111;
    assign FINISH = finish;
    assign index = index0;
    assign start = startt[0];
    
    wire [NUM_BYTES/8 - 1 : 0] VALID;
    
    assign VALID = { NUM_BYTES/8 { 1'b1 } } << dataL/8;
    
    genvar gv_i;
    
    generate
        for (gv_i = 1 ; gv_i <= SIZE ; gv_i = gv_i + 1)
        begin : label
            sz_compress_1_4 sz_comp(.clk(clk),    // Clock
                                    .datain(datain[(gv_i - 1)*64 + 255 : (gv_i - 1)*64]),//data array
                                    .dataL(dataL), //data length
                                    .enable(enable), //compress enable
                                    .ERROR(error),//error bound set by user
                                    .VDD(VDD),//high voltage to indicate constant valid error
                                    .vout(codeout[(gv_i - 1)*8 + 31 : (gv_i - 1)*8 + 24]),//[dataL-1],//2-bit compressed data
                                    .dout(dataout[(gv_i - 1)*64 + 255 : (gv_i - 1)*64 + 192]),
                                    .STATE(state[gv_i + 2]),
                                    .START(startt[gv_i - 1]));
        end
    endgenerate 
    

   
         
    always@ ( posedge clk )

    begin
    
        if (START == 1)
        
            a <= 0;
   //         b <= a;
            
        if (START == 0)
        
            a <= 1;
     //       b <= a;
            
    end
      

   
    
    always@(posedge clk)
    
    begin
    
    
    if(start == 0)
    
        begin
    
            finish = 0;
            count = 16;
        
        end
    
    else if(start == 1)
        begin
            datao[15:0] = dataL;      
            
            for (j = 0 ; j <= SIZE + 2 ; j = j + 1)
                begin
                    if( VALID[j] == 0 )
                        begin 
                            datao[count + 7 -: 8] = codeout[8*j + 7 -: 8];
                            count = count + 8;
                        end
                end
                 
            for (i = 0 ; i <= SIZE + 2 ; i = i + 1)
                begin
                    if(state[i] == 1 && VALID[i] == 0)
                        begin 
                            datao[count + 63 -: 64] = dataout[64*i + 63 -: 64];
                            count = count + 64;
                        end
              //      else if (state[i] == 0)
                //        begin 
                  //          datao[count + 7 -: 8] = codeout[8*i + 7 -: 8];
                    //        count = count + 8;
                      //  end
                end
            index0 = count/8;
            finish = 1;
        end
    end
endmodule

