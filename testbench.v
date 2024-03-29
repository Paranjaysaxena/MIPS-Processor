`resetall
// `timescale 1ns/10ps

`define CLKP 10 // clock period
`define CLKPDIV2 5 // clock period divided by 2

module tb;

    reg clock;
    reg reset;

    //clk, reset, pc, instr, aluout, writedata, memwrite, and readdata

    main main_circuit (.clk(clock), .reset(reset));

    // generate clock
    always begin
        #`CLKPDIV2 clock = ~clock;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, main_circuit);
    end

    initial begin
        $display("Contents of registers:");
        $display("r6-ith element,r1 index, r2 sum, r3 n (gp), r5 address of ith element, r10 address of sum (gp +4)\n\n");
        // initialize all variables
        clock = 0; reset = 1;
        // wait for first negative edge before de-asserting reset
        @(negedge clock) reset = 0;
    end

endmodule
