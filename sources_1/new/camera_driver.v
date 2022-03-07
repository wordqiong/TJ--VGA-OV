`timescale 1ps / 1ps
module camera_Driver(SIOC, SIOD, VSYNC, HREF, PCLK, XCLK, CA_DATA, CA_RST, PWDN, f_data, f_addr, out_en, rst_n, clk_sioc, clk_xclk, is_ack, is_read, reg_data_read);
    //摄像头接口
    output SIOC;//SCCB时钟
    inout SIOD;//SCCB数据
    input VSYNC;//场同步
    input HREF;//行有效
    input PCLK;//像素时钟
    output XCLK;//输入主时钟
    input [7:0]CA_DATA;//8bit数据
    output CA_RST;
    output PWDN;
    
    output [11:0]f_data; 
    output [18:0]f_addr;
    output out_en;//完成信号
    input rst_n;//复位
    input clk_sioc;//SCCB时钟
    input clk_xclk;//XCLK时钟
    output is_ack;//应答信号
    output is_read;//三态门
    output [7:0]reg_data_read;//寄存器数据
    

    wire [7:0]sccb_size;
    wire [7:0]sccb_index;
    wire [15:0]write_data;//读取配置数据线
    wire w_xclk, w_sioc;//时钟中间商
    wire sccb_end;//配置完成信号
    

    assign CA_RST  = 1;//高电平
    assign PWDN = 0;//低电平
    parameter IDaddr = 8'h60;//写寄存器地址
    //SCCB时序实例化
    SCCB sccn_inst(
        .clk(clk_sioc),.rst(rst_n),.SCCB_CLK(SIOC),
    .SCCB_can_read(SIOD),.REG_size(sccb_size),.SCCB_data({IDaddr, write_data[15:0]}),.REG_Index(sccb_index),
    .REG_done(sccb_end),.REG_rdata(reg_data_read),.ACK(is_ack),.read_en(is_read)
    );
    
    //配置实例化
    Config config_inst(.data_index(sccb_index), .data_out(write_data), .reg_size(sccb_size));
    assign XCLK=clk_xclk;
    //读取数据
    get_pic pic_inst(
    .rst(rst_n), .CFG_done(sccb_end), .pclk(PCLK), .vsync(VSYNC), .herf(HREF), .data_in(CA_DATA), .data_out(f_data), .we_en(out_en), .out_addr(f_addr)
    );

endmodule