// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Jan 07 19:29:15 2022
// Host        : LAPTOP-JNDRFSOL running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/shuzidianlu/Xilinx/test_xuezhang_camera/test_xuezhang_camera.srcs/sources_1/ip/c_shift_ram_0/c_shift_ram_0_stub.v
// Design      : c_shift_ram_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_9,Vivado 2016.2" *)
module c_shift_ram_0(D, CLK, Q)
/* synthesis syn_black_box black_box_pad_pin="D[11:0],CLK,Q[11:0]" */;
  input [11:0]D;
  input CLK;
  output [11:0]Q;
endmodule
