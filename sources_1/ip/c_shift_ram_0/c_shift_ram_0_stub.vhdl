-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Fri Jan 07 19:29:15 2022
-- Host        : LAPTOP-JNDRFSOL running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/shuzidianlu/Xilinx/test_xuezhang_camera/test_xuezhang_camera.srcs/sources_1/ip/c_shift_ram_0/c_shift_ram_0_stub.vhdl
-- Design      : c_shift_ram_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c_shift_ram_0 is
  Port ( 
    D : in STD_LOGIC_VECTOR ( 11 downto 0 );
    CLK : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );

end c_shift_ram_0;

architecture stub of c_shift_ram_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "D[11:0],CLK,Q[11:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_9,Vivado 2016.2";
begin
end;
