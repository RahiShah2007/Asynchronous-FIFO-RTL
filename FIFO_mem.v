`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 22:41:06
// Design Name: 
// Module Name: FIFO_memory
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


module FIFO_memory #(parameter Data_Size=8,parameter address_size=4)
(
    output[Data_Size-1:0] read_data,
    input[Data_Size-1:0] write_data,
    input[address_size-1:0] write_address,read_address,
    input wrclk_enable,write_full,wrclk
);
localparam depth=1<<address_size;
reg[Data_Size-1:0] memory[0:depth-1];
assign read_data = memory[read_address];



always@(posedge wrclk)
    if(wrclk_enable && !write_full) memory[write_address]<=write_data;
endmodule
