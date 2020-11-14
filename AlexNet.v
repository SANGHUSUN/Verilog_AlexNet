`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:55:40
// Design Name: 
// Module Name: AlexNet
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


module AlexNet(
input clk,rst,en,
input next,


output Done,
output [2:0]sw
    );
    
    
    wire [15:0]Weight_R_1,Weight_G_1,Weight_B_1;
    wire [15:0]Weight_R_2,Weight_G_2,Weight_B_2;
    wire [15:0]Weight_R_3,Weight_G_3,Weight_B_3;
    wire [15:0]Weight_R_4,Weight_G_4,Weight_B_4;
    wire [15:0]Weight_R_5,Weight_G_5,Weight_B_5;

    wire [15:0]Bias_1;
    wire [15:0]Bias_2;
    wire [15:0]Bias_3;
    wire [15:0]Bias_4;
    wire [15:0]Bias_5;

    wire conv_1_ack,conv_2_ack,conv_3_ack,conv_4_ack,conv_5_ack;
    wire relu_1_ack,relu_2_ack,relu_3_ack,relu_4_ack,relu_5_ack,relu_6_ack,relu_7_ack,relu_8_ack;
    wire pool_1_ack,pool_2_ack,pool_3_ack;
    wire fc_1_ack,fc_2_ack,fc_3_ack;
   
    
    wire [31:0]Conv_out_R_1,Conv_out_G_1,Conv_out_B_1;
    wire [31:0]Conv_out_R_2,Conv_out_G_2,Conv_out_B_2;
    wire [31:0]Conv_out_R_3,Conv_out_G_3,Conv_out_B_3;
    wire [31:0]Conv_out_R_4,Conv_out_G_4,Conv_out_B_4;
    wire [31:0]Conv_out_R_5,Conv_out_G_5,Conv_out_B_5;
    
    //////////////////////Relu signals//////////////////////
    wire [15:0]ReLU_o_R_1,ReLU_o_G_1,ReLU_o_B_1;
    wire [15:0]ReLU_o_R_2,ReLU_o_G_2,ReLU_o_B_2;
    wire [15:0]ReLU_o_R_3,ReLU_o_G_3,ReLU_o_B_3;
    wire [15:0]ReLU_o_R_4,ReLU_o_G_4,ReLU_o_B_4;
    wire [15:0]ReLU_o_R_5,ReLU_o_G_5,ReLU_o_B_5;
    wire [15:0]ReLU_o_R_6,ReLU_o_G_6,ReLU_o_B_6;
    wire [15:0]ReLU_o_R_7,ReLU_o_G_7,ReLU_o_B_7;
    wire [15:0]ReLU_o_R_8,ReLU_o_G_8,ReLU_o_B_8;
    
    wire [15:0]Conv_in_R_1,Conv_in_G_1,Conv_in_B_1;
    wire [15:0]Conv_in_R_2,Conv_in_G_2,Conv_in_B_2;
    wire [15:0]Conv_in_R_3,Conv_in_G_3,Conv_in_B_3;
    wire [15:0]Conv_in_R_4,Conv_in_G_4,Conv_in_B_4;
    wire [15:0]Conv_in_R_5,Conv_in_G_5,Conv_in_B_5;
    
   //////////////Enable //////////////////
    wire conv_1_en,conv_2_en,conv_3_en,conv_4_en,conv_5_en,pool_1_en,pool_2_en,pool_3_en,fc_1_en,fc_2_en,fc_3_en;

    
    
   //////////////////Pooling signal////////////////////    
    
    wire [15:0]Pool_in_R_1,Pool_in_G_1,Pool_in_B_1;
    wire [15:0]Pool_in_R_2,Pool_in_G_2,Pool_in_B_2;
    wire [15:0]Pool_in_R_3,Pool_in_G_3,Pool_in_B_3;

    wire [15:0]Pool_out_R_1,Pool_out_G_1,Pool_out_B_1;
    wire [15:0]Pool_out_R_2,Pool_out_G_2,Pool_out_B_2;
    wire [15:0]Pool_out_R_3,Pool_out_G_3,Pool_out_B_3;

  ////////////////Fc_signal////////////////////////////
    wire [15:0]Fc_Weight_1,Fc_Weight_2,Fc_Weight_3;
    wire [15:0]Fc_Bias_1,Fc_Bias_2,Fc_Bias_3;
    wire [15:0]Fc_D_in_1,Fc_D_in_2,Fc_D_in_3;
    wire [31:0]fc_out_1,fc_out_2,fc_out_3;
   

   Alexnet_dirver Alexnet_m0(
   .clk(clk),.rst(rst),.en(en),
   .next(next),
   
   .ReLU_o_layer_R_1(ReLU_o_R_1),.ReLU_o_layer_G_1(ReLU_o_G_1),.ReLU_o_layer_B_1(ReLU_o_B_1),
   .ReLU_o_layer_R_2(ReLU_o_R_2),.ReLU_o_layer_G_2(ReLU_o_G_2),.ReLU_o_layer_B_2(ReLU_o_B_2),
   .ReLU_o_layer_R_3(ReLU_o_R_3),.ReLU_o_layer_G_3(ReLU_o_G_3),.ReLU_o_layer_B_3(ReLU_o_B_3),
   .ReLU_o_layer_R_4(ReLU_o_R_4),.ReLU_o_layer_G_4(ReLU_o_G_4),.ReLU_o_layer_B_4(ReLU_o_B_4),
   .ReLU_o_layer_R_5(ReLU_o_R_5),.ReLU_o_layer_G_5(ReLU_o_G_5),.ReLU_o_layer_B_5(ReLU_o_B_5),
   .Fc_o_layer_1(ReLU_o_R_6),.Fc_o_layer_2(ReLU_o_R_6),.Fc_o_layer_3(ReLU_o_R_6),
   .Pool_o_layer_R_1(Pool_out_R_1),.Pool_o_layer_G_1(Pool_out_G_1),.Pool_o_layer_B_1(Pool_out_B_1),
   .Pool_o_layer_R_2(Pool_out_R_2),.Pool_o_layer_G_2(Pool_out_G_2),.Pool_o_layer_B_2(Pool_out_B_2),
   .Pool_o_layer_R_3(Pool_out_R_3),.Pool_o_layer_G_3(Pool_out_G_3),.Pool_o_layer_B_3(Pool_out_B_3),
   
   .relu_1_ack(relu_1_ack),.pool_1_ack(pool_1_ack),.relu_2_ack(relu_2_ack),.pool_2_ack(pool_2_ack),
   .relu_3_ack(relu_3_ack),.relu_4_ack(relu_4_ack),.relu_5_ack(relu_5_ack),.pool_3_ack(pool_3_ack),
   .relu_6_ack(relu_6_ack),.relu_7_ack(relu_7_ack),.relu_8_ack(relu_8_ack),
   
   .conv_1_en(conv_1_en),.conv_2_en(conv_2_en),.conv_3_en(conv_3_en),.conv_4_en(conv_4_en),.conv_5_en(conv_5_en),
   .pool_1_en(pool_1_en),.pool_2_en(pool_2_en),.pool_3_en(pool_3_en),.fc_1_en(fc_1_en),.fc_2_en(fc_2_en),.fc_3_en(fc_3_en),
   
   .conv_i_layer_R_1(Conv_in_R_1),.conv_i_layer_G_1(Conv_in_G_1),.conv_i_layer_B_1(Conv_in_B_1),
   .conv_weight_layer_R_1(Weight_R_1),.conv_weight_layer_G_1(Weight_G_1),.conv_weight_layer_B_1(Weight_B_1),
   .conv_bias_layer_1(Bias_1),
   
   
   .conv_i_layer_R_2(Conv_in_R_2),.conv_i_layer_G_2(Conv_in_G_2),.conv_i_layer_B_2(Conv_in_B_2),
   .conv_weight_layer_R_2(Weight_R_2),.conv_weight_layer_G_2(Weight_G_2),.conv_weight_layer_B_2(Weight_B_2),
   .conv_bias_layer_2(Bias_2),
   
   .conv_i_layer_R_3(Conv_in_R_3),.conv_i_layer_G_3(Conv_in_G_3),.conv_i_layer_B_3(Conv_in_B_3),
   .conv_weight_layer_R_3(Weight_R_3),.conv_weight_layer_G_3(Weight_G_3),.conv_weight_layer_B_3(Weight_B_3),
   .conv_bias_layer_3(Bias_3),
   
   .conv_i_layer_R_4(Conv_in_R_4),.conv_i_layer_G_4(Conv_in_G_4),.conv_i_layer_B_4(Conv_in_B_4),
   .conv_weight_layer_R_4(Weight_R_4),.conv_weight_layer_G_4(Weight_G_4),.conv_weight_layer_B_4(Weight_B_4),
   .conv_bias_layer_4(Bias_4),
   
   .conv_i_layer_R_5(Conv_in_R_5),.conv_i_layer_G_5(Conv_in_G_5),.conv_i_layer_B_5(Conv_in_B_5),
   .conv_weight_layer_R_5(Weight_R_5),.conv_weight_layer_G_5(Weight_G_5),.conv_weight_layer_B_5(Weight_B_5),
   .conv_bias_layer_5(Bias_5),
   
    .Pool_i_layer_R_1(Pool_in_R_1),.Pool_i_layer_G_1(Pool_in_G_1),.Pool_i_layer_B_1(Pool_in_B_1),
    .Pool_i_layer_R_2(Pool_in_R_2),.Pool_i_layer_G_2(Pool_in_G_2),.Pool_i_layer_B_2(Pool_in_B_2),
    .Pool_i_layer_R_3(Pool_in_R_3),.Pool_i_layer_G_3(Pool_in_G_3),.Pool_i_layer_B_3(Pool_in_B_3),

     .fc_i_layer_1(Fc_D_in_1), .fc_i_layer_2(Fc_D_in_2),.fc_i_layer_3(Fc_D_in_3),
     .fc_weight_layer_1(Fc_Weight_1),.fc_weight_layer_2(Fc_Weight_2),.fc_weight_layer_3(Fc_Weight_3),
     .fc_bias_layer_1(Fc_Bias_1),.fc_bias_layer_2(Fc_Bias_2),.fc_bias_layer_3(Fc_Bias_3),
     
     .Done (Done),
     .sw(sw)
   );


    CONV conv_layer1(
    .clk    (clk    ),
    .rst    (rst    ),
    .en     (conv_1_en   ),
    .Size   (11*11  ),
    .D_in_R (Conv_in_R_1  ),
    .D_in_G (Conv_in_G_1  ),
    .D_in_B (Conv_in_B_1  ),
    
    .Weight_R (Weight_R_1),
    .Weight_G (Weight_G_1),
    .Weight_B (Weight_B_1),

    .Bias   (Bias_1),
    
    .Conv_out_R(Conv_out_R_1),
    .Conv_out_G(Conv_out_G_1),
    .Conv_out_B(Conv_out_B_1),
    
    .conv_ack(conv_1_ack)
    );
    
    ReLU active_layer1(
    .clk(clk),
    .rst(rst),
    .ack (conv_1_ack),
    .Conv_in_R (Conv_out_R_1),
    .Conv_in_G (Conv_out_G_1),
    .Conv_in_B (Conv_out_B_1),
    
    .ReLU_o_R  (ReLU_o_R_1),
    .ReLU_o_G  (ReLU_o_G_1),
    .ReLU_o_B  (ReLU_o_B_1),
    
    .relu_ack  (relu_1_ack)
    );
    
    Pool pool_Layer1(
    .clk(clk),
    .rst(rst),
    .en (pool_1_en),
    .Size(3*3),
    
    .D_in_R(Pool_in_R_1),
    .D_in_G(Pool_in_G_1),
    .D_in_B(Pool_in_B_1),
    
    .Pool_out_R(Pool_out_R_1),
    .Pool_out_G(Pool_out_G_1),
    .Pool_out_B(Pool_out_B_1),
    
    .pool_ack(pool_1_ack)
    
    );

////////////////////////////////////////////////    
    CONV conv_layer2(
    .clk    (clk    ),
    .rst    (rst    ),
    .en     (conv_2_en   ),
    .Size   (5*5    ),
    .D_in_R (Conv_in_R_2  ),
    .D_in_G (Conv_in_G_2  ),
    .D_in_B (Conv_in_B_2  ),
    
    .Weight_R (Weight_R_2),
    .Weight_G (Weight_G_2),
    .Weight_B (Weight_B_2),

    .Bias   (Bias_2),
    
    
    .Conv_out_R(Conv_out_R_2),
    .Conv_out_G(Conv_out_G_2),
    .Conv_out_B(Conv_out_B_2),
    
    .conv_ack(conv_2_ack)
    );
    
    ReLU active_layer2(
    .clk(clk),
    .rst(rst),
    .ack (conv_2_ack),
    .Conv_in_R (Conv_out_R_2),
    .Conv_in_G (Conv_out_G_2),
    .Conv_in_B (Conv_out_B_2),
    
    .ReLU_o_R  (ReLU_o_R_2),
    .ReLU_o_G  (ReLU_o_G_2),
    .ReLU_o_B  (ReLU_o_B_2),
    
    .relu_ack  (relu_2_ack)
    );
    
    Pool pool_Layer2(
    .clk(clk),
    .rst(rst),
    .en (pool_2_en),
    .Size(3*3),
    
    .D_in_R(Pool_in_R_2),
    .D_in_G(Pool_in_G_2),
    .D_in_B(Pool_in_B_2),
    
    .Pool_out_R(Pool_out_R_2),
    .Pool_out_G(Pool_out_G_2),
    .Pool_out_B(Pool_out_B_2),
    
    .pool_ack(pool_2_ack)
    );
    
  /////////////////////////////////////////////////  
    CONV conv_layer3(
    .clk    (clk    ),
    .rst    (rst    ),
    .en     (conv_3_en   ),
    .Size   (3*3    ),
    .D_in_R (Conv_in_R_3  ),
    .D_in_G (Conv_in_G_3  ),
    .D_in_B (Conv_in_B_3  ),
    
    .Weight_R (Weight_R_3),
    .Weight_G (Weight_G_3),
    .Weight_B (Weight_B_3),

    .Bias   (Bias_3),
    
    
    .Conv_out_R(Conv_out_R_3),
    .Conv_out_G(Conv_out_G_3),
    .Conv_out_B(Conv_out_B_3),
    
    .conv_ack(conv_3_ack)
    );
    
    ReLU active_layer3(
    .clk(clk),
    .rst(rst),
    .ack (conv_3_ack),
    .Conv_in_R (Conv_out_R_3),
    .Conv_in_G (Conv_out_G_3),
    .Conv_in_B (Conv_out_B_3),
    
    .ReLU_o_R  (ReLU_o_R_3),
    .ReLU_o_G  (ReLU_o_G_3),
    .ReLU_o_B  (ReLU_o_B_3),
    
    .relu_ack  (relu_3_ack)
    );
    
    
   ///////////////////////////////////////////// 
    CONV conv_layer4(
    .clk    (clk    ),
    .rst    (rst    ),
    .en     (conv_4_en   ),
    .Size   (3*3    ),
    .D_in_R (Conv_in_R_4  ),
    .D_in_G (Conv_in_G_4  ),
    .D_in_B (Conv_in_B_4  ),
    
    .Weight_R (Weight_R_4),
    .Weight_G (Weight_G_4),
    .Weight_B (Weight_B_4),

    .Bias   (Bias_4),
    
    
    .Conv_out_R(Conv_out_R_4),
    .Conv_out_G(Conv_out_G_4),
    .Conv_out_B(Conv_out_B_4),
    
    .conv_ack(conv_4_ack)
    );
    
    ReLU active_layer4(
    .clk(clk),
    .rst(rst),
    .ack (conv_4_ack),
    .Conv_in_R (Conv_out_R_4),
    .Conv_in_G (Conv_out_G_4),
    .Conv_in_B (Conv_out_B_4),
    
    .ReLU_o_R  (ReLU_o_R_4),
    .ReLU_o_G  (ReLU_o_G_4),
    .ReLU_o_B  (ReLU_o_B_4),
    
    .relu_ack  (relu_4_ack)
    );
    
    /////////////////////////////////////////
    CONV conv_layer5(
    .clk    (clk    ),
    .rst    (rst    ),
    .en     (conv_5_en   ),
    .Size   (3*3    ),
    .D_in_R (Conv_in_R_5  ),
    .D_in_G (Conv_in_G_5  ),
    .D_in_B (Conv_in_B_5  ),
    
    .Weight_R (Weight_R_5),
    .Weight_G (Weight_G_5),
    .Weight_B (Weight_B_5),

    .Bias   (Bias_5),
    
    .Conv_out_R(Conv_out_R_5),
    .Conv_out_G(Conv_out_G_5),
    .Conv_out_B(Conv_out_B_5),
    
    .conv_ack(conv_5_ack)
   
    );
    
    ReLU active_layer5(
    .clk(clk),
    .rst(rst),
    .ack (conv_5_ack),
    .Conv_in_R (Conv_out_R_5),
    .Conv_in_G (Conv_out_G_5),
    .Conv_in_B (Conv_out_B_5),
    
    .ReLU_o_R  (ReLU_o_R_5),
    .ReLU_o_G  (ReLU_o_G_5),
    .ReLU_o_B  (ReLU_o_B_5),
    
    .relu_ack  (relu_5_ack)
    );
    
    ////////////////////////////
    Pool pool_Layer3(
    .clk(clk),
    .rst(rst),
    .en (pool_3_en),
    .Size(3*3),
    
    .D_in_R(Pool_in_R_3),
    .D_in_G(Pool_in_G_3),
    .D_in_B(Pool_in_B_3),
    
    .Pool_out_R(Pool_out_R_3),
    .Pool_out_G(Pool_out_G_3),
    .Pool_out_B(Pool_out_B_3),
    
    .pool_ack(pool_3_ack)
    );
    
    ///////////////////////////////
    Fullconnect fc_layer1(
    .clk(clk),
    .rst(rst),
    .en (fc_1_en),
    .D_in(Fc_D_in_1),
    .Weight(Fc_Weight_1),
    .Bias (Fc_Bias_1),
    .Size(14'd9126),
    
    .Fc_out(fc_out_1),
    .fc_ack(fc_1_ack)
    );
    
    ReLU active_layer6(
    .clk(clk),
    .rst(rst),
    .ack (fc_1_ack),
    .Conv_in_R (fc_out_1),
    .Conv_in_G (0),
    .Conv_in_B (0),
    
    .ReLU_o_R  (ReLU_o_R_6),
    .ReLU_o_G  (),
    .ReLU_o_B  (),
    
    .relu_ack  (relu_6_ack)
    );
    
    
    
    Fullconnect fc_layer2(
    .clk(clk),
    .rst(rst),
    .en (fc_2_en),
    .D_in(Fc_D_in_2),
    .Weight(Fc_Weight_2),
    .Bias (Fc_Bias_2),
    .Size(14'd10),
    
    .Fc_out(fc_out_2),
    .fc_ack(fc_2_ack)
    );
    
    ReLU active_layer7(
    .clk(clk),
    .rst(rst),
    .ack (fc_2_ack),
    .Conv_in_R (fc_out_2),
    .Conv_in_G (0),
    .Conv_in_B (0),
    
    .ReLU_o_R  (ReLU_o_R_7),
    .ReLU_o_G  (),
    .ReLU_o_B  (),
    
    .relu_ack  (relu_7_ack)
    );
    
    
    Fullconnect fc_layer3(
    .clk(clk),
    .rst(rst),
    .en (fc_3_en),
    .D_in(Fc_D_in_3),
    .Weight(Fc_Weight_3),
    .Bias (Fc_Bias_3),
    .Size(14'd10),
    
    .Fc_out(fc_out_3),
    .fc_ack(fc_3_ack)
    );
    
    ReLU_out active_layer8(
    .clk(clk),
    .rst(rst),
    .ack (fc_3_ack),
    .Conv_in_R (fc_out_3),
    .Conv_in_G (0),
    .Conv_in_B (0),
    
    .ReLU_o_R  (ReLU_o_R_8),
    .ReLU_o_G  (),
    .ReLU_o_B  (),
    
    .relu_ack  (relu_8_ack)
    );
    
    
    
    
endmodule
