/* 
 * Merrick, R. (2024). Seven Segment Display.
 * Getting Started with FPGAs.
 * https://nandland.com/project-5-seven-segment-display/
 *
 * Increment a Binary Counter to Drive One Digit of the 7-Segment 
 * Display Each Time a Switch is Released.
 */

 module proj5_seven_seg(
    input clk,
    input raw_btn0,
    input raw_btn1,
    output LED0,
    output [6:0] segments);

    // debounce buttons
    wire btn0;
    wire btn1;
    debounce_btn db0( .clk(clk), .btn(raw_btn0), .db_btn(btn0));
    debounce_btn db1( .clk(clk), .btn(raw_btn1), .db_btn(btn1));

    // form seven segment input
    reg [3:0] num;
    always @(posedge clk) begin
        case( btn0 )
            0: num = 4'hf;
            1: num = 4'h0;
            default: num = 4'h1;
        endcase
    end

    // seven segment output
    seven_seg ss0( .num(num), .segments(segments));
    assign LED0 = btn0;

 endmodule
