`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/23 16:07:47
// Design Name: 
// Module Name: IM_drive
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


module IM_driver(
input           video_clk,
input           rst,
input           video_ack,
input [7:0]     D_in,
input [2:0]     sw,
input           Done,
input           last,
input           next,

output [7:0]    D_out_r,
output [7:0]    D_out_g,
output [7:0]    D_out_b
);

    parameter H_IM = 227;
    parameter V_IM = 227;
    parameter H_CHAR_IM = 183;
    parameter V_CHAR_IM = 38;
    parameter H_VIDEO = 1920;
    parameter V_VIDEO = 1080;
    
    localparam IDLE   = 3;
    localparam CANCER = 2;
    localparam BOUND  = 1;
    localparam NORMAL = 0;
    
    //////////////////图像寄存器///////////////////
    reg  [15:0] addrb_reg = 0;
    reg  [12:0] addrb_char_reg = 0;
    
    
    reg  [15:0] addra_reg = 0;
    reg [10:0] x_cnt = 0,y_cnt = 0;
    
    ///////////////读/写地址////////////////////
    wire  [15:0] addra;
    wire  [15:0] addrb_im;
    wire  [12:0] addrb_char;
    
    /////////////图片BRAM输出信号/////////////
    wire  [7:0]  doutb_im_r;
    wire  [7:0]  doutb_im_b;
    wire  [7:0]  doutb_im_g;
    
    wire  [7:0]  doutb_im_r_1;
    wire  [7:0]  doutb_im_b_1;
    wire  [7:0]  doutb_im_g_1;
    
    wire [7:0]   doutb_im_r_2,doutb_im_g_2,doutb_im_b_2;
    
    ////////////字符输出BRAM信号///////////
    wire  [7:0]  doutb_char_cancer;
    wire  [7:0]  doutb_char_bound;
    wire  [7:0]  doutb_char_norm;
    
    reg   [7:0]  doutb_im_reg_r;
    reg   [7:0]  doutb_im_reg_g;
    reg   [7:0]  doutb_im_reg_b;

    reg [1:0] char_st = 0;
    reg [1:0] im_st   = 0;
    
    wire next_button;
    wire last_button;
    ///////////////////////////////////////
    assign addra = addra_reg;
    assign addrb_im = addrb_reg;
    assign addrb_char = addrb_char_reg;
    
    ///////////输出信号控制///////////////////
    assign D_out_r = doutb_im_reg_r;
    assign D_out_g = doutb_im_reg_g;
    assign D_out_b = doutb_im_reg_b;

  
  ///////////输出字符控制///////////////
    always @(posedge video_clk or posedge rst)
    begin
       if (rst) char_st <= 0;
       else if (!Done)  char_st  <= IDLE;
       else if (!sw[2]) char_st <= CANCER;
       else if (!sw[1]) char_st <= BOUND;
       else if (!sw[0]) char_st <= NORMAL;
       else char_st <= char_st;
    end 
    
    ////////输出图像控制//////////////////
     always @(negedge next_button or negedge last_button)
     begin
        if (last_button) im_st <= 0;
        else if (im_st == 2) im_st <= 0;
        else im_st <= im_st + 1;
     end 
  
       
    always @(posedge video_clk or posedge rst)
    begin
       if (rst) addrb_reg <= 0;
       else if (addrb_reg == (H_IM * V_IM - 1)) addrb_reg <= 0;
       else if (video_ack && (x_cnt < H_IM) && (y_cnt < V_IM)) addrb_reg <= addrb_reg + 1;
       else addrb_reg <= addrb_reg;
    end 
    
    always @(posedge video_clk or posedge rst)
    begin
       if (rst) addrb_char_reg <= 0;
       else if (addrb_char_reg == ((H_CHAR_IM * V_CHAR_IM) - 1)) addrb_char_reg <= 0;
       else if (video_ack && (x_cnt < H_CHAR_IM) && (y_cnt < V_IM + V_CHAR_IM) && (y_cnt >= V_IM)) addrb_char_reg <= addrb_char_reg + 1;
       else addrb_char_reg <= addrb_char_reg;
    end 
    

////////////////////////X,Y计数//////////////////////////////////////////       
    always @(posedge video_clk or posedge rst)
    begin
      if (rst) x_cnt <= 0;
      else if ((x_cnt == H_VIDEO - 1)) x_cnt <= 0;
      else if (video_ack) x_cnt <= x_cnt + 1'b1; 
      else x_cnt <= x_cnt;
    end 
    
    always @(posedge video_clk or posedge rst)
    begin
      if (rst) y_cnt <= 0;
      else if ((x_cnt == H_VIDEO - 1) && (y_cnt == V_VIDEO - 1)) y_cnt <= 0;
      else if (video_ack && x_cnt == H_VIDEO - 1) y_cnt <= y_cnt + 1'b1; 
      else y_cnt <= y_cnt;
    end 
  
 
  ///////////////打一拍输出改善时序问题//////////////
   always @(*)
    begin
      if (x_cnt <= (H_IM - 1) && (y_cnt <= (V_IM - 1))) 
      begin 
      case(im_st)
      0:
      begin 
        doutb_im_reg_r = doutb_im_r;
        doutb_im_reg_g = doutb_im_g;
        doutb_im_reg_b = doutb_im_b;
      end
      1:
      begin
        doutb_im_reg_r = doutb_im_r_1;
        doutb_im_reg_g = doutb_im_g_1;
        doutb_im_reg_b = doutb_im_b_1;
      end 
      default:
      begin
        doutb_im_reg_r = doutb_im_r_2;
        doutb_im_reg_g = doutb_im_g_2;
        doutb_im_reg_b = doutb_im_b_2;
      end 
      endcase
      end
      else if ((x_cnt < H_CHAR_IM) && (y_cnt < V_CHAR_IM + V_IM))
      begin
        case(char_st)
        IDLE:
        begin
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
        end 
        CANCER:
        begin
           case(im_st)
           0:
           begin 
           doutb_im_reg_r = ~(doutb_char_cancer[7:0]);
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
           end
           1:
           begin 
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = ~(doutb_char_bound[7:0]);
           end 
           default:
           begin 
           doutb_im_reg_r = ~(doutb_char_cancer[7:0]);
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
           end 
           endcase
        end 
        BOUND:
        begin
           case(im_st)
           0:
           begin 
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = ~(doutb_char_bound[7:0]);
           end
           1:
           begin 
           doutb_im_reg_r = ~(doutb_char_cancer[7:0]);
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
           end 
           default:
           begin 
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = ~(doutb_char_norm[7:0]);
           end 
           endcase
        end 
        NORMAL:
        begin
           case(im_st)
           0:
           begin 
           doutb_im_reg_r = 0;
           doutb_im_reg_g = ~(doutb_char_norm[7:0]);
           doutb_im_reg_b = 0;
           end
           1:
           begin 
           doutb_im_reg_r = ~(doutb_char_cancer[7:0]);
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
           end 
           default:
           begin 
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = ~(doutb_char_bound[7:0]);
           end 
           endcase
        end 
        default:
        begin
           doutb_im_reg_r = 0;
           doutb_im_reg_g = 0;
           doutb_im_reg_b = 0;
        end 
        endcase  
      end 
      else 
      begin 
        doutb_im_reg_r = 0;
        doutb_im_reg_g = 0;
        doutb_im_reg_b = 0;
      end
    end 
   
  ///////////RED_Pixels////////////////////
    blk_mem_gen_0 U0(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_r )
    );
    
  ///////////GREEN_Pixels////////////////////
    blk_mem_gen_1 U1(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_g )
    );
    
  ///////////BLUE_Pixels////////////////////
    
    blk_mem_gen_2 U2(
    .clka       (video_clk),
    .addra      (addra    ),
    .dina       (D_in     ),
    .wea        (0        ),
    .clkb       (video_clk),
    .addrb      (addrb_im),
    .doutb      (doutb_im_b)
    );
    
 ///////////CHAR_PIXELS/////////////////   
    blk_mem_gen_3 U3(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_char ),
    .doutb      (doutb_char_cancer)
    );
    
    blk_mem_gen_4 U4(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0        ),
    .clkb       (video_clk  ),
    .addrb      (addrb_char ),
    .doutb      (doutb_char_bound)
    );
    
    blk_mem_gen_5 U5(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_char ),
    .doutb      (doutb_char_norm)
    );
    
    blk_mem_gen_9 U6(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_r_1 )
    );
    
    blk_mem_gen_10 U7(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_g_1 )
    );
    
    blk_mem_gen_11 U8(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_b_1 )
    );
    
    ax_debounce debounce_m0(
    .clk             (video_clk     ),
    .rst             (1'b0          ),
    .button_in       (next          ),
    .button_posedge  (              ),
    .button_negedge  (next_button   ),
    .button_out      (              )
    );
    
    ax_debounce debounce_m1(
    .clk             (video_clk     ),
    .rst             (1'b0          ),
    .button_in       (last          ),
    .button_posedge  (              ),
    .button_negedge  (last_button   ),
    .button_out      (              )
    );
    
    blk_mem_gen_12 U9(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_r_2)
    );
    
    blk_mem_gen_13 U10(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_g_2)
    );
    
    blk_mem_gen_14 U11(
    .clka       (video_clk  ),
    .addra      (addra      ),
    .dina       (D_in       ),
    .wea        (0          ),
    .clkb       (video_clk  ),
    .addrb      (addrb_im   ),
    .doutb      (doutb_im_b_2)
    );
    
endmodule
