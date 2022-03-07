`timescale 1ns / 1ps


module compare(
clk,rst,is_juanji_end,din0,
din1,din2,din3,din4,din5,din6,din7,din8,
dout
    );
parameter width=12;
input clk;
input rst;
input is_juanji_end;
input[width-1:0]din0;
input[width-1:0]din1;
input[width-1:0]din2;
input[width-1:0]din3;
input[width-1:0]din4;
input[width-1:0]din5;
input[width-1:0]din6;
input[width-1:0]din7;
input[width-1:0]din8;
output reg[width-1:0]dout;

reg [3:0]pos0;
reg [3:0]pos1;
reg [3:0]pos2;
reg [3:0]pos3;
reg [3:0]pos4;
reg [3:0]pos5;                
reg [3:0]pos6;
reg [3:0]pos7;
reg [3:0]pos8;
reg [7:0]a,b,c,d,e,f,g,h,i;
reg add_beg;
reg assign_beg;
always@(posedge clk or negedge rst)
begin
if(!rst)
begin
a<=0;
b<=0;
c<=0;      
d<=0;
e<=0;
f<=0;
g<=0;
h<=0;
i<=0;
add_beg<=0;
end
else if(is_juanji_end)begin
a[0]<=(din0<=din1)?1:0;
a[1]<=(din0<=din2)?1:0;
a[2]<=(din0<=din3)?1:0;                          
a[3]<=(din0<=din4)?1:0;
a[4]<=(din0<=din5)?1:0;
a[5]<=(din0<=din6)?1:0;
a[6]<=(din0<=din7)?1:0;
a[7]<=(din0<=din8)?1:0;

b[0]<=(din1<=din0)?1:0;
b[1]<=(din1<=din2)?1:0;
b[2]<=(din1<=din3)?1:0;                          
b[3]<=(din1<=din4)?1:0;
b[4]<=(din1<=din5)?1:0;
b[5]<=(din1<=din6)?1:0;
b[6]<=(din1<=din7)?1:0;
b[7]<=(din1<=din8)?1:0;

c[0]<=(din2<=din0)?1:0;
c[1]<=(din2<=din1)?1:0;
c[2]<=(din2<=din3)?1:0;                          
c[3]<=(din2<=din4)?1:0;
c[4]<=(din2<=din5)?1:0;
c[5]<=(din2<=din6)?1:0;
c[6]<=(din2<=din7)?1:0;
c[7]<=(din2<=din8)?1:0;

d[0]<=(din3<=din0)?1:0;
d[1]<=(din3<=din1)?1:0;
d[2]<=(din3<=din2)?1:0;                          
d[3]<=(din3<=din4)?1:0;
d[4]<=(din3<=din5)?1:0;
d[5]<=(din3<=din6)?1:0;
d[6]<=(din3<=din7)?1:0;
d[7]<=(din3<=din8)?1:0;

e[0]<=(din4<=din0)?1:0;
e[1]<=(din4<=din1)?1:0;
e[2]<=(din4<=din2)?1:0;                          
e[3]<=(din4<=din3)?1:0;
e[4]<=(din4<=din5)?1:0;
e[5]<=(din4<=din6)?1:0;
e[6]<=(din4<=din7)?1:0;
e[7]<=(din4<=din8)?1:0;

f[0]<=(din5<=din0)?1:0;
f[1]<=(din5<=din1)?1:0;
f[2]<=(din5<=din2)?1:0;                          
f[3]<=(din5<=din3)?1:0;
f[4]<=(din5<=din4)?1:0;
f[5]<=(din5<=din6)?1:0;
f[6]<=(din5<=din7)?1:0;
f[7]<=(din5<=din8)?1:0;

g[0]<=(din6<=din0)?1:0;
g[1]<=(din6<=din1)?1:0;
g[2]<=(din6<=din2)?1:0;                          
g[3]<=(din6<=din3)?1:0;
g[4]<=(din6<=din4)?1:0;
g[5]<=(din6<=din5)?1:0;
g[6]<=(din6<=din7)?1:0;
g[7]<=(din6<=din8)?1:0;

h[0]<=(din7<=din0)?1:0;
h[1]<=(din7<=din1)?1:0;
h[2]<=(din7<=din2)?1:0;                          
h[3]<=(din7<=din3)?1:0;
h[4]<=(din7<=din4)?1:0;
h[5]<=(din7<=din5)?1:0;
h[6]<=(din7<=din6)?1:0;
h[7]<=(din7<=din8)?1:0;

i[0]<=(din8<=din0)?1:0;
i[1]<=(din8<=din1)?1:0;
i[2]<=(din8<=din2)?1:0;                          
i[3]<=(din8<=din3)?1:0;
i[4]<=(din8<=din4)?1:0;
i[5]<=(din8<=din5)?1:0;
i[6]<=(din8<=din6)?1:0;
i[7]<=(din8<=din7)?1:0;

add_beg<=1;
end
end
always@(posedge clk or negedge rst)begin
if(!rst)
begin
pos0<=0;
pos1<=0;
pos2<=0;      
pos3<=0;
pos4<=0;
pos5<=0;
pos6<=0;
pos7<=0;
pos8<=0;
assign_beg<=0;
end
else if(add_beg)
begin
pos0<=a[0]+a[1]+a[2]+a[3]+a[4]+a[5]+a[6]+a[7];
pos1<=b[0]+b[1]+b[2]+b[3]+b[4]+b[5]+b[6]+b[7];
pos2<=c[0]+c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7];
pos3<=d[0]+d[1]+d[2]+d[3]+d[4]+d[5]+d[6]+d[7];
pos4<=e[0]+e[1]+e[2]+e[3]+e[4]+e[5]+e[6]+e[7];
pos5<=f[0]+f[1]+f[2]+f[3]+f[4]+f[5]+f[6]+f[7];
pos6<=g[0]+g[1]+g[2]+g[3]+g[4]+g[5]+g[6]+g[7];
pos7<=h[0]+h[1]+h[2]+h[3]+h[4]+h[5]+h[6]+h[7];
pos8<=i[0]+i[1]+i[2]+i[3]+i[4]+i[5]+i[6]+i[7];
assign_beg<=1;
end
end

always@(posedge clk or negedge rst)begin
if(!rst)
dout=0;
else if(assign_beg)
begin
if(pos0==4)
dout<=din0;
else
   if(pos1==4)
    dout<=din1;
    else
        if(pos2==4)
        dout<=din2;
        else
            if(pos3==4)
            dout<=din3;
            else
                if(pos4==4)
                dout<=din4;
                else
                    if(pos5==4)
                    dout<=din5;
                    else
                        if(pos6==4)
                        dout<=din6;
                        else
                            if(pos7==4)
                            dout<=din7;
                            else
                                if(pos8==4)
                            dout<=din8;
                            
end
end
endmodule
