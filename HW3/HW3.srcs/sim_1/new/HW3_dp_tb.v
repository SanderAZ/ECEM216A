`timescale 1ns / 1ps

module HW3_dp_tb();

    reg clk;
    reg rst;
    reg data;
    wire o_find;
    
    parameter period = 8'd50;
    
    always begin    // Clock Gen
        clk = 1'b0;
        #(period/2) clk = 1'b1;
        #(period/2);
    end
    
    HW3_dp uut (clk, rst, data, o_find);
    
    initial begin
        data = 0;
        #period
        #period
        #10 data = 1;
        #period data = 1;
        #period data = 0;
        #period data = 1;
        #period data = 1;
        #period data = 0;
        #period data = 1;
        #period data = 1;
        #period data = 0;
        #period data = 1;
        #period rst = 1;
        #period rst = 0; data = 1;
        #period data = 1;
        #period data = 0;
        #period data = 1;
        #period data = 1;
        #period data = 0;
        #period data = 1;
    end
    
endmodule
