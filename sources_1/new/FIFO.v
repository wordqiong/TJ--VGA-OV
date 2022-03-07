`timescale 1ns / 1ps


module FIFO(
clk,
rst,
din,
dout,
wr_en,
rd_en
    );
input clk;
input rst;
input[11:0]din;
input rd_en;
input wr_en;
output [11:0]dout;
wire [11:0]temp;
c_shift_ram_0 quenue_ip(
.CLK(clk),
.D(din),
.Q(dout)
);
always@(posedge clk)begin

end
endmodule
