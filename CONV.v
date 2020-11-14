`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:16:10
// Design Name: 
// Module Name: CONV
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


module CONV(
input clk,rst,
input en,
input [9:0]Size,
input [15:0]D_in_R,
input [15:0]Weight_R,
input [15:0]Bias,

input [15:0]D_in_G,
input [15:0]Weight_G,

input [15:0]D_in_B,
input [15:0]Weight_B,

output [31:0]Conv_out_R,
output [31:0]Conv_out_G,
output [31:0]Conv_out_B,

output conv_ack
    );
    
    
    reg [31:0] conv_tmp_R = 0;
    reg [31:0] conv_tmp_G = 0;
    reg [31:0] conv_tmp_B = 0;
   
    reg [9:0 ] size_cnt = 0;   
    
    ////////////控制信号////////////
    reg ack0 = 0;
    reg ack1 = 0;
    
    /////////////输出信号//////////////////////
    assign Conv_out_R = conv_tmp_R;
    assign Conv_out_G = conv_tmp_G;
    assign Conv_out_B = conv_tmp_B;

    assign conv_ack = ack0;
    
    
    //////////////////Weight * Din//////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) 
      begin 
        conv_tmp_R <= 0;
      end
      else if ((size_cnt == Size - 1) && (en))
      begin
          conv_tmp_R <= 0;
      end   
      else if (en && (size_cnt == Size - 2)) 
      begin
         conv_tmp_R <= conv_tmp_R + Weight_R * D_in_R + Bias;
      end 
      else if (en)
      begin
         conv_tmp_R <= conv_tmp_R + Weight_R * D_in_R;
      end 
      else 
      begin 
        conv_tmp_R <= conv_tmp_R;
      end
    end 
    
   
    
 /////////////////////////////////////////////////////////   
     always @(posedge clk or posedge rst)
    begin
      if (rst) 
      begin 
        conv_tmp_G <= 0;
      end
      else if ((size_cnt == Size - 1) && (en))
      begin
          conv_tmp_G <= 0;
      end   
      else if (en && (size_cnt == Size - 2))
      begin 
          conv_tmp_G <= conv_tmp_G + Weight_G * D_in_G + Bias;
      end 
      else if (en) 
      begin
         conv_tmp_G <= conv_tmp_G + Weight_G * D_in_G;
      end 
      else 
      begin 
        conv_tmp_G <= conv_tmp_G;
      end
    end 
    
    
   
    
  /////////////////////////////////////////////////////  
    always @(posedge clk or posedge rst)
    begin
      if (rst) 
      begin 
        conv_tmp_B <= 0;
      end
      else if ((size_cnt == Size - 1) && (en))
      begin
          conv_tmp_B <= 0;
      end   
      else if (en && (size_cnt == Size - 2))
      begin
         conv_tmp_B <= conv_tmp_B + Weight_B * D_in_B + Bias;
      end 
      else if (en) 
      begin
         conv_tmp_B <= conv_tmp_B + Weight_G * D_in_G;
      end 
      else 
      begin 
        conv_tmp_B <= conv_tmp_B;
      end
    end 
   
    
    
    ///////////////////计数器///////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) 
      begin 
        size_cnt <= 0;
        ack0 <= 0;
      end
      else if (en && size_cnt == Size - 2)
      begin
         size_cnt <= size_cnt + 1;
         ack0 <= 1;
      end  
      else if (en && size_cnt == Size - 1)
      begin
         size_cnt <= 0;
         ack0 <= 0;
      end  
      else if (en) 
      begin 
         size_cnt <= size_cnt + 1;
         ack0 <= 0;
      end 
      else 
      begin
        size_cnt <= size_cnt; 
        ack0 <= 0;
      end 
    end 
    
    
    
    
    
    
endmodule
