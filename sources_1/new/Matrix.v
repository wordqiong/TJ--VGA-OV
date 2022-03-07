`timescale 1ns / 1ps


module Matrix(
clk,rst_n,valid_in,datain,
dout_0,
dout_1,
dout_2,
dout,
can_cout
    );
parameter Width = 12;
parameter COL_NUM = 640;
parameter ROW_NUM = 480;

input clk;
input rst_n;
input valid_in;//输入信号有效
input [Width-1:0]datain;
output  [Width-1:0]dout_0;
output  [Width-1:0]dout_1;
output  [Width-1:0]dout_2;
output  [Width-1:0]dout;
output can_cout;//同时输出前三行的信号 信号为高电平 表示此刻开始输出

reg [Width-1:0]store_data[2:0];//保存输入数据
wire [Width-1:0]dout_out[2:0];//保存输出数据
reg store_data_en[2:0];
wire dout_out_en[2:0];

reg [9:0] col_cnt;
reg[9:0]row_cnt;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
    col_cnt<=0;
    else if(col_cnt==COL_NUM-1&&valid_in)
    col_cnt<=0;
    else if(valid_in)
    col_cnt<=col_cnt+1;
    else
    col_cnt<=col_cnt;
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
    row_cnt<=0;
    else if(row_cnt==ROW_NUM-1&&col_cnt==COL_NUM-1&&valid_in)
    row_cnt<=0;
    else if(col_cnt==COL_NUM-1&&valid_in)
    row_cnt=row_cnt+1;
    else
    row_cnt<=row_cnt;
end
assign can_cout=(row_cnt>=3)?valid_in:1'b0;
//开始同时读入三行的操作
genvar i;
generate
    for(i=0;i<3;i=i+1)
    begin :set_buffer
    linebuffer set(
        .rst_n(rst_n),.clk(clk),.datain(datain),.dataout(dout_out[i]),.
in_en(store_data_en[i]),.out_en(dout_out_en[i])
    );
    if(i==0)
    begin
        always @(*) begin
            store_data[i]<=datain;
            store_data_en[i] <=valid_in;
        end
    end
    else
     begin
        always @(*) begin
            store_data[i]<=dout_out[i-1];
            store_data_en[i]<=dout_out_en[i];
        end
        end
        end
endgenerate
assign dout_0 =dout_out[0];
assign dout_1 =dout_out[1];
assign dout_2 =dout_out[2];






endmodule
