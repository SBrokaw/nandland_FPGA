/*
 * Translate an input integer 0-15 into a seven seg output 0-9, A-F.
 * Also include the decimal point if that boolean is asserted.
 * Go Board seven seg is Active LOW.
 *    --A[6]--
 *   |        |
 *  F[1]     B[5]
 *   |--G[0]--|
 *  E[2]     C[4]
 *   |        |
 *    --D[3]--  ∙DecimalPt
 */

 module seven_seg(
    input [3:0] num,
    output [6:0] segments);

    reg [6:0] segments_hex;

    always @(*) begin
        case( num ) 
            //               segments: ABC_DEFG
            4'h0:    segments_hex = 7'b000_0001;
            4'h1:    segments_hex = 7'b100_1111;
            4'h2:    segments_hex = 7'b001_0010;
            4'h3:    segments_hex = 7'b000_0110;
            4'h4:    segments_hex = 7'b100_1100;
            4'h5:    segments_hex = 7'b010_0100;
            4'h6:    segments_hex = 7'b010_0000;
            4'h7:    segments_hex = 7'b000_1111;
            4'h8:    segments_hex = 7'b000_0000;
            4'h9:    segments_hex = 7'b000_1100;
            4'ha:    segments_hex = 7'b000_1000;
            4'hb:    segments_hex = 7'b110_0000;
            4'hc:    segments_hex = 7'b111_0010;
            4'hd:    segments_hex = 7'b100_0010;
            4'he:    segments_hex = 7'b011_0000;
            4'hf:    segments_hex = 7'b011_1000;
            default: segments_hex = 7'b100_0001;
        endcase
    end

    assign segments = segments_hex;

 endmodule
