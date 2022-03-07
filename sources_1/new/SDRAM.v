`timescale 1ns / 1ps

//RAM
module RAM(wea, clka, clkb, addra, addrb, dina, doutb);
    input wea;
    input clka;
    input clkb;
    input [18:0]addra;
    input [18:0]addrb;
    input [11:0]dina;
    output [11:0]doutb;//12位输出数据

    blk_mem_gen_0 sdram_inst (
        .clka(clka),    
        .wea(wea),     
        .addra(addra),  
        .dina(dina),   
        .clkb(clkb),   
        .addrb(addrb), 
        .doutb(doutb) 
    );

endmodule