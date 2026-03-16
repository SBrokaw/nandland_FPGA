/*
 * Translate an input integer 0-15 into a seven seg output 0-9, A-F.
 * Also include the decimal point if that boolean is asserted.
 * Go Board seven seg is Active LOW.
 *    --A--
 *   |     |
 *   F     B
 *   |--G--|
 *   E     C
 *   |     |
 *    --D--  ∙DecimalPt
 */

 module seven_seg(
    input [3:0] num,
    output [6:0] segments);

    reg [6:0] segments_hex;

    always @(*) begin
        case( num ) 
            //               segments: ABC_DEFG
            4'h0:    segments_hex = 7'b000_0001;
            4'hf:    segments_hex = 7'b011_1000;
            default: segments_hex = 7'b100_0001;
        endcase
    end

    assign segments = segments_hex;

 endmodule
