`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA (Student)
// Engineer: Sander Zuckerman
// 
// Create Date: 10/24/2022 10:34:21 PM
// Design Name: HW3_dp
// Module Name: HW3_dp
// Project Name: HW3
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Created using Vivado
// 
//////////////////////////////////////////////////////////////////////////////////


module HW3_dp(i_clk, i_rst_n, i_data, o_find);
    
    input   i_clk;      // Input Clock
    input   i_rst_n;    // Asynchronous Reset
    input   i_data;     // Input Data
    
    output reg o_find;     // Output signal
    
    reg [2:0] state;
    
    parameter   S0 = 3'b000,    // All possibile states
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100,
                S5 = 3'b101,
                S6 = 3'b110,
                S7 = 3'b111;
                
    always @ (state) begin  // Moore Outputs
        case(state)
            S0: o_find = 1'b0;
            S1: o_find = 1'b0;
            S2: o_find = 1'b0;
            S3: o_find = 1'b0;
            S4: o_find = 1'b0;
            S5: o_find = 1'b0;
            S6: o_find = 1'b0;
            S7: o_find = 1'b1;
            default: o_find = 1'b0;
        endcase
    end
    
    always @ (posedge i_rst_n) begin  // Asynchronous Reset Module
        state <= S0;
    end
                
    always @ (posedge i_clk) begin    // State Machine
        case(state)
            S0: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S1;
            S1: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S2;
            S2: if  (i_data == 1'b0)    state <= S3;
                else                    state <= S2;
            S3: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S4;
            S4: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S5;
            S5: if  (i_data == 1'b0)    state <= S6;
                else                    state <= S2;
            S6: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S7;
            S7: if  (i_data == 1'b0)    state <= S0;
                else                    state <= S5;
            default: state <= S0;
        endcase
    end
        
endmodule
