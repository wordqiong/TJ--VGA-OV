`timescale 1ns / 1ps

//复位信号低电平有效
module linebuffer(
rst_n,clk,datain,dataout,
in_en,out_en
    );
parameter Width = 12;
parameter IMG_width = 640;
input rst_n;
input clk;
input [Width-1:0]datain;
output [Width-1:0]dataout;
input in_en;//可输入信号
output out_en;//下一级可输入

reg [9:0]cnt;//计数范围大于图像宽度总容量 为了确保当前行全部读取到
wire rd_en;//判断下一级是否可以开始

assign rd_en=((cnt==IMG_width)&&(in_en))?1'b1:1'b0;
assign out_en=rd_en;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt<=0;
    else if(in_en)
        if(cnt==IMG_width)
        cnt<= IMG_width;
        else
        cnt<=cnt+1'b1;
    else
    cnt<=cnt;
end
//FIFO中复位信号高电平有效 异步信号 同步复位
FIFO quene(
.clk(clk),
.rst(!rst_n),
.din(datain),
.dout(dataout),
.wr_en(in_en),
.rd_en(rd_en)

);
endmodule
