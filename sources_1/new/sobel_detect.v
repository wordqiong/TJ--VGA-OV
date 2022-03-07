module sobel (
    clk,rst,datain,datain_en,
    dataout,dataout_en
);
input clk;
input rst;
input[11:0]datain;
input datain_en;
output reg [11:0]dataout;
output reg dataout_en;
    //3X3像素点 三行像素缓存
    //记录中间变量
wire [11:0]line0;
wire [11:0]line1;
wire [11:0]line2;

reg [11:0]line0_data0;
reg [11:0]line0_data1;
reg [11:0]line0_data2;
reg [11:0]line1_data0;
reg [11:0]line1_data1;
reg [11:0]line1_data2;
reg [11:0]line2_data0;
reg [11:0]line2_data1;
reg [11:0]line2_data2;

reg [13:0]sum0_x;
reg [13:0]sum2_x;
reg [13:0]sum0_y;
reg [13:0]sum2_y;
wire [14:0]sum_x;
wire [14:0]sum_y;
wire [11:0]result;
wire can_cout;
reg can_cout_0;
reg can_cout_1;
reg can_cout_2;
reg can_cout_3;
reg can_cout_4;
reg can_cout_5;

parameter x0_0 = 1;
parameter x0_2 = 1;
parameter x1_0 = 2;
parameter x1_2 = 2;
parameter x2_0 = 1;
parameter x2_2 = 1;
parameter y0_0 = 1;
parameter y0_1 = 2;
parameter y0_2 = 1;
parameter y2_0 = 1;
parameter y2_1 = 2;
parameter y2_2 = 1;


//获取3X3的矩阵
Matrix ma(
.clk(clk),.rst_n(rst),.valid_in(datain_en),.datain(datain),
.dout_0(line0),.dout_1(line1),.dout_2(line2),.dout(),.can_cout(can_cout)

);
//上升沿过来，状态要发生改变，对应当前的数据
always @(posedge clk) begin
    can_cout_0<=can_cout;
    can_cout_1<=can_cout_0;
    can_cout_2<=can_cout_1;
    can_cout_3<=can_cout_2;
    can_cout_4<=can_cout_3;
    can_cout_5<=can_cout_4;
end
//检测状态变化，每个上升沿过来 状态都要发送改变
always @(posedge clk or negedge rst) begin
    if(!rst)begin
        line0_data0<=0;
        line0_data1<=0;
        line0_data2<=0;
        line1_data0<=0;
       line1_data1<=0;
        line1_data2<=0;
        line2_data0<=0;
       line2_data1<=0;
        line2_data2<=0;
    end
    else if(datain_en)
    begin
        line0_data0<=line0;
        line0_data1<=line0_data0;
        line0_data2<=line0_data1;
        line1_data0<=line1;
       line1_data1<=line1_data0;
        line1_data2<=line1_data1;
        line2_data0<=line2;
       line2_data1<=line2_data0;
        line2_data2<=line2_data1;
    end
end

assign sum_x=(sum0_x>sum2_x)?(sum0_x-sum2_x):(sum2_x-sum0_x);
assign sum_y=(sum0_y>sum2_y)?(sum0_y-sum2_y):(sum2_y-sum0_y);
always @(posedge clk or negedge rst) begin
if(!rst)begin
sum0_x<=0;
sum2_x<=0;
sum0_y<=0;
sum2_y<=0;
end
else if (datain_en)
begin
sum0_x<=line0_data0*x0_0+line0_data1*x1_0+line0_data2*x2_0;
sum2_x<=line2_data0*x0_2+line2_data1*x1_2+line2_data2*x2_2;
sum0_y<=line0_data0*y0_0+line1_data0*y0_1+line2_data0*y0_2;
sum2_y<=line0_data2*y2_0+line1_data2*y2_1+line2_data2*y2_2;
end

end




assign result=(sum_x+sum_y)/2;
always @(posedge clk or negedge rst) begin
    if(!rst)
    dataout<=0;
    else if(datain_en)
    dataout<=(result>12'h221)?12'hfff:12'b0;
    else ;
end
always @(posedge clk or negedge rst) begin
     if(!rst)
    dataout_en<=0;
    else if(can_cout)
    dataout_en<=1;
    else
    dataout_en<=0;
end
endmodule