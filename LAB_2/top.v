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
reg[7:0]   LD_reg;	//����Ĵ���
reg[31:0]  cnt;		//��ˮ����ʱ�Ĵ���

assign clk = GCLK;	//�ⲿʱ�����루�ο�Լ���ļ���
assign rst =~ BTNU;	//��λ
assign LD = LD_reg;  //����Ĵ������������

always@(posedge clk or negedge rst)begin
	if(rst == 1'b0)begin			//���յ���λ�ź�
		LD_reg <= 8'b1000_000;	//����Ĵ�����λ
		cnt <= 32'b0;				//��ʱ����������
	end
	else begin
		if(cnt == 32'd25000000)begin	//�Ĵ���ֵ�ﵽ25000000���Ĵ������㣬������һλ
			cnt <= 32'b0;
			LD_reg <= (LD_reg>>1)|(LD_reg<<7);
		end
		else begin
			cnt <= cnt + 32'b1;
		end
	end
end					
endmodule
