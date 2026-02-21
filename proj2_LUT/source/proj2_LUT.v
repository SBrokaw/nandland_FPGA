// Merrick, R. (2024). The Look-Up Table.
// Getting Started with FPGAs.
// https://nandland.com/project-2-the-look-up-table-lut/

module proj2_LUT(
    input btn0,
    input btn1,
    output LED0);

    assign LED0 = btn0 & btn1;

endmodule
