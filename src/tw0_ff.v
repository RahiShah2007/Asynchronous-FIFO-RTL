`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 23:46:03
// Design Name: 
// Module Name: tw0_ff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tw0_ff #(parameter size=4)(
    input[size-1:0]Din,
    input clk,rst,
    output reg[size-1:0]Qb
    );
    reg[size-1:0] Qa;
    always@(posedge clk or negedge rst)begin
        if(!rst)
            {Qb,Qa}<=0; //reset the fifo
        else
            {Qb,Qa}<={Qa,Din}; //data shifting
    end
endmodule
