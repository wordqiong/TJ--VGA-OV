`timescale 1ns / 1ps
module SCCB (
    clk,rst,SCCB_CLK,
    SCCB_can_read,REG_size,
    SCCB_data,REG_Index,
    REG_done,REG_rdata,
    ACK,read_en
);
input clk;
input rst;
output SCCB_CLK;//与摄像头对应的时钟
inout SCCB_can_read;//判断是读还是写
input [7:0]REG_size;
//SCCB传输最多3段  ID+地址+数据
input [23:0]SCCB_data;
output reg [7:0]REG_Index;//对应的寄存器地址
output REG_done;//摄像头配置完成
output reg[7:0]REG_rdata;//读取寄存器数据
output reg ACK;
output read_en;//使能信号

parameter SCCB_IDLE = 0;//暂停状态 无操作
//写操作分3段 1次
parameter  SCCB_W_START=1 ;
parameter  SCCB_W_id_addr=2 ;
parameter  SCCB_W_ack1=3 ;
parameter  SCCB_W_reg_addr=4 ;
parameter  SCCB_W_ack2=5 ;
parameter  SCCB_W_reg_data=6 ;
parameter  SCCB_W_ack3=7 ;
parameter  SCCB_W_stop=8 ;
//读操作有两段  有两次
parameter  SCCB_R_START1=9 ;
parameter  SCCB_R_id_addr1=10 ;
parameter  SCCB_R_ack1=11 ;
parameter  SCCB_R_reg_addr=12 ;
parameter  SCCB_R_ack2=13 ;
parameter  SCCB_R_stop1=14 ;
parameter  SCCB_R_temp=15 ;

parameter  SCCB_R_START2=16 ;
parameter  SCCB_R_id_addr2= 17;
parameter  SCCB_R_ack3=18 ;
parameter  SCCB_R_reg_data=19 ;//读取寄存器
parameter  SCCB_R_NA=20 ;
parameter  SCCB_R_stop2=21 ;

parameter p_SCCB_CLK = 1000;
parameter delay_num = 100000;
reg[18:0] r_delay_cnt;
reg[18:0]r_clk_cnt;//记录时钟
reg r_sccb_clk;
reg[4:0]r_now_state;
reg[4:0]r_next_state;
reg[3:0]r_bit_cnt;
reg r_sccb_out;//输出数据


wire w_sccb_in=SCCB_can_read;
wire w_delay_done=(r_delay_cnt==delay_num)?1:0;
wire w_transfer_en=(r_clk_cnt==17'd0)?1:0;//数据发送使能
wire w_capture_en = (r_clk_cnt==(2*p_SCCB_CLK/4)-1)?1:0;
wire w_write_done;
//上电延迟
always @(posedge clk or negedge rst) begin
begin
    if(!rst)
        r_delay_cnt<=0;
    else if(r_delay_cnt<delay_num)
        r_delay_cnt<=r_delay_cnt+1;
    else
        r_delay_cnt<=r_delay_cnt;
end
end

//开始SCCB时钟
always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        r_clk_cnt<=0;
        r_sccb_clk<=0;
    end
    else if(w_delay_done)
    begin
        if(r_clk_cnt<(p_SCCB_CLK-1))
            r_clk_cnt <= (r_clk_cnt + 1);
        else
            r_clk_cnt <= 0;
         r_sccb_clk <= (r_clk_cnt >= (p_SCCB_CLK/4 + 1'b1))&&(r_clk_cnt  < (3*p_SCCB_CLK/4) + 1'b1) ? 1'b1 : 1'b0;
    end
    else
        begin
        r_clk_cnt <= 0;
        r_sccb_clk <= 0;
        end
end
//读取使能信号
wire w_read_en = (r_now_state == SCCB_W_ack1 || r_now_state == SCCB_W_ack2
                    || r_now_state == SCCB_W_ack3 || r_now_state == SCCB_R_ack1
                    || r_now_state == SCCB_R_ack2 || r_now_state == SCCB_R_ack3
                    || r_now_state == SCCB_R_reg_data) ? 1'b1 : 1'b0;
assign Read_en =  w_read_en;

//sccb信号
assign SCCB_CLK = (r_now_state >= SCCB_W_id_addr && r_now_state <= SCCB_W_ack3 
                    || r_now_state >= SCCB_R_id_addr1 && r_now_state <= SCCB_R_ack2
                    || r_now_state >= SCCB_R_id_addr2 && r_now_state <= SCCB_R_NA) ? r_sccb_clk : 1'b1;
//三态门进行输入输出判定
assign SCCB_can_read = (~w_read_en) ? r_sccb_out : 1'bz;
//当SCCB时钟有信号时  开始数据存储
//首先进行位计数
always @(posedge r_sccb_clk or negedge rst) begin
    if(!rst)
    begin
        r_bit_cnt<=0;
    end
    else
    begin
        //可以存数据的几种状态
        case(r_next_state)
        SCCB_W_id_addr:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_W_reg_addr:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_W_reg_data:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_R_id_addr1:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_R_reg_addr:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_R_id_addr2:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        SCCB_R_reg_data:
        r_bit_cnt <= r_bit_cnt + 1'b1;
        default:
        r_bit_cnt <= 0;
        endcase
    end
end
//随后将进行对应位置的存储工作，减去读到的cnt位数 
//现在先进行状态转移
//注意有的部分需要重复8次 即将8位数据传输完成
//初始化状态机
//每一次时钟信号的到来 状态机都要向次态改变
always @(posedge clk or negedge rst) begin
    if(!rst)
    r_now_state = SCCB_IDLE;
    else
    r_now_state=r_next_state;
end
always @(*) begin
    r_next_state =SCCB_IDLE;
    case(r_now_state)
    SCCB_IDLE://无操作需要等待延迟信号结束
    if(w_delay_done)
        r_next_state=SCCB_W_START;
    else
        r_next_state=SCCB_IDLE;
    SCCB_W_START:
    if(w_transfer_en)
        r_next_state=SCCB_W_id_addr;
    else
        r_next_state=SCCB_W_START;
    SCCB_W_id_addr:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_W_ack1;
    else
        r_next_state=SCCB_W_id_addr;
    SCCB_W_ack1:
    if(w_transfer_en)
        r_next_state=SCCB_W_reg_addr;
    else
        r_next_state=SCCB_W_ack1;
    SCCB_W_reg_addr:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_W_ack2;
    else
        r_next_state=SCCB_W_reg_addr;
    SCCB_W_ack2:
    if(w_transfer_en)
        r_next_state=SCCB_W_reg_data;
    else
        r_next_state=SCCB_W_ack2;
    SCCB_W_reg_data:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_W_ack3;
    else
        r_next_state=SCCB_W_reg_data;
    SCCB_W_ack3:
    if(w_transfer_en)
        r_next_state=SCCB_W_stop;
    else
        r_next_state=SCCB_W_ack3;
    SCCB_W_stop:
        if(w_transfer_en)
            if(w_write_done)
                r_next_state=SCCB_R_START1;
            else
                r_next_state=SCCB_W_START;
        else
        r_next_state=SCCB_W_stop;
//读操作有两段  有两次
    SCCB_R_START1:
    if(w_transfer_en)
        r_next_state=SCCB_R_id_addr1;
    else
        r_next_state=SCCB_R_START1;
    SCCB_R_id_addr1:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_R_ack1;
    else
        r_next_state=SCCB_R_id_addr1;
    SCCB_R_ack1:
    if(w_transfer_en)
        r_next_state=SCCB_R_reg_addr;
    else
        r_next_state=SCCB_R_ack1;
    SCCB_R_reg_addr:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_R_ack2;
    else
        r_next_state=SCCB_R_reg_addr;
    SCCB_R_ack2:
    if(w_transfer_en)
        r_next_state=SCCB_R_stop1;
    else
        r_next_state=SCCB_R_ack2;
    SCCB_R_stop1:
    if(w_transfer_en)
        r_next_state=SCCB_R_temp;
    else
        r_next_state=SCCB_R_stop1;
    SCCB_R_temp:
    if(w_transfer_en)
        r_next_state=SCCB_R_START2;
    else
        r_next_state=SCCB_R_temp;
    SCCB_R_START2:
    if(w_transfer_en)
        r_next_state=SCCB_R_id_addr2;
    else
        r_next_state=SCCB_R_START2;
    SCCB_R_id_addr2:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_R_ack3;
    else
        r_next_state=SCCB_R_id_addr2;
    SCCB_R_ack3:
    if(w_transfer_en)
        r_next_state=SCCB_R_reg_data;
    else
        r_next_state=SCCB_R_ack3;
    SCCB_R_reg_data:
    if(w_transfer_en&&r_bit_cnt==4'h8)
        r_next_state=SCCB_R_NA;
    else
        r_next_state=SCCB_R_reg_data;
    SCCB_R_NA:
    if(w_transfer_en)
        r_next_state=SCCB_R_stop2;
    else
        r_next_state=SCCB_R_NA;
    SCCB_R_stop2:
        r_next_state=SCCB_R_stop2;
    endcase
end
//开始数据详细的处理
reg r_sccb_clk_default;
reg [7:0]r_sccb_temp_data;//暂时存储sccb中途协议数据

//低电平开始记录数据
//对次态进行处理  如果对现态处理，clk存在延时，将无法即时将当前数据完好存入 因为 现态对应的操作有 计数器++，向次态改变 
//将次态改为需要的状态符合需要

//从寄存器里读数据
always @(negedge clk or negedge rst) begin
    if(!rst)
    r_sccb_out<=0;
    else if(w_transfer_en)
        case(r_next_state)
        SCCB_R_START1: 
            begin
            r_sccb_clk_default <= 1'b1;
            r_sccb_out <= 1'b0;
            r_sccb_temp_data <= SCCB_data[23:16];//最高位的ID地址
            end
        SCCB_R_START2: 
            begin
            r_sccb_clk_default <= 1'b1;
            r_sccb_out <= 1'b0;
            r_sccb_temp_data <= SCCB_data[7:0];//低位的ID地址
            end
        SCCB_R_id_addr1: 
            begin
            r_sccb_clk_default <= 1'b0;
            r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
            end
        SCCB_R_id_addr2: 
            begin
            r_sccb_clk_default <= 1'b0;
            if (r_bit_cnt < 4'd7)
                r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
            else
                r_sccb_out <= 1'b1;
                //将低位拉高 取消读取状态
            end
        SCCB_R_reg_addr: 
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
                end
        SCCB_R_NA: 
                begin
                r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b1;
                end
        SCCB_W_START: 
                begin
                r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b0;
                r_sccb_temp_data <= SCCB_data[23:16];//最高位的ID地址
                end
        SCCB_W_id_addr: 
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
                end
        SCCB_W_reg_data: 
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
                end
        SCCB_W_reg_addr: 
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_out <= r_sccb_temp_data[3'd7 - r_bit_cnt];
                end
        SCCB_W_ack1: //写：应答1
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_temp_data <= SCCB_data[15:8];//中间位的寄存器地址
                end
        SCCB_W_ack2: //写：应答2
                begin
                r_sccb_clk_default <= 1'b0;
                r_sccb_temp_data <= SCCB_data[7:0];//低位的写入数据
                end
        SCCB_R_stop1: //停止情况
                begin
                 r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b0;
                end
        SCCB_R_stop2:
                begin
                 r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b0;
                end
        SCCB_R_temp: //读：中间转换状态
                begin
                 r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b1;
                end
            
        SCCB_R_ack1: //读：应答1
                begin
                 r_sccb_clk_default <= 1'b0;
                r_sccb_temp_data <= SCCB_data[15:8];//中间位的寄存器地址
                end
        SCCB_R_ack2://读：应答2
                begin
                 r_sccb_clk_default <= 1'b0;
                end
        SCCB_R_ack3:
                begin
                 r_sccb_clk_default <= 1'b0;
                end
        SCCB_R_reg_data: //读：寄存器数据
                begin
                 r_sccb_clk_default <= 1'b0;
                end
            
        SCCB_W_ack3: //写：应答3
                begin
                 r_sccb_clk_default <= 1'b0;
                end
        SCCB_W_stop: //写：停止
                begin
                 r_sccb_clk_default <= 1'b1;
                r_sccb_out <= 1'b0;
                end
        default: ;
        endcase
end
//向寄存器中写数据 创建索引路由
wire w_transfer_end = (r_now_state == SCCB_W_stop 
                         || r_now_state == SCCB_R_stop2) ? 1'b1 : 1'b0;
always @ (negedge clk or negedge rst)
    begin
        if (!rst)//重置
            REG_Index <= 0;
        else if (w_transfer_en)
            begin
            if (w_transfer_end && ACK == 1'b0)
                begin
                if (REG_Index < REG_size)
                    REG_Index <= REG_Index + 1'b1;
                else
                    REG_Index <= REG_size;
                end
            else
                REG_Index <= REG_Index;
            end
        else
            REG_Index <= REG_Index;
    end
assign REG_done = (REG_Index == REG_size) ? 1 : 0;
assign w_write_done = (REG_Index == (REG_size - 1)) ? 1 : 0;
always @ (negedge clk or negedge rst)
    begin
        if (!rst)//重置 
            REG_rdata <= 0;//REG_rdata
        else if (w_capture_en)
            case (r_next_state)
            SCCB_R_reg_data: //读寄存器数据
                REG_rdata <= {REG_rdata[6:0], w_sccb_in};
            default:  ;
            endcase
    end

    //应答信号处理
reg [2:0]r_ack;//3个应答信号的记录
always @ (posedge clk or negedge rst)
    begin
        if (!rst)//重置
            begin
            r_ack <= 3'b111;
            ACK <= 1'b1;
            end
        else if(w_capture_en)
            begin
            case(r_next_state)
            SCCB_IDLE: //空闲态
                begin
                r_ack <= 3'b111;
                ACK <= 1'b1;
                end
            SCCB_R_ack1:
                r_ack[0] <= w_sccb_in;
            SCCB_R_ack2:
                r_ack[1] <= w_sccb_in;
            SCCB_R_ack3:
                r_ack[2] <= w_sccb_in;
            SCCB_R_stop2:
                ACK <= (r_ack[0] | r_ack[1] | r_ack[2]);
            SCCB_W_ack1:
                r_ack[0] <= w_sccb_in;
            SCCB_W_ack2:
                r_ack[1] <= w_sccb_in;
            SCCB_W_ack3:
                r_ack[2] <= w_sccb_in;
            SCCB_W_stop:
                ACK <= (r_ack[0] | r_ack[1] | r_ack[2]); 
            default: ;
            endcase
            end
        else
            begin
            r_ack <= r_ack;//保持
            ACK <= ACK;
            end
    end
endmodule
