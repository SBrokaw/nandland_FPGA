// Merrick, R. (2024). The Flip-Flop (aka Register).
// Getting Started with FPGAs.
// https://nandland.com/project-3-the-flip-flop-aka-register/

module proj3_first_register(
    input clk,
    input btn0,
    output LED0);

    always @(posedge clk) begin
        assign LED0 = btn0;
    end

endmodule
