module SAR_algorithm(
    input wire Op,
    input wire Om,
    input wire clk,
    input wire rst,
    output reg [7:0] B,
    output reg [7:0] BN, 
    output reg [7:0] D
);

reg [2:0] counter = 3'b000;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset logic
        B <= 8'b00000000;
        BN <= 8'b11111111;
        D <= 8'b00000000;
        counter <= 3'b000;
    end else begin
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
        
        if (counter == 3'b111) begin // Automatic reset if all bits has benn found
            B <= 8'b00000000;
            BN <= 8'b11111111;
            D <= 8'b00000000;
            counter <= 3'b000;
        end
    end
end

endmodule