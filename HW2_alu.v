`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////
//
// Module: HW2_alu.v
// Author: EEM216A Student
//         ee216a@gmail.com
//
// Description:
//      ALU for HW2
//
// Parameters:
//      (List parameters and their descriptions here)
//
// Inputs:
//      (List inputs and their descriptions here)
//
// Outputs:
//      (List outputs and their descriptions here)
//
////////////////////////////////////////////////////////////////

module HW2_alu (
    clk_p_i,
    reset_n_i,
    data_a_i,
    data_b_i,
    inst_i,
    data_o
    );

////////////////////////////////////////////////////////////////
//  Inputs & Outputs
input           clk_p_i;
input           reset_n_i;
input   [7:0]   data_a_i;
input   [7:0]   data_b_i;
input   [2:0]   inst_i;

output  [15:0]  data_o;

////////////////////////////////////////////////////////////////
//  reg & wire declarations
wire    [15:0]   out_inst_0; // Set these as lengths 15:0
wire    [15:0]   out_inst_1;
wire    [15:0]   out_inst_2;
wire    [15:0]   out_inst_3;
wire    [15:0]   out_inst_4;
wire    [15:0]   out_inst_5;
wire    [15:0]   out_inst_6;
wire    [15:0]   out_inst_7;

reg     [15:0]   ALU_out_inst;
wire    [15:0]   ALU_d2_w;

reg     [15:0]   ALU_d2_r;

reg     [7:0]    Data_A_o_r;    // Added the following 3 missing registers
reg     [7:0]    Data_B_o_r;
reg     [2:0]    Inst_o_r;

wire    [7:0]    inv;           // Added intermediate stages
wire    [8:0]    twoscomp;

////////////////////////////////////////////////////////////////
//  Combinational Logic
assign ALU_d2_w = ALU_out_inst;
assign data_o = ALU_d2_r;
assign out_inst_0 = Data_A_o_r + Data_B_o_r;    // Configured the ALU to perform proper functions
assign out_inst_1 = Data_A_o_r - Data_B_o_r;
assign out_inst_2 = Data_A_o_r * Data_B_o_r;
assign out_inst_3 = Data_A_o_r & Data_B_o_r;
assign out_inst_4 = Data_A_o_r ^ Data_B_o_r;
assign inv = ~Data_A_o_r;
assign twoscomp = inv + 1;
assign out_inst_5 = {7'b0000000, twoscomp};
assign out_inst_6 = out_inst_1<<2;
assign out_inst_7 = 16'h0000;

// The output MUX
always @(Inst_o_r, Data_A_o_r, Data_B_o_r) begin         // Set triggers to changes in the select or data
    case(Inst_o_r)                                       // Added Inst_o_r as case switch
        3'b000:     ALU_out_inst = out_inst_0;           // Set output to respective combinational logic
        3'b001:     ALU_out_inst = out_inst_1;
        3'b010:     ALU_out_inst = out_inst_2;
        3'b011:     ALU_out_inst = out_inst_3;
        3'b100:     ALU_out_inst = out_inst_4;
        3'b101: begin
                if(Data_A_o_r[7] == 1'b1) begin
                        ALU_out_inst = out_inst_5;
                end
                else begin
                        ALU_out_inst = {8'h00, Data_A_o_r};
                end
        end
        3'b110:     ALU_out_inst = out_inst_6;
        3'b111:     ALU_out_inst = out_inst_7;
        default:    ALU_out_inst = 0;
    endcase
end

////////////////////////////////////////////////////////////////
//  Registers
always @(posedge clk_p_i or negedge reset_n_i) begin
    if (reset_n_i == 1'b0) begin
        ALU_d2_r    <= 16'h0000;        // Configured reset to change everything to 0
        Data_A_o_r  <= 8'h00;
        Data_B_o_r  <= 8'h00;
        Inst_o_r    <= 3'b111;
    end
    else begin
        ALU_d2_r    <= ALU_d2_w;
        Data_A_o_r  <= data_a_i;
        Data_B_o_r  <= data_b_i;
        Inst_o_r    <= inst_i;
    end
end

endmodule
