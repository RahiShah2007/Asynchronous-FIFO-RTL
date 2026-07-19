`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 23:02:25
// Design Name: 
// Module Name: read_pointer_handle_empty_flag
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


module read_pointer_handle_empty_flag #(parameter address_size=4)(
output reg read_empty, output[address_size-1:0] read_address,
output reg[address_size:0] read_pointer,
input[address_size:0] gray_wptr, // synchronised to read the clock domain
input rclk,rrst,rinc
    );
reg[address_size:0] read_bin;
wire[address_size:0] rgray_next,rbin_next;
wire read_empty_value;

always@(posedge rclk or negedge rrst)begin
if(!rrst)
    {read_bin,read_pointer}<=0;
else
    {read_bin,read_pointer}<={rbin_next,rgray_next}; //shifting of data
end

assign read_address = read_bin[address_size-1:0];
assign rbin_next=read_bin+(rinc &~read_empty);
assign rgray_next = (rbin_next >> 1) ^ rbin_next;

assign read_empty_value = (rgray_next == gray_wptr); 

always@(posedge rclk or negedge rrst)begin

if(!rrst)
    read_empty<=1'b1; //reset flag
else
    read_empty<=read_empty_value; //update the empty flag
end

endmodule
