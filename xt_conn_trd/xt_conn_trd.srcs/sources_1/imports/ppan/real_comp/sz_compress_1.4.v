`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2017 01:41:50 PM
// Design Name: 
// Module Name: sz_compress_1
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
module sz_compress_1_4 (
	input clk,    // Clock
	input wire [255:0] datain,//data array
	input wire [7:0] dataL, //data length
	input wire enable, //compress enable
	input wire [63:0] ERROR,//error bound set by user
	input wire VDD,
    output wire [7:0] vout,//[dataL-1],//2-bit compressed data
    output wire [63:0]dout,
    output wire STATE,//indicate predictable or not
    output wire START
);

wire [63:0] half={12'b101111111110,52'b0};
wire [63:0] data0,data1,data2,data3;
//reg [63:0] data;

//wire [63:0] PREDD;//predicted data with certain model

wire ADDVALID;
wire ADD0VALID;
wire ADD1VALID;
wire ADD2VALID;
wire ADD3VALID;
wire ADD4VALID;
wire ADD5VALID;
wire DIV0VALID;
wire FP2FVALID;
wire F2FPVALID;
wire MULTVALID;

wire [63:0] ERR;
wire [63:0] PREDD;
wire [63:0] MID1,MID2,MID3,MID4;//middle result while computing QCF
wire [63:0] DIFF;
wire [63:0] QUO;//quotient of division
wire [15:0] INTNUM; //the number of the required interval
wire [63:0] QUOM; //QUO minus 0.5(in order to reliaze floor operation)
wire tuser;//indicate whether the diff is out of bound



//reg [63:0] predd;//register to store PREDD
//reg [63:0] diff;//register to store QCF_DIFF
//reg [63:0] error;//register to store ERROR

reg start;//indicate the data is ready to be transmitted
reg state;//indicate the data is predictable or not
reg [63:0] dataout;//register to store 64-bit unpredictable data
reg [15:0] intnum;//register to store INTNUM
reg [7:0] encode;//8-bit code to indicate a certain interval
reg [8:0] abs;//absolute value of intnum
reg [63:0] decompdata0,decompdata1,decompdata2;
//reg [] predbuf;//local buffer to store predicted data in order to wait for intnum to be computed and then do caculation with the predicted data

//wire ta,tb,tc,td,te,tf;

//wire A1R,A2R,B1R,B2R;

assign {data3, data2, data1, data0} = datain;
assign vout=encode;
assign dout=dataout;
assign STATE=state;
assign START=start;

//wire FP2FVALID1;
//wire [15:0]S;
//wire [63:0] a={12'b010000000001,3'b001,49'b0};
    
   //predict data 
     

    
 //GET 2*ERROR
   
   fp_adder add (.aclk(clk),.s_axis_a_tvalid(VDD),/*.s_axis_a_tready(ta),*/.s_axis_a_tdata(ERROR),
        .s_axis_b_tvalid(VDD),/*.s_axis_b_tready(tb),*/.s_axis_b_tdata(ERROR),.m_axis_result_tvalid(ADDVALID),.m_axis_result_tdata(ERR));
//
 
  //GET PREDICTED DATA  
   fp_adder add0 (.aclk(clk),.s_axis_a_tvalid(enable),/*.s_axis_a_tready(ta),*/.s_axis_a_tdata(/*decomp*/data0),
       .s_axis_b_tvalid(enable),/*.s_axis_b_tready(tb),*/.s_axis_b_tdata(/*decomp*/data1),.m_axis_result_tvalid(ADD0VALID),.m_axis_result_tdata(MID1));
    
     fp_adder add1 (.aclk(clk),.s_axis_a_tvalid(enable),/*.s_axis_a_tready(tc),*/.s_axis_a_tdata({1'b1,/*decomp*/data2[62:0]}),
      .s_axis_b_tvalid(VDD),/*.s_axis_b_tready(td),*/.s_axis_b_tdata({64'b0}),.m_axis_result_tvalid(ADD1VALID),.m_axis_result_tdata(MID2));
      
   fp_adder add2 (.aclk(clk),.s_axis_a_tvalid(ADD0VALID),/*.s_axis_a_tready(tc),*/.s_axis_a_tdata(MID1),
    .s_axis_b_tvalid(ADD1VALID),/*.s_axis_b_tready(td),*/.s_axis_b_tdata(MID2),.m_axis_result_tvalid(ADD2VALID),.m_axis_result_tdata(PREDD));
    
//

//GET DIFFERENCE BETWEEN PREDICTED DATA AND ORIGINAL DATA
     
    
    fp_adder add3 (.aclk(clk),.s_axis_a_tvalid(enable),/*.s_axis_a_tready(te),*/.s_axis_a_tdata(/*decomp*/data2),
        .s_axis_b_tvalid(enable),/*.s_axis_b_tready(tf),*/.s_axis_b_tdata(data3),.m_axis_result_tvalid(ADD3VALID),.m_axis_result_tdata(MID3));
        
    fp_adder add4 (.aclk(clk),.s_axis_a_tvalid(ADD0VALID),/*.s_axis_a_tready(te),*/.s_axis_a_tdata(MID1),
                .s_axis_b_tvalid(ADD3VALID),/*.s_axis_b_tready(tf),*/.s_axis_b_tdata({1'b1,MID3[62:0]}),.m_axis_result_tvalid(ADD4VALID),.m_axis_result_tdata(DIFF));
                
//        
  
//ENCODE      
     fp_div div0 (.aclk(clk),.s_axis_a_tvalid(ADD4VALID),.s_axis_a_tdata(DIFF),
       .s_axis_b_tvalid(VDD),.s_axis_b_tdata(ERROR),.m_axis_result_tvalid(DIV0VALID), .m_axis_result_tdata(QUO));
           
    fp_adder add5 (.aclk(clk),.s_axis_a_tvalid(DIV0VALID),/*.s_axis_a_tready(tg),*/.s_axis_a_tdata(QUO),
       .s_axis_b_tvalid(VDD),/*.s_axis_b_tready(th),*/.s_axis_b_tdata(half),.m_axis_result_tvalid(ADD5VALID),.m_axis_result_tdata(QUOM));
           
     fp2fixed fp0 (.aclk(clk),/*.aclken(enable),*/.s_axis_a_tvalid(ADD5VALID),.s_axis_a_tdata(QUOM), 
       .m_axis_result_tvalid(FP2FVALID),.m_axis_result_tdata(INTNUM),.m_axis_result_tuser(tuser));

//


//GET DECOMPRESSED DATA

  //  fixed2fp fixed0 (.aclk(aclk),.s_axis_a_tvalid(FP2FVALID),.s_axis_a_tdata(INTNUM),              // input wire [7 : 0] s_axis_a_tdata
  //   .m_axis_result_tvalid(F2FPVALID),.m_axis_result_tdata(MID4));
     
   //  fp_multadd multadd0 (.aclk(clk),.s_axis_a_tvalid(F2FPVALID),.s_axis_a_tdata(MID4),
   //  .s_axis_b_tvalid(VDD),.s_axis_b_tdata(ERR),.s_axis_c_tvalid(VDD),.s_axis_c_tdata(predbuf[63:0]),              // input wire [63 : 0] s_axis_c_tdata
   //    .m_axis_result_tvalid(MULTVALID),.m_axis_result_tdata(decompdata3));
     
    
     









always@ ( posedge clk )

begin

/*if(start==1)
    begin
        { decompdata3, decompdata2 , decompdata1, decompdata0 } = datain;
        start = 0;
    end


if(ADD2VALID==1)
    begin
    
        predd=PREDD;
        count = count + 63;
            
            if(count<=)
            
                predbuf[count:count-63]=predd;
                
            else begin
            
                predd >> 64;
                predbuf[:]=predd;
                
                 end
    end       */ 
    
//if(MULTVALID==1)
  //  begin
    
    //    decompdata0=decompdata1;
//        decompdata1=decompdata2;
if(FP2FVALID == 0)
    start = 0;


else if(FP2FVALID == 1)
    begin
        //decompdata3=
        intnum = INTNUM;
        if(INTNUM[8]==1)
            begin
                if (tuser == 0)
                    begin
                        abs = - intnum;
                        abs = (abs+1)/2;
                        encode = {1'b1,abs[6:0]};
                        state = 0;
                    end
                else if (tuser == 1)
                    begin
                        encode = 8'b00000000;
                        dataout = data3;
                        state = 1;
                    end
            end
        else if(INTNUM[8]==0)
            begin
                if ((tuser == 0)&&(intnum != 255))
                    begin
                        abs = (intnum+1)/2;
                        if (abs == 0)
                            begin
                                encode = 8'b10000000;
                                state = 0;
                            end
                        else begin
                                encode = {1'b0,abs[6:0]};
                                state = 0;
                             end
                     end
                 else 
                     begin
                         encode=8'b00000000;
                         dataout = data3;
                         state = 1;
                     end
             end
         start = 1;
     end
     
end
   
endmodule