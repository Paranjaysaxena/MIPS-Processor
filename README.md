# mips_cpu

A implementation of a 32-bit single cycle MIPS processor in Verilog. This version of the MIPS single-cycle processor can execute the following instructions: add, sub, and, or, slt, lw, sw, beq, addi, and j and syscall.

To tun the test bench:

```
$ iverilog *.v
$ ./a.out; gtkwave dump.vcd
```

Each of the memories is a 64-word × 32-bit array. The instruction memory contains some initial values representing a test program.

## Test MIPS instructions
```
main:
	addi r1 r0 0
	addi r2 r0 0
	addi r4 $gp 0
	lw r3 r4
	addi r5 $gp 8
	addi r10 $gp 4

start:
	beq r1 r3 end
	lw r6 r5
	add r2 r2 r6
	addi r5 r5 4
	addi r1 r1 1
	ja start

end:
	sw r10 r6
	addi r4 r0 10 // (argument for syscall)
	syscall
```

