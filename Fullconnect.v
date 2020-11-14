`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:53:29
// Design Name: 
// Module Name: Fullconnect
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


module Fullconnect(
input clk,rst,en,

input [15:0] D_in,
input [15:0] Weight,
input [15:0] Bias,
input [13:0] Size,


output [31:0] Fc_out,

output fc_ack
    );
    
    reg [13:0] size_cnt = 0;
    reg [31:0] Fc_out_reg = 0;
    reg ack = 0;
    
    assign Fc_out = Fc_out_reg;
    assign fc_ack = ack;
    
    always @(posedge clk or posedge rst)
    begin
       if (rst) begin 
         size_cnt <= 0;
         ack <= 0;
       end
       else if (size_cnt == Size - 2 && en)
       begin
         size_cnt <= size_cnt + 1; 
         ack <= 1;
       end 
       else if (size_cnt == Size - 1 && en) 
       begin 
         size_cnt <= 0;
         ack <= 0;
       end 
       else if (en) 
       begin 
         size_cnt <= size_cnt + 1;
         ack <= 0;      
       end
       else 
       begin 
         size_cnt <= 0;
         ack <= 0;
       end
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst) Fc_out_reg <= 0;
       else if (en && (size_cnt == Size - 1))
       begin
         Fc_out_reg <= 0;
       end
       else if (en && (size_cnt == Size - 2))
       begin 
         Fc_out_reg <= Fc_out_reg + D_in * Weight + Bias;
       end 
       else if (en)
       begin 
         Fc_out_reg <= Fc_out_reg +  D_in * Weight;
       end 
       else 
       begin
         Fc_out_reg <= 0;
       end 
    end 
      
    
endmodule
