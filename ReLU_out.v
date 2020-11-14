`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:52:48
// Design Name: 
// Module Name: ReLU
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


module ReLU_out(
input clk,rst,ack,
input [31:0]Conv_in_R,
input [31:0]Conv_in_G,
input [31:0]Conv_in_B,

output [15:0]ReLU_o_R,
output [15:0]ReLU_o_G,
output [15:0]ReLU_o_B,
output relu_ack
    );
    
    reg [31:0]ReLU_reg_R = 0;
    reg [31:0]ReLU_reg_G = 0;
    reg [31:0]ReLU_reg_B = 0;
    reg reg_ack = 0;
    
    assign relu_ack = reg_ack;
    assign ReLU_o_R = ReLU_reg_R;
    assign ReLU_o_G = ReLU_reg_G;
    assign ReLU_o_B = ReLU_reg_B;
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        ReLU_reg_R <= 0;
        reg_ack <= 0;
      end
      else if (ack) 
      begin
        if (Conv_in_R[31]) ReLU_reg_R <= 0;
        else  ReLU_reg_R <= (Conv_in_R );
        reg_ack <= 1;
      end
      else 
      begin
         ReLU_reg_R <= ReLU_reg_R;
         reg_ack <= 0;
      end 
    end
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) ReLU_reg_G <= 0;
      else if (ack) 
      begin
        if (Conv_in_R[31]) ReLU_reg_G <= 0;
        else  ReLU_reg_G <= (Conv_in_G );
      end
      else 
      begin
         ReLU_reg_G <= ReLU_reg_G;
      end 
    end
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) ReLU_reg_B <= 0;
      else if (ack) 
      begin
        if (Conv_in_R[31]) ReLU_reg_B <= 0;
        else  ReLU_reg_B <= (Conv_in_B );
      end
      else 
      begin
         ReLU_reg_B <= ReLU_reg_B;
      end 
    end
    
    
endmodule
