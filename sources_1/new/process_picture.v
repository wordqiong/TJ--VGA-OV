`timescale 1ns / 1ps

module process_picture(
input clk,
input [11:0] in_rgb,//输入的rgb数据
output reg[11:0] out_rgb//输出的处理过的rgb数据
    );
reg [7:0]mid1;
reg [7:0]red_mid,green_mid,blue_mid,red_mid2,green_mid2,blue_mid2;
wire [11:0]mid2;

 
 always @ (*)
    begin
        red_mid={in_rgb[11:8],4'b0000};
        green_mid={in_rgb[7:4],4'b0000};
        blue_mid={in_rgb[3:0],4'b0000};
        red_mid2={in_rgb[11:8],4'b0000};
        green_mid2={in_rgb[7:4],4'b0000};
        blue_mid2={in_rgb[3:0],4'b0000};

        mid1=(red_mid/3+green_mid/2+blue_mid/8);
         red_mid=mid1;
            green_mid=mid1;
            blue_mid=mid1;

          out_rgb[11:8]=red_mid[7:4];
        out_rgb[7:4]=green_mid[7:4];
        out_rgb[3:0]=blue_mid[7:4];
    end


endmodule
