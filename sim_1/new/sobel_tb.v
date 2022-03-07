`timescale 1ns/1ps
`define CLK_PERIOD 20//50MHZ

module matrix_3x3_tb ();
reg clk;
reg [9:0] din;
reg rst_n;
reg valid_in;
//wires
wire [9:0] dout;
wire [9:0] dout_r0;
wire [9:0] dout_r1;
wire [9:0] dout_r2;
wire mat_flag;

Matrix Matri_inst(
    .clk (clk),
    .datain (din),
    .dout(dout),
    .dout_0(dout_r0),
    .dout_1(dout_r1),
    .dout_2(dout_r2),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .can_cout(mat_flag)
);
initial begin
    clk = 0;
    rst_n = 0;
    valid_in = 0;
    #(`CLK_PERIOD * 10);
    rst_n=1;
    #(`CLK_PERIOD*10);
    valid_in = 1;
    #(`CLK_PERIOD*480*5);
    valid_in = 0;
    #(`CLK_PERIOD*20);

end

always #(`CLK_PERIOD/2) clk = ~clk;

/*
    这里din会在0-479之后，返回0，再次从0-479；
    所以，模拟的每一行数据都是从0-479，因此在仿真时三行数据对齐时它们的数据才会是一样的。

    如果输入的din是真实的图像数据，那么由于一帧图像数据每一行是不一样的，所以对齐后三行数据也不相同。
*/
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        din <= 0;
    else if(din == 479)
        din <= 0;
    else if (valid_in == 1'b1)
        din <= din + 1'b1;
end

endmodule
