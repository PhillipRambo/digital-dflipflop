`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Aarhus Universitet  
// Engineer: Phillip F. Baade-Pedersen
//
// Create Date: 10.04.2024 19:13:47
// Design Name: SAR
// Module Name: SAR_algorithm
// Project Name: SAR ALgorithm
// Target Devices: 65nm EEG front end
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

module SAR_algorithm(
    input wire Op,
    input wire En,
    input wire Om,
    input wire clk,
    input wire rst,
    output reg [6:0] B,
    output reg [6:0] BN, 
    output reg [7:0] D
);

reg [3:0] counter = 4'b0000;

always @(posedge clk, rst) begin
    if (rst) begin
        // Reset logic
        B <= 8'b0000000;
        BN <= 8'b1111111;
        D <= 8'b00000000;
        counter <= 4'b0000;
    end else begin
        if (En) begin
            if (counter != 4'b1000) begin
                // Bit searching logic
                D[counter] <= Op;
                
                if (Op) begin
                    B[counter] <= 1'b1;
                    BN[counter] <= 1'b0;
                end else if (Om) begin 
                    B[counter] <= 1'b0;
                    BN[counter] <= 1'b1;
                end
                
                counter <= counter + 1'b1;         
            end
        end else begin
                B <= 8'b0000000;
                BN <= 8'b1111111;
                D <= 8'b00000000;
                counter <= 4'b0000;
            end
    end
end

endmodule
