`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 22:52:26
// Design Name: 
// Module Name: final_FIFO
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


module final_FIFO #(parameter data_size=8,parameter  address_size=4)
(
    output[data_size-1:0]read_data,
    output write_full,
    output read_empty,
    input[data_size-1:0] write_data,
    input wr_inc,wrclk,wrst,
    input rinc,rclk,rrst
);
wire[address_size-1:0] write_address,read_address;
wire[address_size:0] write_pointer,read_pointer,gray_pointer,gray_wptr;
tw0_ff #(address_size+1) sync_read_to_write(
    .Qb(gray_pointer),
    .Din(read_pointer),
    .clk(wrclk),
    .rst(wrst)
);

tw0_ff #(address_size+1) sync_write_to_read(
    .Qb(gray_wptr),
    .Din(write_pointer),
    .clk(rclk),
    .rst(rrst)
);

FIFO_memory #(data_size,address_size) fifo_memory(
    .read_data(read_data),
    .write_data(write_data),
    .write_address(write_address),
    .read_address(read_address),
    .wrclk_enable(wr_inc),
    .write_full(write_full),
    .wrclk(wrclk)
);

read_pointer_handle_empty_flag #(address_size) rphef(
    .read_empty(read_empty),
    .read_address(read_address),
    .read_pointer(read_pointer),
    .gray_wptr(gray_wptr),
    .rinc(rinc),
    .rclk(rclk),
    .rrst(rrst)
);

write_pointer_handle #(address_size) wptr(
    .write_full(write_full),
    .write_address(write_address),
    .write_pointer(write_pointer),
    .gray_pointer(gray_pointer),
    .wr_inc(wr_inc),
    .wrclk(wrclk),
    .wrst(wrst)    
);
endmodule
