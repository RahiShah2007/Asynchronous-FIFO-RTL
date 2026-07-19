`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 10:09:45
// Design Name: 
// Module Name: tb_Async_FIFO
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


module tb_Async_FIFO();

parameter data_size=8;
parameter address_size=3;
parameter depth =1<<address_size;

reg[data_size-1:0] write_data;
wire[data_size-1:0]read_data;
wire write_full,read_empty;
reg wr_inc , rinc,rclk,wrst,rrst,wrclk;

final_FIFO #(data_size,address_size) asyn_fifo(
    .read_data(read_data),
    .write_data(write_data),
    .write_full(write_full),
    .read_empty(read_empty),
    .wr_inc(wr_inc),
    .rinc(rinc),
    .wrclk(wrclk),
    .rclk(rclk),
    .wrst(wrst),
    .rrst(rrst)
);

integer i=0;
integer j=1;
always#5 wrclk=~wrclk;
always #10 rclk=~rclk;

initial begin
    wrclk=0;
    rclk=0;
    wrst=1;
    rrst=1;
    wr_inc=0;
    rinc=0;
    write_data=0;
    
#40 wrst=0; rrst=0;
#40 wrst=1; rrst=1;
// Case-1 write and read
rinc=1;
for (i=0;i<10;i=i+1)begin
        write_data=$random(j)%256;
        wr_inc=1;
        #10;
        wr_inc=0;
        #10;
    end
//case-2 write full and beyond
rinc=0;
wr_inc=1;
for(i=0;i<depth+3;i=i+1)begin
           write_data = $random(j)%256;
        #10;
    end
    
//case-3 empty read

wr_inc=0;
rinc=1;
for(i=0;i<depth+3;i=i+1)begin
        #20;
    end
    $finish;

end
endmodule
