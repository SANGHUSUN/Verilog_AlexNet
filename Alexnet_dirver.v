`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 01:11:55
// Design Name: 
// Module Name: Alexnet_dirver
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


module Alexnet_dirver(
input clk,rst,en,
input next,
input [15:0]ReLU_o_layer_R_1,ReLU_o_layer_G_1,ReLU_o_layer_B_1,
input [15:0]ReLU_o_layer_R_2,ReLU_o_layer_G_2,ReLU_o_layer_B_2,
input [15:0]ReLU_o_layer_R_3,ReLU_o_layer_G_3,ReLU_o_layer_B_3,
input [15:0]ReLU_o_layer_R_4,ReLU_o_layer_G_4,ReLU_o_layer_B_4,
input [15:0]ReLU_o_layer_R_5,ReLU_o_layer_G_5,ReLU_o_layer_B_5,
input [15:0]Fc_o_layer_1,Fc_o_layer_2,Fc_o_layer_3,
input [15:0]Pool_o_layer_R_1,Pool_o_layer_G_1,Pool_o_layer_B_1,
input [15:0]Pool_o_layer_R_2,Pool_o_layer_G_2,Pool_o_layer_B_2,
input [15:0]Pool_o_layer_R_3,Pool_o_layer_G_3,Pool_o_layer_B_3,

input relu_1_ack,pool_1_ack,relu_2_ack,pool_2_ack,relu_3_ack,relu_4_ack,relu_5_ack,pool_3_ack,relu_6_ack,relu_7_ack,relu_8_ack,

output reg conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en,

output reg [15:0]conv_i_layer_R_1,conv_i_layer_G_1,conv_i_layer_B_1,
output wire [15:0]conv_weight_layer_R_1,conv_weight_layer_G_1,conv_weight_layer_B_1,
output wire [15:0]conv_bias_layer_1,

output reg [15:0]conv_i_layer_R_2,conv_i_layer_G_2,conv_i_layer_B_2,
output wire [15:0]conv_weight_layer_R_2,conv_weight_layer_G_2,conv_weight_layer_B_2,
output wire [15:0]conv_bias_layer_2,

output reg [15:0]conv_i_layer_R_3,conv_i_layer_G_3,conv_i_layer_B_3,
output wire [15:0]conv_weight_layer_R_3,conv_weight_layer_G_3,conv_weight_layer_B_3,
output wire [15:0]conv_bias_layer_3,

output reg [15:0]conv_i_layer_R_4,conv_i_layer_G_4,conv_i_layer_B_4,
output wire [15:0]conv_weight_layer_R_4,conv_weight_layer_G_4,conv_weight_layer_B_4,
output wire [15:0]conv_bias_layer_4,

output reg [15:0]conv_i_layer_R_5,conv_i_layer_G_5,conv_i_layer_B_5,
output wire [15:0]conv_weight_layer_R_5,conv_weight_layer_G_5,conv_weight_layer_B_5,
output wire [15:0]conv_bias_layer_5,

output reg [15:0]Pool_i_layer_R_1,Pool_i_layer_G_1,Pool_i_layer_B_1,
output reg [15:0]Pool_i_layer_R_2,Pool_i_layer_G_2,Pool_i_layer_B_2,
output reg [15:0]Pool_i_layer_R_3,Pool_i_layer_G_3,Pool_i_layer_B_3,

output reg  [15:0]fc_i_layer_1,fc_i_layer_2,fc_i_layer_3,
output wire [15:0]fc_weight_layer_1,fc_weight_layer_2,fc_weight_layer_3,
output wire [15:0]fc_bias_layer_1,fc_bias_layer_2,fc_bias_layer_3,

output Done,
output reg [2:0]sw = 3'b111
    );
    
    
    parameter H_IM = 227;
    parameter V_IM = 227;
    parameter CONV_LAYER_1_H = 11;
    parameter CONV_LAYER_1_V = 11;
    parameter CONV_LAYER_1_H_V = CONV_LAYER_1_H * CONV_LAYER_1_V;
    parameter CONV_LAYER_1_NUM = 96;
    
    parameter POOL_1_H = 55;
    parameter POOL_1_V = 55;
    parameter POOL_LAYER_1_NUM = 96;
    parameter POOL_LAYER_1_H = 3;
    parameter POOL_LAYER_1_V = 3;
    
    
    parameter CONV_2_H = 27;
    parameter CONV_2_V = 27;
    parameter CONV_LAYER_2_H = 5;
    parameter CONV_LAYER_2_V = 5;
    parameter CONV_LAYER_2_H_V = CONV_LAYER_2_H * CONV_LAYER_2_V;
    parameter CONV_LAYER_2_NUM = 256;
    
    parameter POOL_2_H = 13;
    parameter POOL_2_V = 13;
    parameter POOL_LAYER_2_NUM = 256;
    parameter POOL_LAYER_2_H = 3;
    parameter POOL_LAYER_2_V = 3;
    
    parameter CONV_3_H = 13;
    parameter CONV_3_V = 13;
    parameter CONV_LAYER_3_H = 3;
    parameter CONV_LAYER_3_V = 3;
    parameter CONV_LAYER_3_H_V = CONV_LAYER_3_H * CONV_LAYER_3_V;
    parameter CONV_LAYER_3_NUM = 384;
    
    parameter CONV_4_H = 13;
    parameter CONV_4_V = 13;
    parameter CONV_LAYER_4_H = 3;
    parameter CONV_LAYER_4_V = 3;
    parameter CONV_LAYER_4_H_V = CONV_LAYER_4_H * CONV_LAYER_4_V;
    parameter CONV_LAYER_4_NUM = 384;
    
    parameter CONV_5_H = 13;
    parameter CONV_5_V = 13;
    parameter CONV_LAYER_5_H = 3;
    parameter CONV_LAYER_5_V = 3;
    parameter CONV_LAYER_5_H_V = CONV_LAYER_5_H * CONV_LAYER_5_V;
    parameter CONV_LAYER_5_NUM = 256;
    
    parameter POOL_3_H = 13;
    parameter POOL_3_V = 13;
    parameter POOL_LAYER_3_NUM = 256;
    parameter POOL_LAYER_3_H = 3;
    parameter POOL_LAYER_3_V = 3;
    
    parameter FC_1_WIDTH = 9216;
    parameter FC_1_DEEPTH = 10;
    
    parameter FC_2_WIDTH = 10;
    parameter FC_2_DEEPTH = 10;
    
    parameter FC_3_WIDTH = 10;
    parameter FC_3_DEEPTH = 3;
    
    localparam IDLE = 0;
    localparam CONV_1 = 1;
    localparam POOL_1 = 2;
    localparam CONV_2 = 3;
    localparam POOL_2 = 4;
    localparam CONV_3 = 5;
    localparam CONV_4 = 6;
    localparam CONV_5 = 7;
    localparam POOL_3 = 8;
    localparam FC_1   = 9;
    localparam FC_2   = 10;
    localparam FC_3   = 11;
    localparam STOP   = 12;
    
    reg [3:0] net_st = 8;     /////状态机现态
    reg [3:0] next_net_st = 0;   /////状态机次态
    
    reg [8:0] x_im_cnt = 0,y_im_cnt = 0;
    reg [8:0] x_map_cnt_1 = 0,y_map_cnt_1 = 0;
    reg [8:0] x_im_cnt_2 = 0,y_im_cnt_2 = 0;
    reg [8:0] x_map_cnt_2 = 0,y_map_cnt_2 = 0;
    reg [8:0] x_im_cnt_3 = 0,y_im_cnt_3 = 0;
    reg [8:0] x_im_cnt_4 = 0,y_im_cnt_4 = 0;
    reg [8:0] x_im_cnt_5 = 0,y_im_cnt_5 = 0;
    reg [8:0] x_map_cnt_3 = 0,y_map_cnt_3 = 0;
    
    reg [3:0]x_conv = 0,y_conv = 0;
    reg [3:0]x_pool = 0,y_pool = 0;
    reg [3:0]x_conv_2 = 0,y_conv_2 = 0;
    reg [3:0]x_pool_2 = 0,y_pool_2 = 0;
    reg [3:0]x_conv_3 = 0,y_conv_3 = 0;
    reg [3:0]x_conv_4 = 0,y_conv_4 = 0;
    reg [3:0]x_conv_5 = 0,y_conv_5 = 0;
    reg [3:0]x_pool_3 = 0,y_pool_3 = 0;
    
    reg [8:0]num_conv_1 = 0,num_conv_2 = 0,num_conv_3 = 0,num_conv_4 = 0,num_conv_5 = 0;
    reg [8:0]num_pool_1 = 0,num_pool_2 = 0,num_pool_3 = 0;
    
    reg [15:0]fc_w_cnt_1 = 0,fc_w_cnt_2 = 0,fc_w_cnt_3 = 0;
    reg [15:0] fc_b_cnt_1 = 0,fc_b_cnt_2 = 0,fc_b_cnt_3 = 0;
    reg [15:0]fc_cnt_1 = 0,  fc_cnt_2 = 0,fc_cnt_3 = 0;
    reg [15:0] fc_layer_cnt_1 = 0,fc_layer_cnt_2 = 0,fc_layer_cnt_3 = 0;
    
    reg conv_w_ack_1 = 0;
    reg conv_num_ack_1 = 0;
    
    reg pool_w_ack_1 = 0;
    reg pool_num_ack_1 = 0;
    
    reg conv_w_ack_2 = 0;
    reg conv_num_ack_2 = 0;
    
    reg pool_w_ack_2 = 0;
    reg pool_num_ack_2 = 0;
    
    reg conv_w_ack_3 = 0;
    reg conv_num_ack_3 = 0;
    
    reg conv_w_ack_4 = 0;
    reg conv_num_ack_4 = 0;
    
    reg conv_w_ack_5 = 0;
    reg conv_num_ack_5 = 0;
    
    reg pool_w_ack_3 = 0;
    reg pool_num_ack_3 = 0;
    
    
    
    ///////////写地址信号/////////////
    reg  [15:0]addra_1,addra_2,addra_3;  ////总地址控制
    reg  wea_1,wea_2,wea_3;
    reg  [15:0]dina_1,dina_2,dina_3;
    reg  [15:0]addrb_1,addrb_2,addrb_3;
    wire [15:0]doutb_1,doutb_2,doutb_3;
    
    reg [15:0] x_wr_conv_addr_1 = 0;
    reg [15:0] x_wr_conv_addr_2 = 0;
    reg [15:0] x_wr_conv_addr_3 = 0;
    reg [15:0] x_wr_conv_addr_4 = 0;
    reg [15:0] x_wr_conv_addr_5 = 0;
    reg [15:0] x_wr_pool_addr_1 = 0;
    reg [15:0] x_wr_pool_addr_2 = 0;
    reg [15:0] x_wr_pool_addr_3 = 0;
    reg [15:0]  x_wr_fc_addr_1;
    reg [15:0]  x_wr_fc_addr_2;
    
    
    //////////////读地址信号///////////////
    wire [15:0] x_rd_conv_addr_1 ;
    wire [15:0] x_rd_conv_addr_2 ;
    wire [15:0] x_rd_conv_addr_3 ;
    wire [15:0] x_rd_conv_addr_4 ;
    wire [15:0] x_rd_conv_addr_5 ;
    wire [15:0] x_rd_pool_addr_1 ;
    wire [15:0] x_rd_pool_addr_2 ;
    wire [15:0] x_rd_pool_addr_3 ;
    wire [15:0] x_rd_fc_addr_1;
    wire [15:0] x_rd_fc_addr_2;
    wire [15:0] x_rd_fc_addr_3;
    
    wire [13:0]x_conv_w_addr_1;
    wire [8:0] x_conv_b_addr_1;
    
    wire [13:0]x_conv_w_addr_2;
    wire [8:0] x_conv_b_addr_2;
    
    wire [13:0]x_conv_w_addr_3;
    wire [8:0] x_conv_b_addr_3;
    
    wire [13:0]x_conv_w_addr_4;
    wire [8:0] x_conv_b_addr_4;
    
    wire [13:0]x_conv_w_addr_5;
    wire [8:0] x_conv_b_addr_5;
    
    
    wire [16:0]x_w_fc_addr_1;
    wire [3:0] x_b_fc_addr_1;
    
    wire [6:0]x_w_fc_addr_2;
    wire [3:0]x_b_fc_addr_2;
    
    wire [4:0]x_w_fc_addr_3;
    wire [1:0]x_b_fc_addr_3;
    
    ////////////最终输出计数器//////////
    reg [15:0] classify[2:0];
    reg [1:0]fc_cnt = 0;

   assign Done = (net_st == STOP)? 1:0;
   
   
    always @(posedge clk or posedge rst)
    begin
      if (rst) net_st <= IDLE;
      else net_st <= next_net_st; 
    end 
    
    /////////////////状态转换//////////////////////
    always @(*)
    begin
      case(net_st)
      IDLE: 
      begin
        if (en) next_net_st = CONV_1; 
        else next_net_st = IDLE;
      end 
      CONV_1:
      begin
        if (num_conv_1 == CONV_LAYER_1_NUM - 1) next_net_st = POOL_1;
        else next_net_st = CONV_1;
      end 
      POOL_1:
      begin
         if (num_pool_1 == POOL_LAYER_1_NUM - 1) next_net_st = CONV_2;
         else next_net_st = POOL_1;
      end 
      CONV_2:
      begin
         if (num_conv_2 == CONV_LAYER_2_NUM - 1) next_net_st = POOL_2;
         else next_net_st = CONV_2;
      end 
      POOL_2:
      begin
         if (num_pool_2 == POOL_LAYER_2_NUM - 1) next_net_st = CONV_3;
         else next_net_st = POOL_2;
      end 
      CONV_3:
      begin
         if (num_conv_3 == CONV_LAYER_3_NUM - 1) next_net_st = CONV_4;
         else next_net_st = CONV_3;
      end 
      CONV_4:
      begin
         if (num_conv_4 == CONV_LAYER_4_NUM - 1) next_net_st = CONV_5;
         else next_net_st = CONV_4;
      end 
      CONV_5:
      begin 
         if (num_conv_5 == CONV_LAYER_5_NUM - 1) next_net_st = POOL_3;
         else next_net_st = CONV_5;
      end 
      POOL_3:
      begin
         if (num_pool_3 == POOL_LAYER_3_NUM - 1) next_net_st = FC_1;
         else next_net_st = POOL_3;
      end 
      FC_1:
      begin 
         if (fc_layer_cnt_1 == FC_1_DEEPTH) next_net_st = FC_2;
         else next_net_st = FC_1;
      end 
      FC_2:
      begin 
         if (fc_layer_cnt_2 == FC_2_DEEPTH) next_net_st = FC_3;
         else next_net_st = FC_2;
      end 
      FC_3:
      begin 
         if (fc_layer_cnt_3 == FC_3_DEEPTH) next_net_st = STOP;
         else next_net_st = FC_3;
      end 
      STOP: 
      begin 
        if (!next) next_net_st = IDLE;
        else next_net_st = STOP;
      end 
      default: next_net_st = IDLE;
      endcase 
    end 
    
    
    /////////////////////使能控制///////////////////////
    always @(*)
    begin
      case(net_st)
      IDLE:   {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_000;
      CONV_1: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b1000_0000_000;
      POOL_1: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0100_000;
      CONV_2: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0100_0000_000;
      POOL_2: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0010_000;
      CONV_3: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0010_0000_000;
      CONV_4: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0001_0000_000;
      CONV_5: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_1000_000;
      POOL_3: {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0001_000;
      FC_1:   {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_100;
      FC_2:   {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_010;
      FC_3:   {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_001;
      STOP:   {conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_000;
      default:{conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en} = 11'b0000_0000_000;
      endcase
    end
    
    
    ///////////////////////////地址控制////////////////////////
    
    /////////////////////卷积写地址控制////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_conv_addr_1 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_conv_addr_1 <= 0;
      else if (relu_1_ack) x_wr_conv_addr_1 <= x_wr_conv_addr_1 + 1;
      else x_wr_conv_addr_1 <= x_wr_conv_addr_1;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_conv_addr_2 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_conv_addr_2 <= 0;
      else if (relu_2_ack) x_wr_conv_addr_2 <= x_wr_conv_addr_2 + 1;
      else x_wr_conv_addr_2 <= x_wr_conv_addr_2;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_conv_addr_3 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_conv_addr_3 <= 0;
      else if (relu_3_ack) x_wr_conv_addr_3 <= x_wr_conv_addr_3 + 1;
      else x_wr_conv_addr_3 <= x_wr_conv_addr_3;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_conv_addr_4 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_conv_addr_4 <= 0;
      else if (relu_4_ack) x_wr_conv_addr_4 <= x_wr_conv_addr_4 + 1;
      else x_wr_conv_addr_4 <= x_wr_conv_addr_4;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_conv_addr_5 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_conv_addr_5 <= 0;
      else if (relu_5_ack) x_wr_conv_addr_5 <= x_wr_conv_addr_5 + 1;
      else x_wr_conv_addr_5 <= x_wr_conv_addr_5;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_pool_addr_1 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_pool_addr_1 <= 0;
      else if (pool_1_ack) x_wr_pool_addr_1 <= x_wr_pool_addr_1 + 1;
      else x_wr_pool_addr_1 <= x_wr_pool_addr_1;
    end
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_pool_addr_1 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_pool_addr_1 <= 0;
      else if (pool_1_ack) x_wr_pool_addr_1 <= x_wr_pool_addr_1 + 1;
      else x_wr_pool_addr_1 <= x_wr_pool_addr_1;
    end
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_pool_addr_2 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_pool_addr_2 <= 0;
      else if (pool_2_ack) x_wr_pool_addr_2 <= x_wr_pool_addr_2 + 1;
      else x_wr_pool_addr_2 <= x_wr_pool_addr_2;
    end
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_pool_addr_3 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_pool_addr_3 <= 0;
      else if (pool_3_ack) x_wr_pool_addr_3 <= x_wr_pool_addr_3 + 1;
      else x_wr_pool_addr_3 <= x_wr_pool_addr_3;
    end
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_fc_addr_1 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_fc_addr_1 <= 0;
      else if (relu_6_ack) x_wr_fc_addr_1 <= x_wr_fc_addr_1 + 1;
      else x_wr_fc_addr_1 <= x_wr_fc_addr_1;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_wr_fc_addr_2 <= 0;
      else if (net_st == IDLE || net_st == STOP) x_wr_fc_addr_2 <= 0;
      else if (relu_7_ack) x_wr_fc_addr_2 <= x_wr_fc_addr_2 + 1;
      else x_wr_fc_addr_2 <= x_wr_fc_addr_2;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
     if (rst) fc_cnt <= 0;
      else if (net_st == IDLE || net_st == STOP) fc_cnt <= 0;
      else if (relu_8_ack) fc_cnt <= fc_cnt + 1;
      else fc_cnt <= fc_cnt;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
     if (rst) begin classify[0] <= 0;classify[1] <= 0;classify[2] <= 0;end
      else if (net_st == IDLE) 
      begin 
        classify[0] <= 0;
        classify[1] <= 0;
        classify[2] <= 0;
      end
      else if (relu_8_ack) classify[fc_cnt] <= Fc_o_layer_3;
      else 
      begin 
        classify[0] <= classify[0];
        classify[1] <= classify[1];
        classify[2] <= classify[2];
      end
    end 
    
    ////////////////////////图像读地址控制//////////////////////
    assign x_rd_conv_addr_1 = x_im_cnt + x_conv + (y_im_cnt + y_conv) * H_IM;
    assign x_rd_conv_addr_2 = x_im_cnt_2 + x_conv_2 + (y_im_cnt_2 + y_conv_2) * CONV_2_H;
    assign x_rd_conv_addr_3 = x_im_cnt_3 + x_conv_3 + (y_im_cnt_3 + y_conv_3) * CONV_3_H;
    assign x_rd_conv_addr_4 = x_im_cnt_4 + x_conv_4 + (y_im_cnt_4 + y_conv_4)* CONV_4_H;
    assign x_rd_conv_addr_5 = x_im_cnt_5 + x_conv_5 + (y_im_cnt_5 + y_conv_5) * CONV_5_H;
    assign x_rd_pool_addr_1 = x_map_cnt_1 + x_pool + (y_map_cnt_1 + y_pool) * POOL_1_H;
    assign x_rd_pool_addr_2 = x_map_cnt_2 + x_pool_2 + (y_map_cnt_2 + y_pool_2) * POOL_2_H;
    assign x_rd_pool_addr_3 = x_map_cnt_3 + x_pool_3 + (y_map_cnt_3 + y_pool_3) * POOL_3_H;
    assign x_rd_fc_addr_1   = fc_cnt_1;
    assign x_rd_fc_addr_2   = fc_cnt_2;
    assign x_rd_fc_addr_3   = fc_cnt_3;
    
    ////////////////////////权值读地址控制///////////////////////
    assign  x_conv_w_addr_1 = x_conv + y_conv * CONV_LAYER_1_H + num_conv_1 * CONV_LAYER_1_H_V;
    assign  x_conv_b_addr_1 = num_conv_1;
    
    assign  x_conv_w_addr_2 = x_conv_2 + y_conv_2 * CONV_LAYER_2_H + num_conv_2 * CONV_LAYER_2_H_V;
    assign  x_conv_b_addr_2 = num_conv_2;
    
    assign  x_conv_w_addr_3 = x_conv_3 + y_conv_3 * CONV_LAYER_3_H + num_conv_3 * CONV_LAYER_3_H_V;
    assign  x_conv_b_addr_3 = num_conv_3;
    
    assign  x_conv_w_addr_4 = x_conv_4 + y_conv_4 * CONV_LAYER_4_H + num_conv_4 * CONV_LAYER_4_H_V;
    assign  x_conv_b_addr_4 = num_conv_4;
    
    assign  x_conv_w_addr_5 = x_conv_5 + y_conv_5 * CONV_LAYER_5_H + num_conv_5 * CONV_LAYER_5_H_V;
    assign  x_conv_b_addr_5 = num_conv_5;
    
    assign  x_w_fc_addr_1  = fc_cnt_1 + fc_layer_cnt_1 * FC_1_WIDTH;
    assign  x_b_fc_addr_1  = fc_layer_cnt_1;
    
    assign  x_w_fc_addr_2  = fc_cnt_2 + fc_layer_cnt_2 * FC_2_WIDTH;
    assign  x_b_fc_addr_2  = fc_layer_cnt_2;
    
    assign  x_w_fc_addr_3  = fc_cnt_3 + fc_layer_cnt_3 * FC_3_WIDTH;
    assign  x_b_fc_addr_3  = fc_layer_cnt_3;
    
    
    ////////////////////图像计数////STRIDE == 4//////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_im_cnt <= 0;
       else if (x_im_cnt == H_IM - CONV_LAYER_1_H && (conv_w_ack_1) && (net_st == CONV_1))
       begin
         x_im_cnt <= 0;
       end 
       else if (conv_w_ack_1 && (net_st == CONV_1)) 
       begin 
         x_im_cnt <= x_im_cnt + 4;
       end 
       else if ((net_st == CONV_1))
       begin
         x_im_cnt <= x_im_cnt;
       end 
       else 
       begin
         x_im_cnt <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_im_cnt <= 0;
         conv_num_ack_1 <= 0;
       end
       else if (y_im_cnt == V_IM - CONV_LAYER_1_V && (conv_w_ack_1) && (net_st == CONV_1))
       begin
         y_im_cnt <= 0;
         conv_num_ack_1 <= 1;
       end 
       else if (conv_w_ack_1 && (net_st == CONV_1) && x_im_cnt == H_IM - CONV_LAYER_1_H) 
       begin 
         y_im_cnt <= y_im_cnt + 4;
         conv_num_ack_1 <= 0;
       end 
       else if ((net_st == CONV_1))
       begin
         y_im_cnt <= y_im_cnt;
         conv_num_ack_1 <= 0;
       end 
       else 
       begin
         y_im_cnt <= 0; 
         conv_num_ack_1 <= 0;
       end 
    end 
    
   
    ////////////////////窗口计数/////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_conv <= 0; 
      else if ((net_st == CONV_1) && x_conv == CONV_LAYER_1_H - 1)
      begin 
        x_conv <= 0;
      end  
      else if ((net_st == CONV_1))
      begin
        x_conv <= x_conv + 1; 
      end 
      else x_conv <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_conv <= 0;
        conv_w_ack_1 <= 0;
      end
      else if ((net_st == CONV_1) && y_conv == CONV_LAYER_1_V - 1 && (x_conv == CONV_LAYER_1_H - 1))
      begin 
        y_conv <= 0;
        conv_w_ack_1 <= 1;
      end 
      else if ((net_st == CONV_1) && (x_conv == CONV_LAYER_1_H - 1))
      begin
        y_conv <= y_conv + 1;
        conv_w_ack_1 <= 0;
      end 
      else if (net_st == CONV_1)
      begin 
        y_conv <= y_conv;
        conv_w_ack_1 <= 0;
      end 
      else 
      begin 
        y_conv <= 0;
        conv_w_ack_1 <= 0;
      end 
    end
     
    /////////////////////计数器///////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_conv_1<= 0;
      else if (net_st == CONV_1 && (num_conv_1 == CONV_LAYER_1_NUM - 1) && conv_num_ack_1) num_conv_1 <= 0;
      else if (net_st == CONV_1 && conv_num_ack_1) num_conv_1 <= num_conv_1 + 1;
      else if (net_st == CONV_1) num_conv_1 <= num_conv_1;
      else num_conv_1 <= 0;
    end 
    
    //////////////////////////////////////池化层////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_pool <= 0; 
      else if ((net_st == POOL_1) && x_pool == POOL_LAYER_1_H - 1)
      begin 
        x_pool <= 0;
      end  
      else if ((net_st == POOL_1))
      begin
        x_pool <= x_pool + 1; 
      end 
      else x_pool <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_pool <= 0;
        pool_w_ack_1 <= 0;
      end
      else if ((net_st == POOL_1) && y_pool == POOL_LAYER_1_V - 1 && (x_pool == POOL_LAYER_1_H - 1))
      begin 
        y_pool <= 0;
        pool_w_ack_1 <= 1;
      end 
      else if ((net_st == POOL_1) && (x_pool == POOL_LAYER_1_H - 1))
      begin
        y_pool <= y_pool + 1;
        pool_w_ack_1 <= 0;
      end 
      else if(net_st == POOL_1)
      begin 
        y_pool <= y_pool;
        pool_w_ack_1 <= 0;
      end 
      else 
      begin 
        y_pool <= 0;
        pool_w_ack_1 <= 0;
      end 
    end
    
    /////////////////////////特征图计数，STRIDE == 2////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_map_cnt_1 <= 0;
       else if (x_map_cnt_1 == POOL_1_H - POOL_LAYER_1_H && (pool_w_ack_1) && (net_st == POOL_1))
       begin
         x_map_cnt_1 <= 0;
       end 
       else if (pool_w_ack_1 && (net_st == POOL_1)) 
       begin 
         x_map_cnt_1 <= x_map_cnt_1 + 2;
       end 
       else if ((net_st == POOL_1))
       begin
         x_map_cnt_1 <= x_map_cnt_1;
       end 
       else 
       begin
         x_map_cnt_1 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_map_cnt_1 <= 0;
         pool_num_ack_1 <= 0;
       end
       else if (y_map_cnt_1 == POOL_1_V - POOL_LAYER_1_V && (pool_w_ack_1) && (net_st == POOL_1))
       begin
         y_map_cnt_1 <= 0;
         pool_num_ack_1 <= 1;
       end 
       else if (pool_w_ack_1 && (net_st == POOL_1) && x_map_cnt_1 == POOL_1_H - POOL_LAYER_1_H) 
       begin 
         y_map_cnt_1 <= y_map_cnt_1 + 2;
         pool_num_ack_1 <= 0;
       end 
       else if ((net_st == POOL_1))
       begin
         y_map_cnt_1 <= y_map_cnt_1;
         pool_num_ack_1 <= 0;
       end 
       else 
       begin
         y_map_cnt_1 <= 0; 
         pool_num_ack_1 <= 0;
       end 
    end 
    
    /////////////////////////////池化计数器////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_pool_1 <= 0;
      else if (net_st == POOL_1 && (num_pool_1 == POOL_LAYER_1_NUM - 1) && pool_num_ack_1) num_pool_1 <= 0;
      else if (net_st == POOL_1 && pool_num_ack_1) num_pool_1 <= num_pool_1 + 1;
      else if (net_st == POOL_1) num_pool_1 <= num_pool_1;
      else num_pool_1 <= 0;
    end 
    
     
     /////////////////////////////第二层卷积 STRIDE == 1////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_im_cnt_2 <= 0;
       else if (x_im_cnt_2 == CONV_2_H - CONV_LAYER_2_H && (conv_w_ack_2) && (net_st == CONV_2))
       begin
         x_im_cnt_2 <= 0;
       end 
       else if (conv_w_ack_2 && (net_st == CONV_2)) 
       begin 
         x_im_cnt_2 <= x_im_cnt_2 + 1;
       end 
       else if ((net_st == CONV_2))
       begin
         x_im_cnt_2 <= x_im_cnt_2;
       end 
       else 
       begin
         x_im_cnt_2 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_im_cnt_2 <= 0;
         conv_num_ack_2 <= 0;
       end
       else if (y_im_cnt_2 == CONV_2_V - CONV_LAYER_2_V && (conv_w_ack_2) && (net_st == CONV_2))
       begin
         y_im_cnt_2 <= 0;
         conv_num_ack_2 <= 1;
       end 
       else if (conv_w_ack_2 && (net_st == CONV_2) && x_im_cnt_2 == CONV_2_H - CONV_LAYER_2_H) 
       begin 
         y_im_cnt_2 <= y_im_cnt_2 + 1;
         conv_num_ack_2 <= 0;
       end 
       else if ((net_st == CONV_2))
       begin
         y_im_cnt_2 <= y_im_cnt_2;
         conv_num_ack_2 <= 0;
       end 
       else 
       begin
         y_im_cnt_2 <= 0; 
         conv_num_ack_2 <= 0;
       end 
    end 
    
   
    ////////////////////窗口计数/////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_conv_2 <= 0; 
      else if ((net_st == CONV_2) && x_conv_2 == CONV_LAYER_2_H - 1)
      begin 
        x_conv_2 <= 0;
      end  
      else if ((net_st == CONV_2))
      begin
        x_conv_2 <= x_conv_2 + 1; 
      end 
      else x_conv_2 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_conv_2 <= 0;
        conv_w_ack_2 <= 0;
      end
      else if ((net_st == CONV_2) && y_conv_2 == CONV_LAYER_2_V - 1 && (x_conv_2 == CONV_LAYER_2_H - 1))
      begin 
        y_conv_2 <= 0;
        conv_w_ack_2 <= 1;
      end 
      else if ((net_st == CONV_2) && (x_conv_2 == CONV_LAYER_2_H - 1))
      begin
        y_conv_2 <= y_conv_2 + 1;
        conv_w_ack_2 <= 0;
      end 
      else 
      begin if (net_st == CONV_2)
      begin 
        y_conv_2 <= y_conv_2;
        conv_w_ack_2 <= 0;
      end 
      else 
      begin 
        y_conv_2 <= 0;
        conv_w_ack_2 <= 0;
      end
      end 
    end
     
    /////////////////////计数器///////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_conv_2 <= 0;
      else if (net_st == CONV_2 && (num_conv_2 == CONV_LAYER_2_NUM - 1) && conv_num_ack_2) num_conv_2 <= 0;
      else if (net_st == CONV_2 && conv_num_ack_2) num_conv_2 <= num_conv_2 + 1;
      else if (net_st == CONV_2) num_conv_2 <= num_conv_2;
      else num_conv_2 <= 0;
    end 
    
    /////////////////////////////////第二层池化层///////////////////////////////////////////////
     always @(posedge clk or posedge rst)
    begin
      if (rst) x_pool_2 <= 0; 
      else if ((net_st == POOL_2) && x_pool_2 == POOL_LAYER_2_H - 1)
      begin 
        x_pool_2 <= 0;
      end  
      else if ((net_st == POOL_2))
      begin
        x_pool_2 <= x_pool_2 + 1; 
      end 
      else x_pool_2 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_pool_2 <= 0;
        pool_w_ack_2 <= 0;
      end
      else if ((net_st == POOL_2) && y_pool_2 == POOL_LAYER_2_V - 1 && (x_pool_2 == POOL_LAYER_2_H - 1))
      begin 
        y_pool_2 <= 0;
        pool_w_ack_2 <= 1;
      end 
      else if ((net_st == POOL_2) && (x_pool_2 == POOL_LAYER_2_H - 1))
      begin
        y_pool_2 <= y_pool_2 + 2;
        pool_w_ack_2 <= 0;
      end 
      else 
      begin if (net_st == POOL_2)
      begin 
        y_pool_2 <= y_pool_2;
        pool_w_ack_2 <= 0;
      end 
      else 
      begin 
        y_pool_2 <= 0;
        pool_w_ack_2 <= 0;
       end
      end 
    end
    
    /////////////////////////特征图计数，STRIDE == 2////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_map_cnt_2 <= 0;
       else if (x_map_cnt_2 == POOL_2_H - POOL_LAYER_2_H && (pool_w_ack_2) && (net_st == POOL_2))
       begin
         x_map_cnt_2 <= 0;
       end 
       else if (pool_w_ack_2 && (net_st == POOL_2)) 
       begin 
         x_map_cnt_2 <= x_map_cnt_2 + 2;
       end 
       else if ((net_st == POOL_2))
       begin
         x_map_cnt_2 <= x_map_cnt_2;
       end 
       else 
       begin
         x_map_cnt_2 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_map_cnt_2 <= 0;
         pool_num_ack_2 <= 0;
       end
       else if (y_map_cnt_2 == POOL_2_V - POOL_LAYER_2_V && (pool_w_ack_2) && (net_st == POOL_2))
       begin
         y_map_cnt_2 <= 0;
         pool_num_ack_2 <= 1;
       end 
       else if (pool_w_ack_2 && (net_st == POOL_2) && x_map_cnt_2 == POOL_2_H - POOL_LAYER_2_H ) 
       begin 
         y_map_cnt_2 <= y_map_cnt_2 + 2;
         pool_num_ack_2 <= 0;
       end 
       else if ((net_st == POOL_2))
       begin
         y_map_cnt_2 <= y_map_cnt_2;
         pool_num_ack_2 <= 0;
       end 
       else 
       begin
         y_map_cnt_2 <= 0; 
         pool_num_ack_2 <= 0;
       end 
    end 
    
    /////////////////////////////池化计数器////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_pool_2 <= 0;
      else if (net_st == POOL_2 && (num_pool_2 == POOL_LAYER_2_NUM - 1 && (pool_num_ack_2))) num_pool_2 <= 0;
      else if (net_st == POOL_2 && pool_num_ack_2) num_pool_2 <= num_pool_2 + 1;
      else if (net_st == POOL_2) num_pool_2 <= num_pool_2;
      else num_pool_2 <= 0;
    end 
    
    ////////////////////////第三层卷积层  STRIDE == 1////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_im_cnt_3 <= 0;
       else if (x_im_cnt_3 == CONV_3_H - CONV_LAYER_3_H && (conv_w_ack_3) && (net_st == CONV_3))
       begin
         x_im_cnt_3 <= 0;
       end 
       else if (conv_w_ack_3 && (net_st == CONV_3)) 
       begin 
         x_im_cnt_3 <= x_im_cnt_3 + 1;
       end 
       else if ((net_st == CONV_3))
       begin
         x_im_cnt_3 <= x_im_cnt_3;
       end 
       else 
       begin
         x_im_cnt_3 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_im_cnt_3 <= 0;
         conv_num_ack_3 <= 0;
       end
       else if (y_im_cnt_3 == CONV_3_V - CONV_LAYER_3_V && (conv_w_ack_3) && (net_st == CONV_3))
       begin
         y_im_cnt_3 <= 0;
         conv_num_ack_3 <= 1;
       end 
       else if (conv_w_ack_3 && (net_st == CONV_3) && (x_im_cnt_3 == CONV_3_H - CONV_LAYER_3_H)) 
       begin 
         y_im_cnt_3 <= y_im_cnt_3 + 1;
         conv_num_ack_3 <= 0;
       end 
       else if ((net_st == CONV_3))
       begin
         y_im_cnt_3 <= y_im_cnt_3;
         conv_num_ack_3 <= 0;
       end 
       else 
       begin
         y_im_cnt_3 <= 0; 
         conv_num_ack_3 <= 0;
       end 
    end 
    
   
    ////////////////////窗口计数/////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_conv_3 <= 0; 
      else if ((net_st == CONV_3) && x_conv_3 == CONV_LAYER_3_H - 1)
      begin 
        x_conv_3 <= 0;
      end  
      else if ((net_st == CONV_3))
      begin
        x_conv_3 <= x_conv_3 + 1; 
      end 
      else x_conv_3 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_conv_3 <= 0;
        conv_w_ack_3 <= 0;
      end
      else if ((net_st == CONV_3) && y_conv_3 == CONV_LAYER_3_V - 1 && (x_conv_3 == CONV_LAYER_3_H - 1))
      begin 
        y_conv_3 <= 0;
        conv_w_ack_3 <= 1;
      end 
      else if ((net_st == CONV_3) && (x_conv_3 == CONV_LAYER_3_H - 1))
      begin
        y_conv_3 <= y_conv_3 + 1;
        conv_w_ack_3 <= 0;
      end 
      else if (net_st == CONV_3)
      begin 
        y_conv_3 <= y_conv_3;
        conv_w_ack_3 <= 0;
      end 
      else 
      begin 
        y_conv_3 <= 0;
        conv_w_ack_3 <= 0;
      end 
    end
     
    /////////////////////计数器///////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_conv_3 <= 0;
      else if (net_st == CONV_3 && (num_conv_3 == CONV_LAYER_3_NUM - 1) && conv_num_ack_3) num_conv_3 <= 0;
      else if (net_st == CONV_3 && conv_num_ack_3) num_conv_3 <= num_conv_3 + 1;
      else if (net_st == CONV_3) num_conv_3 <= num_conv_3;
      else num_conv_3 <= 0;
    end 
    
    ////////////////////////第四层卷积层 STRIDE == 1//////////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_im_cnt_4 <= 0;
       else if (x_im_cnt_4 == CONV_4_H - CONV_LAYER_4_H && (conv_w_ack_4) && (net_st == CONV_4))
       begin
         x_im_cnt_4 <= 0;
       end 
       else if (conv_w_ack_4 && (net_st == CONV_4)) 
       begin 
         x_im_cnt_4 <= x_im_cnt_4 + 1;
       end 
       else if ((net_st == CONV_4))
       begin
         x_im_cnt_4 <= x_im_cnt_4;
       end 
       else 
       begin
         x_im_cnt_4 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_im_cnt_4 <= 0;
         conv_num_ack_4 <= 0;
       end
       else if (y_im_cnt_4 == CONV_4_V - CONV_LAYER_4_V && (conv_w_ack_4) && (net_st == CONV_4))
       begin
         y_im_cnt_4 <= 0;
         conv_num_ack_4 <= 1;
       end 
       else if (conv_w_ack_4 && (net_st == CONV_4) && x_im_cnt_4 == CONV_4_H - CONV_LAYER_4_H ) 
       begin 
         y_im_cnt_4 <= y_im_cnt_4 + 1;
         conv_num_ack_4 <= 0;
       end 
       else if ((net_st == CONV_4))
       begin
         y_im_cnt_4 <= y_im_cnt_4;
         conv_num_ack_4 <= 0;
       end 
       else 
       begin
         y_im_cnt_4 <= 0; 
         conv_num_ack_4 <= 0;
       end 
    end 
    
   
    ////////////////////窗口计数/////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_conv_4 <= 0; 
      else if ((net_st == CONV_4) && x_conv_4 == CONV_LAYER_4_H - 1)
      begin 
        x_conv_4 <= 0;
      end  
      else if ((net_st == CONV_4))
      begin
        x_conv_4 <= x_conv_4 + 1; 
      end 
      else x_conv_4 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_conv_4 <= 0;
        conv_w_ack_4 <= 0;
      end
      else if ((net_st == CONV_4) && y_conv_4 == CONV_LAYER_4_V - 1 && (x_conv_4 == CONV_LAYER_4_H - 1))
      begin 
        y_conv_4 <= 0;
        conv_w_ack_4 <= 1;
      end 
      else if ((net_st == CONV_4) && (x_conv_4 == CONV_LAYER_4_H - 1))
      begin
        y_conv_4 <= y_conv_4 + 1;
        conv_w_ack_4 <= 0;
      end 
      else if (net_st == CONV_4)
      begin 
        y_conv_4 <= y_conv_4;
        conv_w_ack_4 <= 0;
      end 
      else 
      begin 
        y_conv_4 <= 0;
        conv_w_ack_4 <= 0;
      end 
    end
     
    /////////////////////计数器///////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_conv_4 <= 0;
      else if (net_st == CONV_4 && (num_conv_4 == CONV_LAYER_4_NUM - 1) && (conv_num_ack_4)) num_conv_4 <= 0;
      else if (net_st == CONV_4 && conv_num_ack_4) num_conv_4 <= num_conv_4 + 1;
      else if (net_st == CONV_4) num_conv_4 <= num_conv_4;
      else num_conv_4 <= 0;
    end 
    
    //////////////////////////第五层卷积层 STRIDE == 1//////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_im_cnt_5 <= 0;
       else if (x_im_cnt_5 == CONV_5_H - CONV_LAYER_5_H && (conv_w_ack_5) && (net_st == CONV_5))
       begin
         x_im_cnt_5 <= 0;
       end 
       else if (conv_w_ack_5 && (net_st == CONV_5)) 
       begin 
         x_im_cnt_5 <= x_im_cnt_5 + 1;
       end 
       else if ((net_st == CONV_5))
       begin
         x_im_cnt_5 <= x_im_cnt_5;
       end 
       else 
       begin
         x_im_cnt_5 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_im_cnt_5 <= 0;
         conv_num_ack_5 <= 0;
       end
       else if (y_im_cnt_5 == CONV_5_V - CONV_LAYER_5_V && (conv_w_ack_5) && (net_st == CONV_5))
       begin
         y_im_cnt_5 <= 0;
         conv_num_ack_5 <= 1;
       end 
       else if (conv_w_ack_5 && (net_st == CONV_5) && x_im_cnt_5 == CONV_5_H - CONV_LAYER_5_H) 
       begin 
         y_im_cnt_5 <= y_im_cnt_5 + 1;
         conv_num_ack_5 <= 0;
       end 
       else if ((net_st == CONV_5))
       begin
         y_im_cnt_5 <= y_im_cnt_5;
         conv_num_ack_5 <= 0;
       end 
       else 
       begin
         y_im_cnt_5 <= 0; 
         conv_num_ack_5 <= 0;
       end 
    end 
    
   
    ////////////////////窗口计数/////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst) x_conv_5 <= 0; 
      else if ((net_st == CONV_5) && x_conv_5 == CONV_LAYER_5_H - 1)
      begin 
        x_conv_5 <= 0;
      end  
      else if ((net_st == CONV_5))
      begin
        x_conv_5 <= x_conv_5 + 1; 
      end 
      else x_conv_5 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_conv_5 <= 0;
        conv_w_ack_5 <= 0;
      end
      else if ((net_st == CONV_5) && y_conv_5 == CONV_LAYER_5_V - 1 && (x_conv_5 == CONV_LAYER_5_H - 1))
      begin 
        y_conv_5 <= 0;
        conv_w_ack_5 <= 1;
      end 
      else if ((net_st == CONV_5) && (x_conv_5 == CONV_LAYER_5_H - 1))
      begin
        y_conv_5 <= y_conv_5 + 1;
        conv_w_ack_5 <= 0;
      end 
      else if (net_st == CONV_5)
      begin
        y_conv_5 <= y_conv_5;
        conv_w_ack_5 <= 0;
      end
      else 
      begin 
        y_conv_5 <= 0;
        conv_w_ack_5 <= 0;
      end 
    end
     
    /////////////////////计数器///////////////////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_conv_5 <= 0;
      else if (net_st == CONV_5 && (num_conv_5 == CONV_LAYER_5_NUM - 1) && conv_num_ack_5) num_conv_5 <= 0;
      else if (net_st == CONV_5 && conv_num_ack_5) num_conv_5 <= num_conv_5 + 1;
      else if (net_st == CONV_5) num_conv_5 <= num_conv_5;
      else num_conv_5 <= 0;
    end 
    
    /////////////////////第三层池化层////////////////////////////////////
     always @(posedge clk or posedge rst)
    begin
      if (rst) x_pool_3 <= 0; 
      else if ((net_st == POOL_3) && x_pool_3 == POOL_LAYER_3_H - 1)
      begin 
        x_pool_3 <= 0;
      end  
      else if ((net_st == POOL_3))
      begin
        x_pool_3 <= x_pool_3 + 1; 
      end 
      else x_pool_3 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin 
      if (rst) 
      begin 
        y_pool_3 <= 0;
        pool_w_ack_3 <= 0;
      end
      else if ((net_st == POOL_3) && y_pool_3 == POOL_LAYER_3_V - 1 && (x_pool_3 == POOL_LAYER_3_H - 1))
      begin 
        y_pool_3 <= 0;
        pool_w_ack_3 <= 1;
      end 
      else if ((net_st == POOL_3) && (x_pool_3 == POOL_LAYER_3_H - 1))
      begin
        y_pool_3 <= y_pool_3 + 3;
        pool_w_ack_3 <= 0;
      end 
      else if (net_st == POOL_3)
      begin 
         y_pool_3 <= y_pool_3;
        pool_w_ack_3 <= 0;
      end 
      else 
      begin 
        y_pool_3 <= 0;
        pool_w_ack_3 <= 0;
      end 
    end
    
    /////////////////////////特征图计数，STRIDE == 3////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) x_map_cnt_3 <= 0;
       else if (x_map_cnt_3 == POOL_3_H - POOL_LAYER_3_H && (pool_w_ack_3) && (net_st == POOL_3))
       begin
         x_map_cnt_3 <= 0;
       end 
       else if (pool_w_ack_3 && (net_st == POOL_3)) 
       begin 
         x_map_cnt_3 <= x_map_cnt_3 + 2;
       end 
       else if ((net_st == POOL_3))
       begin
         x_map_cnt_3 <= x_map_cnt_3;
       end 
       else 
       begin
         x_map_cnt_3 <= 0; 
       end 
    end 
    
    always @(posedge clk or posedge rst)
    begin
       if (rst)
       begin 
         y_map_cnt_3 <= 0;
         pool_num_ack_3 <= 0;
       end
       else if (y_map_cnt_3 == POOL_3_V - POOL_LAYER_3_V && (pool_w_ack_3) && (net_st == POOL_3))
       begin
         y_map_cnt_3 <= 0;
         pool_num_ack_3 <= 1;
       end 
       else if (pool_w_ack_3 && (net_st == POOL_3) && x_map_cnt_3 == POOL_3_H - POOL_LAYER_3_H) 
       begin 
         y_map_cnt_3 <= y_map_cnt_3 + 2;
         pool_num_ack_3 <= 0;
       end 
       else if ((net_st == POOL_3))
       begin
         y_map_cnt_3 <= y_map_cnt_3;
         pool_num_ack_3 <= 0;
       end 
       else 
       begin
         y_map_cnt_3 <= 0; 
         pool_num_ack_3 <= 0;
       end 
    end 
    
    /////////////////////////////池化计数器////////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  num_pool_3 <= 0;
      else if (net_st == POOL_3 && (num_pool_3 == POOL_LAYER_3_NUM - 1) && pool_num_ack_3) num_pool_3 <= 0;
      else if (net_st == POOL_3 && pool_num_ack_3) num_pool_3 <= num_pool_3 + 1;
      else if (net_st == POOL_3) num_pool_3 <= num_pool_3;
      else num_pool_3 <= 0;
    end 
    
    ////////////////////////////全连接卷积层1/////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) fc_cnt_1 <= 0;
       else if (net_st == FC_1 && fc_cnt_1 == FC_1_WIDTH - 1) fc_cnt_1 <= 0;
       else if (net_st == FC_1) fc_cnt_1 <= fc_cnt_1 + 1;
       else fc_cnt_1 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) fc_layer_cnt_1 <= 0;
      else if (net_st == FC_1 && fc_layer_cnt_1 == FC_1_DEEPTH ) fc_layer_cnt_1 <= 0;
      else if (net_st == FC_1 && (fc_cnt_1 == FC_1_WIDTH - 1)) fc_layer_cnt_1 <= fc_layer_cnt_1 + 1;
      else if (net_st == FC_1) fc_layer_cnt_1 <= fc_layer_cnt_1;
      else fc_layer_cnt_1 <= 0;
    end 
    
    ///////////////////////////全链接卷积层2///////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) fc_cnt_2 <= 0;
       else if (net_st == FC_2 && fc_cnt_2 == FC_2_WIDTH - 1) fc_cnt_2 <= 0;
       else if (net_st == FC_2) fc_cnt_2 <= fc_cnt_2 + 1;
       else fc_cnt_2 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) fc_layer_cnt_2 <= 0;
      else if (net_st == FC_2 && fc_layer_cnt_2 == FC_2_DEEPTH ) fc_layer_cnt_2 <= 0;
      else if (net_st == FC_2 && (fc_cnt_2 == FC_2_WIDTH - 1)) fc_layer_cnt_2 <= fc_layer_cnt_2 + 1;
      else if (net_st == FC_2) fc_layer_cnt_2 <= fc_layer_cnt_2;
      else fc_layer_cnt_2 <= 0;
    end 
    
    /////////////////////////全链接卷积层3///////////////////////////////////
    always @(posedge clk or posedge rst)
    begin
       if (rst) fc_cnt_3 <= 0;
       else if (net_st == FC_3 && fc_cnt_3 == FC_3_WIDTH - 1) fc_cnt_3 <= 0;
       else if (net_st == FC_3) fc_cnt_3 <= fc_cnt_3 + 1;
       else fc_cnt_3 <= 0;
    end 
    
    always @(posedge clk or posedge rst)
    begin
      if (rst) fc_layer_cnt_3 <= 0;
      else if (net_st == FC_3 && fc_layer_cnt_3 == FC_3_DEEPTH) fc_layer_cnt_3 <= 0;
      else if (net_st == FC_3 && (fc_cnt_3 == FC_3_WIDTH - 1)) fc_layer_cnt_3 <= fc_layer_cnt_3 + 1;
      else if (net_st == FC_3) fc_layer_cnt_3 <= fc_layer_cnt_3;
      else fc_layer_cnt_3 <= 0;
    end 
    
    /////////////////最终输出判断/////////////////////////
    always @(posedge clk or posedge rst)
    begin
      if (rst)  sw <= 0;
      else if (classify[2] > classify[1]) 
      begin
        if (classify[1] > classify[0])  
        sw <= 3'b101;
        else
        begin 
          if (classify[2] > classify[0]) sw <= 3'b101;
          else sw <= 3'b110;
        end 
      end
      else 
      begin 
        if (classify[1] > classify[0]) sw <= 3'b011;
        else 
        begin
           sw <= 3'b110; 
        end 
      end 
    end 
    
    
    
    
    /////////////////读写地址控制/////////////////////
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        addra_1 = 0;
        addra_2 = 0;
        addra_3 = 0;   
      end
      CONV_1: begin 
        addra_1 = x_wr_conv_addr_1;
        addra_2 = x_wr_conv_addr_1;
        addra_3 = x_wr_conv_addr_1;   
      end
      POOL_1: 
      begin
        addra_1 = x_wr_pool_addr_1;
        addra_2 = x_wr_pool_addr_1;
        addra_3 = x_wr_pool_addr_1;   
      end 
      CONV_2: 
      begin 
        addra_1 = x_wr_conv_addr_2;
        addra_2 = x_wr_conv_addr_2;
        addra_3 = x_wr_conv_addr_2;   
      end 
      POOL_2: 
      begin 
        addra_1 = x_wr_pool_addr_2;
        addra_2 = x_wr_pool_addr_2;
        addra_3 = x_wr_pool_addr_2;   
      end
      CONV_3: 
      begin 
        addra_1 = x_wr_conv_addr_3;
        addra_2 = x_wr_conv_addr_3;
        addra_3 = x_wr_conv_addr_3;   
      end
      CONV_4: 
      begin 
        addra_1 = x_wr_conv_addr_4;
        addra_2 = x_wr_conv_addr_4;
        addra_3 = x_wr_conv_addr_4;   
      end
      CONV_5: 
      begin 
        addra_1 = x_wr_conv_addr_5;
        addra_2 = x_wr_conv_addr_5;
        addra_3 = x_wr_conv_addr_5;  
      end
      POOL_3: 
      begin 
        addra_1 = x_wr_pool_addr_3;
        addra_2 = x_wr_pool_addr_3;
        addra_3 = x_wr_pool_addr_3;   
      end
      FC_1:
      begin   
        addra_1 = x_wr_fc_addr_1;
        addra_2 = x_wr_fc_addr_1;
        addra_3 = x_wr_fc_addr_1;   
      end
      FC_2: 
      begin 
        addra_1 = x_wr_fc_addr_2;
        addra_2 = x_wr_fc_addr_2;
        addra_3 = x_wr_fc_addr_2;   
      end
      default:
      begin
        addra_1 = 0;
        addra_2 = 0;
        addra_3 = 0;   
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        addrb_1 = 0;
        addrb_2 = 0;
        addrb_3 = 0;   
      end
      CONV_1: begin 
        addrb_1 = x_rd_conv_addr_1;
        addrb_2 = x_rd_conv_addr_1;
        addrb_3 = x_rd_conv_addr_1;   
      end
      POOL_1: 
      begin
        addrb_1 = x_rd_pool_addr_1;
        addrb_2 = x_rd_pool_addr_1;
        addrb_3 = x_rd_pool_addr_1;   
      end 
      CONV_2: 
      begin 
        addrb_1 = x_rd_conv_addr_2;
        addrb_2 = x_rd_conv_addr_2;
        addrb_3 = x_rd_conv_addr_2;   
      end 
      POOL_2: 
      begin 
        addrb_1 = x_rd_pool_addr_2;
        addrb_2 = x_rd_pool_addr_2;
        addrb_3 = x_rd_pool_addr_2;   
      end
      CONV_3: 
      begin 
        addrb_1 = x_rd_conv_addr_3;
        addrb_2 = x_rd_conv_addr_3;
        addrb_3 = x_rd_conv_addr_3;   
      end
      CONV_4: 
      begin 
        addrb_1 = x_rd_conv_addr_4;
        addrb_2 = x_rd_conv_addr_4;
        addrb_3 = x_rd_conv_addr_4;   
      end
      CONV_5: 
      begin 
        addrb_1 = x_rd_conv_addr_5;
        addrb_2 = x_rd_conv_addr_5;
        addrb_3 = x_rd_conv_addr_5;  
      end
      POOL_3: 
      begin 
        addrb_1 = x_rd_pool_addr_3;
        addrb_2 = x_rd_pool_addr_3;
        addrb_3 = x_rd_pool_addr_3;   
      end
      FC_1:
      begin   
       if  (fc_cnt_1 >= FC_1_WIDTH * 2 / 3) 
       begin 
         addrb_1 = 0;
         addrb_2 = 0;
         addrb_3 = x_rd_fc_addr_1 - FC_1_WIDTH * 2 / 3;
       end
       else if (fc_cnt_1 >= FC_1_WIDTH / 3) 
       begin 
         addrb_1 = 0;
         addrb_2 = x_rd_fc_addr_1 - FC_1_WIDTH / 3;
         addrb_3 = 0;
       end
       else 
       begin 
         addrb_1 = x_rd_fc_addr_1;
         addrb_2 = 0;
         addrb_3 = 0;
       end
      end
      FC_2: 
      begin 
        addrb_1 = x_rd_fc_addr_2;
        addrb_2 = x_rd_fc_addr_2;
        addrb_3 = x_rd_fc_addr_2;   
      end
      FC_3:
      begin
        addrb_1 = x_rd_fc_addr_3;
        addrb_2 = x_rd_fc_addr_3;
        addrb_3 = x_rd_fc_addr_3; 
      end 
      default:
      begin
        addrb_1 = 0;
        addrb_2 = 0;
        addrb_3 = 0;   
      end
      endcase
    end
    
    ///////////////////
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        dina_1 = 0;
        dina_2 = 0;
        dina_3 = 0;   
      end
      CONV_1: begin 
        dina_1 = ReLU_o_layer_R_1;
        dina_2 = ReLU_o_layer_G_1;
        dina_3 = ReLU_o_layer_B_1; 
      end
      POOL_1: 
      begin
        dina_1 = Pool_o_layer_R_1;
        dina_2 = Pool_o_layer_G_1;
        dina_3 = Pool_o_layer_B_1; 
      end 
      CONV_2: 
      begin 
        dina_1 = ReLU_o_layer_R_2;
        dina_2 = ReLU_o_layer_G_2;
        dina_3 = ReLU_o_layer_B_2; 
      end 
      POOL_2: 
      begin 
        dina_1 = Pool_o_layer_R_2;
        dina_2 = Pool_o_layer_G_2;
        dina_3 = Pool_o_layer_B_2;   
      end
      CONV_3: 
      begin 
        dina_1 = ReLU_o_layer_R_3;
        dina_2 = ReLU_o_layer_G_3;
        dina_3 = ReLU_o_layer_B_3; 
      end
      CONV_4: 
      begin 
        dina_1 = ReLU_o_layer_R_4;
        dina_2 = ReLU_o_layer_G_4;
        dina_3 = ReLU_o_layer_B_4;   
      end
      CONV_5: 
      begin 
        dina_1 = ReLU_o_layer_R_5;
        dina_2 = ReLU_o_layer_G_5;
        dina_3 = ReLU_o_layer_B_5; 
      end
      POOL_3: 
      begin 
        dina_1 = Pool_o_layer_R_3;
        dina_2 = Pool_o_layer_G_3;
        dina_3 = Pool_o_layer_B_3;   
      end
      FC_1:
      begin   
        dina_1 = Fc_o_layer_1;   
        dina_2 = Fc_o_layer_1;
        dina_3 = Fc_o_layer_1;     
      end
      FC_2: 
      begin 
        dina_1 = Fc_o_layer_2;
        dina_2 = Fc_o_layer_2;
        dina_3 = Fc_o_layer_2;   
      end
      default:
      begin
        dina_1 = 0;
        dina_2 = 0;
        dina_3 = 0;   
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        wea_1 = 0;
        wea_2 = 0;
        wea_3 = 0;   
      end
     FC_3:
     begin
        wea_1 = 0;
        wea_2 = 0;
        wea_3 = 0;  
     end 
     STOP:
     begin
        wea_1 = 0;
        wea_2 = 0;
        wea_3 = 0;   
     end 
     default:
     begin
        wea_1 = 1;
        wea_2 = 1;
        wea_3 = 1;   
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        conv_i_layer_R_1 = 0;
        conv_i_layer_G_1 = 0;
        conv_i_layer_B_1 = 0;
      end
      CONV_1: begin 
        conv_i_layer_R_1 = doutb_1;
        conv_i_layer_G_1 = doutb_2;
        conv_i_layer_B_1 = doutb_3;
      end
      default:
      begin
        conv_i_layer_R_1 = 0;
        conv_i_layer_G_1 = 0;
        conv_i_layer_B_1 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        conv_i_layer_R_2 = 0;
        conv_i_layer_G_2 = 0;
        conv_i_layer_B_2 = 0;
      end
      CONV_2: begin 
        conv_i_layer_R_2 = doutb_1;
        conv_i_layer_G_2 = doutb_2;
        conv_i_layer_B_2 = doutb_3;
      end
      default:
      begin
        conv_i_layer_R_2 = 0;
        conv_i_layer_G_2 = 0;
        conv_i_layer_B_2 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        conv_i_layer_R_3 = 0;
        conv_i_layer_G_3 = 0;
        conv_i_layer_B_3 = 0;
      end
      CONV_3: begin 
        conv_i_layer_R_3 = doutb_1;
        conv_i_layer_G_3 = doutb_2;
        conv_i_layer_B_3 = doutb_3;
      end
      default:
      begin
        conv_i_layer_R_3 = 0;
        conv_i_layer_G_3 = 0;
        conv_i_layer_B_3 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        conv_i_layer_R_4 = 0;
        conv_i_layer_G_4 = 0;
        conv_i_layer_B_4 = 0;
      end
      CONV_4: begin 
        conv_i_layer_R_4 = doutb_1;
        conv_i_layer_G_4 = doutb_2;
        conv_i_layer_B_4 = doutb_3;
      end
      default:
      begin
        conv_i_layer_R_4 = 0;
        conv_i_layer_G_4 = 0;
        conv_i_layer_B_4 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        conv_i_layer_R_5 = 0;
        conv_i_layer_G_5 = 0;
        conv_i_layer_B_5 = 0;
      end
      CONV_5: begin 
        conv_i_layer_R_5 = doutb_1;
        conv_i_layer_G_5 = doutb_2;
        conv_i_layer_B_5 = doutb_3;
      end
      default:
      begin
        conv_i_layer_R_5 = 0;
        conv_i_layer_G_5 = 0;
        conv_i_layer_B_5 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        Pool_i_layer_R_1 = 0;
        Pool_i_layer_G_1 = 0;
        Pool_i_layer_B_1 = 0;
      end
      POOL_1: begin 
        Pool_i_layer_R_1 = doutb_1;
        Pool_i_layer_G_1 = doutb_2;
        Pool_i_layer_B_1 = doutb_3;
      end
      default:
      begin
        Pool_i_layer_R_1 = 0;
        Pool_i_layer_G_1 = 0;
        Pool_i_layer_B_1 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        Pool_i_layer_R_2 = 0;
        Pool_i_layer_G_2 = 0;
        Pool_i_layer_B_2 = 0;
      end
      POOL_2: begin 
        Pool_i_layer_R_2 = doutb_1;
        Pool_i_layer_G_2 = doutb_2;
        Pool_i_layer_B_2 = doutb_3;
      end
      default:
      begin
        Pool_i_layer_R_2 = 0;
        Pool_i_layer_G_2 = 0;
        Pool_i_layer_B_2 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        Pool_i_layer_R_3 = 0;
        Pool_i_layer_G_3 = 0;
        Pool_i_layer_B_3 = 0;
      end
      POOL_3: begin 
        Pool_i_layer_R_3 = doutb_1;
        Pool_i_layer_G_3 = doutb_2;
        Pool_i_layer_B_3 = doutb_3;
      end
      default:
      begin
        Pool_i_layer_R_3 = 0;
        Pool_i_layer_G_3 = 0;
        Pool_i_layer_B_3 = 0; 
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        fc_i_layer_1 = 0;
      end
      FC_1: 
      begin
        if  (fc_cnt_1 >= FC_1_WIDTH * 2 / 3) fc_i_layer_1 = doutb_3;
        else if (fc_cnt_1 >= FC_1_WIDTH / 3) fc_i_layer_1 = doutb_2;
        else fc_i_layer_1 = doutb_1;
      end
      default:
      begin
       fc_i_layer_1 = 0;
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        fc_i_layer_2 = 0;
      end
      FC_2: 
      begin
       fc_i_layer_2 = doutb_1;
      end
      default:
      begin
       fc_i_layer_2 = 0;
      end
      endcase
    end
    
    always @(*)
    begin
      case(net_st)
      IDLE: begin  
        fc_i_layer_3 = 0;
      end
      FC_2: 
      begin
       fc_i_layer_3 = doutb_1;
      end
      default:
      begin
       fc_i_layer_3 = 0;
      end
      endcase
    end
    
    ///////////////例化BRAM///////////////////////////
    blk_mem_gen_6 U0(
    .clka   (clk    ),
    .addra  (addra_1),
    .dina   (dina_1       ),
    .wea    (wea_1       ),
    .clkb   (clk    ),
    .addrb  (addrb_1       ),
    .doutb  (doutb_1       )
    );
    
    blk_mem_gen_7 U1(
    .clka   (clk    ),
    .addra  (addra_2),
    .dina   (dina_2 ),
    .wea    (wea_2       ),
    .clkb   (clk    ),
    .addrb  (addrb_2       ),
    .doutb  (doutb_2       )
    );
    
    blk_mem_gen_8 U2(
    .clka   (clk    ),
    .addra  (addra_3),
    .dina   (dina_3 ),
    .wea    (wea_3       ),
    .clkb   (clk    ),
    .addrb  (addrb_3       ),
    .doutb  (doutb_3       )
    );
    
    conv_r_mem_gen_1 U3(
    .clka   (clk    ),
    .addra  (0      ),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_1 ),
    .doutb  (conv_weight_layer_R_1)
    );
    
    conv_r_mem_gen_2 U4(
    .clka   (clk    ),
    .addra  (0      ),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_2 ),
    .doutb  (conv_weight_layer_R_2)
    );
    
    conv_r_mem_gen_3 U5(
    .clka   (clk    ),
    .addra  (0      ),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_3 ),
    .doutb  (conv_weight_layer_R_3)
    );
    
    conv_r_mem_gen_4 U6(
    .clka   (clk    ),
    .addra  (0      ),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_4 ),
    .doutb  (conv_weight_layer_R_4)
    );
    
    conv_r_mem_gen_5 U7(
    .clka   (clk    ),
    .addra  (0      ),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_5 ),
    .doutb  (conv_weight_layer_R_5)
    );
    
    conv_g_mem_gen_1 U8(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_1 ),
    .doutb  (conv_weight_layer_G_1)
    );
    
    conv_g_mem_gen_2 U9(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_2 ),
    .doutb  (conv_weight_layer_G_2)
    );
    
    conv_g_mem_gen_3 U10(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_3 ),
    .doutb  (conv_weight_layer_G_3)
    );
    
    conv_g_mem_gen_4 U11(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_4 ),
    .doutb  (conv_weight_layer_G_4)
    );
    
    conv_g_mem_gen_5 U12(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_5 ),
    .doutb  (conv_weight_layer_G_5)
    );
    
    conv_b_mem_gen_1 U13(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_1 ),
    .doutb  (conv_weight_layer_B_1)
    );
    
    conv_b_mem_gen_2 U14(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_2 ),
    .doutb  (conv_weight_layer_B_2)
    );
    
    conv_b_mem_gen_3 U15(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_3 ),
    .doutb  (conv_weight_layer_B_3)
    );
    
    conv_b_mem_gen_4 U16(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_4 ),
    .doutb  (conv_weight_layer_B_4)
    );
    
    conv_b_mem_gen_5 U17(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_w_addr_5 ),
    .doutb  (conv_weight_layer_B_5)
    );
    
    conv_bi_mem_gen_1 U18(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_b_addr_1 ),
    .doutb  (conv_bias_layer_1)
    );
    
    conv_bi_mem_gen_2 U19(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_b_addr_2 ),
    .doutb  (conv_bias_layer_2)
    );
    
    conv_bi_mem_gen_3 U20(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_b_addr_3 ),
    .doutb  (conv_bias_layer_3)
    );
    
    conv_bi_mem_gen_4 U21(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_b_addr_4 ),
    .doutb  (conv_bias_layer_4)
    );
    
    conv_bi_mem_gen_5 U22(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_conv_b_addr_5 ),
    .doutb  (conv_bias_layer_5)
    );
    
    fc_w_mem_gen_1 U23(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_w_fc_addr_1 ),
    .doutb  (fc_weight_layer_1)
    );
    
    fc_w_mem_gen_2 U24(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_w_fc_addr_2 ),
    .doutb  (fc_weight_layer_2)
    );
    
    fc_w_mem_gen_3 U25(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_w_fc_addr_3 ),
    .doutb  (fc_weight_layer_3)
    );
    
     fc_bi_mem_gen_1 U26(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_b_fc_addr_1 ),
    .doutb  (fc_bias_layer_1)
    );
    
    fc_bi_mem_gen_2 U27(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_b_fc_addr_2 ),
    .doutb  (fc_bias_layer_2)
    );
    
    fc_bi_mem_gen_3 U28(
    .clka   (clk    ),
    .addra  (0),
    .dina   (0      ),
    .wea    (0      ),
    .clkb   (clk    ),
    .addrb  (x_b_fc_addr_3 ),
    .doutb  (fc_bias_layer_3)
    );
    
    
endmodule