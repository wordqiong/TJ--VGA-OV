`timescale 1ns / 1ps
module get_pic(rst, CFG_done, pclk,  vsync, herf, data_in, data_out, we_en, out_addr);
    input rst;//复位信号
    input CFG_done;//配置完成

    input pclk;//像素时钟

    input vsync;//场同步信号
    input herf;//行有效信号
    input [7:0]data_in;//数据接入
    output reg[11:0]data_out;//拼接的12bit数据
    output reg we_en;//输出使能
    output [18:0]out_addr;//写入RAM的地址    
    parameter p_real_y = 11'd600;//纵坐标实际边界
    parameter p_real_x = 11'd800;//横坐标实际边界
    parameter p_true_y = 11'd480;//纵坐标有效边界
    parameter p_true_x = 11'd640;//横坐标有效边界

    reg[15:0]RGB_565=0;    
    //地址与时钟的赋值
    reg [18:0]r_addr;//地址寄存器
    assign out_addr = r_addr;

    reg [1:0]r_detect_border;    //检测上升与下降沿
    reg r_vysnc_valid;//帧有效信号
    wire w_negedge;//下降沿
    wire w_posedge;//上升沿
    always @ (posedge pclk or negedge rst)
    begin
        if(!rst)
            r_detect_border <= 0;
        else if (CFG_done)
            r_detect_border <= {r_detect_border[0], vsync};
    end
    assign w_negedge = r_detect_border[1] && !r_detect_border[0] ;//下降沿
    assign w_posedge = !r_detect_border[1] && r_detect_border[0] ;//上升沿
    

    
    always @(posedge pclk or negedge rst)
    begin
        if (!rst) 
        r_vysnc_valid<=0;
        else if (CFG_done)
            begin
            if(w_posedge) 
            //上升沿
                r_vysnc_valid <= 1; 
            else if(w_negedge) 
            //下降沿
                r_vysnc_valid <= 0;
            else 
                r_vysnc_valid <= r_vysnc_valid;
            end
    end
    
    //拼接数据
    reg [11:0]r_cnt;//横坐标计数
    reg [1:0]r_temp;//中间值轮转量

    always @ (posedge pclk or negedge rst)
    begin
        if (!rst) //复位
            begin 
            r_cnt <= 0;
            r_temp <= 0;
            data_out  <= 0;
            we_en <= 1'b0;
            r_addr <= 0;
            end
     else if (CFG_done)//配置完成
                       begin
                       if (r_vysnc_valid)
                           begin
                           if ((herf == 1'b1) && (vsync == 1'b1) && (r_cnt < p_true_x)) //对一行帧进行处理
                               begin   
                               if (r_temp < 1'b1) 
                                   begin                                    
                                   r_temp <= r_temp + 1'b1;
                                   data_out[11:5] = {data_in[7:4], data_in[2:0]};
                                   we_en <= 1'b0;
                                   end
                               else 
                                   begin                                                 
                                   r_cnt <= r_cnt+ 1'b1;
                                   r_temp <= 0;
                                   data_out[4:0] <= {data_in[7], data_in[4:1]};
                                    r_addr <= r_addr + 1'b1;
                                    we_en <= 1'b1;
                                   end
                               end
                else if ((herf == 1'b0) && (vsync == 1'b1)) //一行结束
                    begin   
                    r_cnt <= 0;
                    r_temp <= 0;
                    we_en <= 1'b0;
                    r_addr <= r_addr;
                    end
                else 
                    begin
                    r_cnt <= r_cnt;//截取一行后等待
                    r_temp <= 0;
                    we_en <= 1'b0;
                    r_addr <= r_addr;
                    end
            end
        else 
            begin
            r_cnt <= 0;
            r_temp <= 0;
            we_en <= 1'b0;
            r_addr <= 0;
            end   
        end 
    end    
    
endmodule