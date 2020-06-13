# mips_cpu

A implementation of a 32-bit single cycle MIPS processor in Verilog. This version of the MIPS single-cycle processor can execute the following instructions: add, sub, and, or, slt, lw, sw, beq, addi, and j and syscall.

To tun the test bench:

```
$ iverilog *.v
$ ./a.out; gtkwave dump.vcd
```

Each of the memories is a 64-word × 32-bit array. The instruction memory contains some initial values representing a test program.
