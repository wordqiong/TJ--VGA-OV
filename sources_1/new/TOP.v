`timescale 1ns / 1ps

//摄像头大作业顶层控制器模块
module TOP(sioc, siod, vsync, herf, pclk, xclk, ca_data, ca_rst, pwdn, vsync_s, hsync_s, red_d, green_d, blue_d, is_ack, pix, rst_n, clk, is_read, is_write
,model_1,model_3,model_2);
    //摄像头接口
    output sioc;//SCCB时钟
    inout siod;//SCCB数据，双向
    input vsync;//场同步信号
    input herf;//行有效信号输出
    input pclk;//像素时钟
    output xclk;//输入主时钟
    input [7:0]ca_data;//8bit数据
    output ca_rst;//复位
    output pwdn;
    

    output vsync_s;//行同步信号
    output hsync_s;//列同步信号
    output [3:0]red_d;//红颜色信号
    output [3:0]green_d;//绿颜色信号
    output [3:0]blue_d;//蓝颜色信号

    output is_ack;//摄像头应答反馈（低电平有效）
    output [7:0]pix;
    output is_write;//写入数据使能信号
    output is_read;//用于仿真的三态门设计
    //模块全局接口
    input rst_n;//复位

    input clk;//开发板系统时钟，100MHz
    input model_1;
  input model_2;
    input model_3;
    //内部模块接线
    //RAM接口
    wire [11 : 0]Frame_data; //output
    wire [18 : 0]Frame_addr; //output
    
    //内部接线
    wire [18:0]w_read_addr;//VGA读取地址
    wire [7:0]w_Read_ID;//读取摄像头的ID，检测摄像头的工作与代表写入配置完成
    wire [11:0]w_out_pix_data;//输出像素数据线
    wire w_clk_10MHz, w_clk_24MHz, w_clk_25MHz;//分频后的时钟线
    
    assign pix = ca_data;//w_out_pix_data[15:8]
    //时钟分频器
     clk_wiz_0 div(.clk_in1(clk), .clk_out2(w_clk_10MHz), .clk_out3(w_clk_24MHz), .clk_out1(w_clk_25MHz));
    camera_Driver came_inst(
        .SIOC(sioc), 
        .SIOD(siod), 
        .VSYNC(vsync), 
        .HREF(herf),
        .PCLK(pclk), 
        .XCLK(xclk), 
        .CA_DATA(ca_data), 
        .CA_RST(ca_rst), 
        .PWDN(pwdn), 
        .f_data(Frame_data), 
        .f_addr(Frame_addr),
        .out_en(is_write),
        .rst_n(rst_n), 
        .clk_sioc(w_clk_10MHz), 
        .clk_xclk(w_clk_25MHz),
        .is_ack(is_ack),
        .is_read(is_read), 
        .reg_data_read(w_Read_ID)
    );
    
    //实例化简单双向RAM
    RAM ram_inst(
        .wea(is_write ), 
        .clka(pclk), //Frame_clken  clk
        .clkb(w_clk_25MHz), 
        .addra(Frame_addr), 
        .addrb(w_read_addr), 
        .dina(Frame_data), 
        .doutb(w_out_pix_data)
    );
    

    wire [11:0]deal_color;

    process_picture pro(.clk(clk),.in_rgb(w_out_pix_data),.out_rgb(deal_color));
    wire [11:0]deal_ed_color;
    wire have_end;
  sobel sobel_inst(    .clk(w_clk_25MHz),.rst(rst_n),.datain(deal_color),.datain_en(1),
    .dataout(deal_ed_color),.dataout_en(have_end));
    wire [11:0]deal_deal_data;
    MidLv mid_opt(    .clk(clk),.rst(rst_n),.datain(deal_ed_color),.datain_en(1),
.dataout(deal_deal_data),.dataout_en(),.clk_in(w_clk_25MHz));
    //实例化VGA显示模块
    VGA vga_inst(
        .I_clk(w_clk_25MHz), 
        .I_rst(rst_n), 
        .PixAdd(w_read_addr),
        .PixData(w_out_pix_data),// Frame_data w_out_pix_data
        .VS(vsync_s), 
        .HS(hsync_s), 
        .R(red_d), 
        .G(green_d), 
        .B(blue_d),
        .model1(model_1),
         .model2(model_2),
          .model3(model_3),
        .Pixdata_2(deal_color),
        .Pixdata_3(deal_deal_data)
    );
endmodule