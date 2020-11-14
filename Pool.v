`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:53:09
// Design Name: 
// Module Name: Pool
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


module Pool(
input clk,rst,en,
input [5:0]Size,

input [15:0]D_in_R,
input [15:0]D_in_G,
input [15:0]D_in_B,

output [15:0]Pool_out_R,
output [15:0]Pool_out_G,
output [15:0]Pool_out_B,
output pool_ack
    );
    
   reg [5:0]size_cnt = 0;
   reg [15:0] max_R = 0;
   reg [15:0] max_G = 0;
   reg [15:0] max_B = 0;
   reg ack = 0;
   
   assign pool_ack = ack;
   assign Pool_out_R = max_R;
   assign Pool_out_G = max_G;
   assign Pool_out_B = max_B;
   
   always @(posedge clk or negedge rst)
   begin
     if (rst) 
     begin 
       size_cnt <= 0;
       ack <= 0;
     end
     else if (en && (size_cnt == Size - 2))
     begin
       size_cnt <= size_cnt + 1; 
       ack <= 1;
     end 
     else if (en && (size_cnt == Size - 1))
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
    
   always @(posedge clk or negedge rst)
   begin
     if (rst) max_R <= 0;
     else if (en && size_cnt == 0)
     begin 
       max_R <= D_in_R;
     end 
     else if (en)
     begin 
       if (max_R < D_in_R) max_R <= D_in_R;
       else max_R <= max_R;
     end 
     else max_R <= 0;
   end 
   
   always @(posedge clk or negedge rst)
   begin
     if (rst) max_G <= 0;
     else if (en && size_cnt == 0)
     begin 
       max_G <= D_in_G;
     end 
     else if (en)
     begin 
       if (max_G < D_in_G) max_G <= D_in_G;
       else max_G <= max_G;
     end 
     else max_G <= 0;
   end 
    
   always @(posedge clk or negedge rst)
   begin
     if (rst) max_B <= 0;
     else if (en && size_cnt == 0)
     begin 
       max_B <= D_in_B;
     end 
     else if (en)
     begin 
       if (max_B < D_in_G) max_B <= D_in_B;
       else max_B <= max_B;
     end 
     else max_B <= 0;
   end 
    
    
endmodule
