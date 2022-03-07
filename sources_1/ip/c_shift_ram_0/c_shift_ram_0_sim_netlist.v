// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Jan 07 19:29:15 2022
// Host        : LAPTOP-JNDRFSOL running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/shuzidianlu/Xilinx/test_xuezhang_camera/test_xuezhang_camera.srcs/sources_1/ip/c_shift_ram_0/c_shift_ram_0_sim_netlist.v
// Design      : c_shift_ram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_shift_ram_0,c_shift_ram_v12_0_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_9,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module c_shift_ram_0
   (D,
    CLK,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [11:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [11:0]Q;

  wire CLK;
  wire [11:0]D;
  wire [11:0]Q;

  (* KEEP_HIERARCHY = "true" *) 
  (* c_addr_width = "4" *) 
  (* c_ainit_val = "000000000000" *) 
  (* c_default_data = "000000000000" *) 
  (* c_depth = "16" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "000000000000" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "12" *) 
  (* c_xdevicefamily = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_9 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_AINIT_VAL = "000000000000" *) (* C_DEFAULT_DATA = "000000000000" *) 
(* C_DEPTH = "16" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "0" *) (* C_SINIT_VAL = "000000000000" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "12" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "c_shift_ram_v12_0_9" *) (* downgradeipidentifiedwarnings = "yes" *) 
module c_shift_ram_0_c_shift_ram_v12_0_9
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [3:0]A;
  input [11:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [11:0]Q;

  wire [3:0]A;
  wire CE;
  wire CLK;
  wire [11:0]D;
  wire [11:0]Q;
  wire SCLR;
  wire SINIT;
  wire SSET;

  (* c_addr_width = "4" *) 
  (* c_ainit_val = "000000000000" *) 
  (* c_default_data = "000000000000" *) 
  (* c_depth = "16" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "000000000000" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "12" *) 
  (* c_xdevicefamily = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_9_viv i_synth
       (.A(A),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(SINIT),
        .SSET(SSET));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
pVSB1fdp0d8mtg3LHrLYCqADYNQv1kYsGBMv/+K08aLxh/NLENzMM7hXXYld+2Mgd7vecGpdaC3k
gwoJ87eJgg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
TrvLQEi/uJPAZXHsPaV57yoJ9EtvRVNbWErIxN3rJpRzIiClrcH6SWry1U/juttM6Ef9Hp5zSiEl
xNpXxoS8wD1iGQC3wTWm6onL4lbs5dCr5r6SHKI+yRvk7PM0lNGSuxzJxiESo15OD+VI4TBDw4Zt
hcxOQOC9HXnv4RekyhM=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
g55PFOQz5gBNNuoAKJA6LG+Go3evy8K7bR71fr18lbAHBy6BXY5cxyMVmR6iMXA9xjvLNX9ZwFxL
yW9jhdIKz+0phA20qrgB9zIyJLsPj7lBLFXWAKf8rmqv2GMRf7GqCtYK5Pqn6bxMwn+n8j50ca2O
X49Iq1oj34Zh+mics+4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JjYKvrh9MOLSA4mR//LjTlBGaa8xCFhn+/gMizL6ZibhVKAfMan42h7Ih/5YTGi++UTn0LHd9NL2
NaEQm2v4o2/CYXMF02K83EGT2I0yUSTUGc3tcxpNAxg390x/Pf1S4xXOwpqZAYLjhWse/4qzYHFe
iIQp1rnWICwKmFo+ZDG7yZ46pqq5zbSoc4y2p8g2Be/9TN+Y61xI7+D+EAu7QTdwsL8a3QMsB7Zo
r8bdBBswbfd/oqL9KLKL/Se74397O2HGv16SR7618OwhGC/PJGF62sCa/WzAZbXDjbk7bTLUCyoY
71dLV9qD6596pGntd7mPSMKPXsrBqm2dF4MJ1A==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SSijEQc3z4IgPRpOXyZNPGTBKNNDh8UIUp6Jc6nCd2BhqaRyKvYRVaSbO28FxPLannTOttVNc7kk
nl077g777DPyzXTsDcYVVSgCq66KzFzd9air6Rm4YQEnULnroQEEBvsGlrlRApzIY13fCR8Q8Fes
8flh0wIvt1IUA60/FMM3YwNPai5m3k19RaY/qsBdtTNLM+8XqaS0XCHWnyA2QHtb6iqRTQyHXNpO
tBGXOMyVMkyGUq2FAx9nYlTvIbXYYvrUtsQaGxetWks9vlDulbTRAnCFb7GU0+h3l3y+hF4Wzkn2
o2p95CyRx1FQ/Rn0oxBn++Rtk6p7bYPQS42cSQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L337KT5q53NKw85qdeX1tBHCmb9rh0WndWsKzAyylJ7jXE+LkDsZ1dyUX2YUpfCn9BKLEH2MzATq
tqzbaiVWOu/xeMRiU5/wkXL4qEX/dKjPRSJlNBWwDa9lFGbdFy89cWFoNvS+Teu59m5yiiDnIsEO
MXDu8nBP5UasM+BEuesC1UlPIu7vinDhIbxmSZZQfdQoxRJrJhS5MUcMYRs6Q8mNJvPXbo1WhUGq
lCkeJ1Mwf+GUzVwd087Tb7Hf3TsU6tjTfAyqJFoofzOBAnyD237xgkHu2B+/4AT6bby5CbEp5ISZ
1Crn+G5ARbRRqoqaFdx72snFnkZFJIffkdR3DQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
Rk5MJ9exsDov+n+A5/Nu8vYXshvHWBrA+psUgEvpzDkvaaTGLS7THgp3w15H1MmJOjIVChOz4lqG
TFYw/Ew7dlZBSstslIXbNbochk+jKs40RX2dGcJeCF112ewu6Bx8VK3fX/OypwO9ptCYqrFDjDYU
+kujZ1xjasuXyOXsiQnzN535rnfzbgyYfLv9bC0nwGinYoTjFqz6q/ihZ1g+5Q5OWx2I9vwNprav
lY9nkGCTuBRvArfvD/47z1kheZQSf+8b1ubvLFGXtIKGNKxXKR+gdPpP3TyAQ6uEp5XLjTneu7V5
zsrkkvvhT5P6sF8Xa8+140unNiaZUl8JdaTb9Q==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
e4Ma+muU9m4irz0N0lsD6T7FL37oGw7zSFBXAxxPhgaDv5lFhQ4Hvcd1C7EqrKZfWxcg3srhl3Nh
BUkiLsMZtA+BXBa7SIavahSu1RpriOo0qSlzUoDTGZTSCXzZt3fDW+pU+GxaHxM2Hru1BOGRaANU
HJvd6B//BoD9PfZ1k1GPFsrJvb9PQAplFTIwjLPq5lru6byk7ZiMXxbt/TQDUP5UZVH8bCJQ/lue
yCVO8ctvdqUV2ZD6BQ3MXWMcvkaJFpRKeowP3r4497Yjnc50jVkfbl5aSKwnP+4hUsMStZ1jS4UU
3NLxQkXGgGSwpzCzg+JmSchgNpg9QlbgGKh7pQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 13824)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
