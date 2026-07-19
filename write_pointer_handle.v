`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 23:06:41
// Design Name: 
// Module Name: write_pointer_handle
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
//size of the address bus is 4= adder_size

module write_pointer_handle #(parameter address_size=4)(
    output reg write_full,
    output[address_size-1:0] write_address,
    output reg[address_size :0] write_pointer,
    input[address_size:0] gray_pointer,
    input wr_inc, wrclk, wrst
    );
       reg [address_size:0] write_bin;                     // Binary write pointer
       wire [address_size:0] write_gray_next, write_bin_next;   // Next write pointer in gray and binary code
       wire write_full_val; 
       
    always@(posedge wrclk or negedge wrst)begin
    if(!wrst)
       {write_bin,write_pointer}<=0;
    else
        {write_bin,write_pointer}<={write_bin_next,write_gray_next};
    end
    
   assign write_address = write_bin[address_size-1:0];
   assign write_bin_next = write_bin+(wr_inc & ~write_full);
   assign write_gray_next = (write_bin_next>>1)^write_bin_next; //binary to gray conversion 
   // condition to check if fifo is full or not
   
   assign write_full_val=(write_gray_next=={~gray_pointer[address_size:address_size-1], gray_pointer[address_size-2:0]});
   
   always @(posedge wrclk or negedge wrst) begin
          if (!wrst)            //flag reset
              write_full <= 1'b0;
          else 
              write_full <= write_full_val; //flag update
      end
endmodule
