`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:11 07/24/2015 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top( input BTNU,
				input GCLK,
				output [7:0] LD
           );
wire clk,rst;
reg[7:0]   LD_reg;	//输出寄存器
reg[31:0]  cnt;		//流水灯延时寄存器

assign clk = GCLK;	//外部时钟输入（参考约束文件）
assign rst =~ BTNU;	//复位
assign LD = LD_reg;  //输出寄存器输出到引脚

always@(posedge clk or negedge rst)begin
	if(rst == 1'b0)begin			//接收到复位信号
		LD_reg <= 8'b1000_000;	//输出寄存器复位
		cnt <= 32'b0;				//延时计数器清零
	end
	else begin
		if(cnt == 32'd25000000)begin	//寄存器值达到25000000，寄存器清零，灯流动一位
			cnt <= 32'b0;
			LD_reg <= (LD_reg>>1)|(LD_reg<<7);
		end
		else begin
			cnt <= cnt + 32'b1;
		end
	end
end					
endmodule
