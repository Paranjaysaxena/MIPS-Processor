module control_unit (
	input  [31:0] instr     ,
	// other side
	output        branch    ,
	output        jump      ,
	output        mem_to_reg,
	output        mem_write ,
	output        reg_dst   ,
	output        reg_write ,
	// alu side
	output [ 2:0] alucontrol,
	output        alu_src
);

	wire is_syscall;
	assign is_syscall = ((opcode == 6'b001100));
	wire [5:0] opcode;
	assign opcode = instr[31:26];

	wire [5:0] func;
	assign func = instr[5:0];

	wire is_add = ((opcode == 6'h00) & (func == 6'h20));
	wire is_sub = ((opcode == 6'h00) & (func == 6'h22));
	wire is_and = ((opcode == 6'h00) & (func == 6'h24));
	wire is_or  = ((opcode == 6'h00) & (func == 6'h25));
	wire is_slt = ((opcode == 6'h00) & (func == 6'h2A));

	wire is_lw = (opcode == 6'h23);
	wire is_sw = (opcode == 6'h2B);

	wire is_beq  = (opcode == 6'h04);
	wire is_addi = (opcode == 6'h08);
	wire is_j    = (opcode == 6'h02);

	assign branch     = is_beq;
	assign jump       = is_j;
	assign mem_to_reg = is_lw;
	assign mem_write  = is_sw;
	assign reg_dst    = is_add | is_sub | is_and | is_or | is_slt;
	assign reg_write  = is_add | is_sub | is_and | is_or | is_slt | is_addi | is_lw;
	assign alu_src    = is_addi | is_lw | is_sw;

	always @(opcode)
	begin
		if ( 6'b001100 == opcode)
		begin
			$finish;
		end
	end

	reg [2:0] alucontrol;

	always @(instr) begin
		casex ({instr[31:26], instr[5:0]})
			12'b000100xxxxxx : alucontrol = 3'b110;
			12'b001010xxxxxx : alucontrol = 3'b111;
			12'b001000xxxxxx : alucontrol = 3'b010;
			12'bxxxxxx100000 : alucontrol = 3'b010;
			12'bxxxxxx100010 : alucontrol = 3'b110;
			12'bxxxxxx100100 : alucontrol = 3'b000;
			12'bxxxxxx100101 : alucontrol = 3'b001;
			12'bxxxxxx101010 : alucontrol = 3'b111;
			default          : alucontrol = 3'b010;
		endcase
	end
	
	always @(instr)
    begin
        #1 $display("Output of the new instruction in controller: branch:%d, jump:%d, mem_to_reg:%d, mem_write:%d, reg_dst:%d, reg_write:%d, alucontrol:%b, alu_src:%d", branch, jump, mem_to_reg, mem_write, reg_dst, reg_write, alucontrol, alu_src);
    end

endmodule