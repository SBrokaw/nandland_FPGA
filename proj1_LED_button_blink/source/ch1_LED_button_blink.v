// Merrick, Russel (2024). Button Blink LEDs.
// Getting Started with FPGAs.
// https://nandland.com/project-1-your-first-go-board-project/

module ch1_LED_button_blink
    (input btn0,
     input btn1,
     input btn2,
     input btn3,
     output LED0,
     output LED1,
     output LED2,
     output LED3
    );

    assign LED0 = btn0;
    assign LED1 = btn1;
    assign LED2 = btn2;
    assign LED3 = btn3;

endmodule
