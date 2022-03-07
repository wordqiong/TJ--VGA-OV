module VGA (
    I_clk,I_rst,
    R,G,B,
    HS,
    VS,
    PixAdd,
    PixData,
   model1,
model2,
model3,
Pixdata_2,
           Pixdata_3
);
input I_clk;//传入的时钟频率为25MHz
input I_rst;
output [3:0]R;
output [3:0]G;
output [3:0]B;
input[11:0]PixData;//像素数据
output[18:0]PixAdd;//像素地址
output HS;
output VS;
input model1;
input model2;
input model3;
input[11:0]Pixdata_2;
input[11:0]Pixdata_3;
//分辨率为640*480时 行时序各个参数定义


parameter       C_H_SYNC_PULSE      =   96  , 
                C_H_BACK_PORCH      =   48  ,
                C_H_ACTIVE_TIME     =   640 ,
                C_H_FRONT_PORCH     =   16  ,
                C_H_LINE_PERIOD     =   800 ;
                
// 分辨率为640*480时 场时序各个参数定义               
parameter       C_V_SYNC_PULSE      =   2   , 
                C_V_BACK_PORCH      =   33  ,
                C_V_ACTIVE_TIME     =   480 ,
                C_V_FRONT_PORCH     =   10  ,
                C_V_FRAME_PERIOD    =   525 ;
reg[11:0]row_cnt;//行时序计数器
reg[11:0]col_cnt;//列时序计数器

wire is_valid_address;//地址有效
//产生行时序
always @(posedge I_clk or negedge I_rst) begin
    begin
        if(!I_rst)
        row_cnt<=0;
        else if(row_cnt==C_H_LINE_PERIOD-1'b1)
        row_cnt<=0;
        else
        row_cnt<=row_cnt+1'b1;
    end
end
//产生列时序
always @(posedge I_clk or negedge I_rst) begin
    begin
        if(!I_rst)
        col_cnt<=0;
        else if(col_cnt==C_V_FRAME_PERIOD-1'b1&&row_cnt==C_H_LINE_PERIOD-1'b1)
        col_cnt<=0;
        else if(row_cnt==C_H_LINE_PERIOD-1'b1)
        col_cnt<=col_cnt+1'b1;
    end
end
assign HS=(row_cnt<=C_H_SYNC_PULSE)?1'b0:1'b1;
assign VS=(col_cnt<=C_V_SYNC_PULSE)?1'b0:1'b1;
assign is_valid_address=(row_cnt>=C_H_SYNC_PULSE+C_H_BACK_PORCH)&&
(row_cnt<=C_H_SYNC_PULSE+C_H_BACK_PORCH+C_H_ACTIVE_TIME)&&
(col_cnt<=C_V_SYNC_PULSE+C_V_BACK_PORCH+C_V_ACTIVE_TIME)&&
(col_cnt>=C_V_SYNC_PULSE+C_V_BACK_PORCH);
assign PixAdd=(C_H_ACTIVE_TIME*(col_cnt-(C_V_BACK_PORCH))+(row_cnt-C_H_SYNC_PULSE-((model3&&!model1&&!model2)?C_H_FRONT_PORCH:C_H_BACK_PORCH)+C_V_SYNC_PULSE));


assign R[0]=is_valid_address?(model1?PixData[11]:(model2?Pixdata_2[11]:(model3?Pixdata_3[11]:0))):1'b0;
assign R[1]=is_valid_address?(model1?PixData[10]:(model2?Pixdata_2[10]:(model3?Pixdata_3[10]:0))):1'b0;
assign R[2]=is_valid_address?(model1?PixData[9]:(model2?Pixdata_2[9]:(model3?Pixdata_3[9]:0))):1'b0;
assign R[3]=is_valid_address?(model1?PixData[8]:(model2?Pixdata_2[8]:(model3?Pixdata_3[8]:0))):1'b0;
assign G[0]=is_valid_address?(model1?PixData[7]:(model2?Pixdata_2[7]:(model3?Pixdata_3[7]:0))):1'b0;
assign G[1]=is_valid_address?(model1?PixData[6]:(model2?Pixdata_2[6]:(model3?Pixdata_3[6]:0))):1'b0;
assign G[2]=is_valid_address?(model1?PixData[5]:(model2?Pixdata_2[5]:(model3?Pixdata_3[5]:0))):1'b0;
assign G[3]=is_valid_address?(model1?PixData[4]:(model2?Pixdata_2[4]:(model3?Pixdata_3[4]:0))):1'b0;
assign B[0]=is_valid_address?(model1?PixData[3]:(model2?Pixdata_2[3]:(model3?Pixdata_3[3]:0))):1'b0;
assign B[1]=is_valid_address?(model1?PixData[2]:(model2?Pixdata_2[2]:(model3?Pixdata_3[2]:0))):1'b0;
assign B[2]=is_valid_address?(model1?PixData[1]:(model2?Pixdata_2[1]:(model3?Pixdata_3[1]:0))):1'b0;
assign B[3]=is_valid_address?(model1?PixData[0]:(model2?Pixdata_2[0]:(model3?Pixdata_3[0]:0))):1'b0;
endmodule