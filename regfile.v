module regfile (
	input         clk  ,
	//
	input  [ 4:0] addr1,
	input  [ 4:0] addr2,
	input  reg_write   ,
	input  [ 4:0] addr3,
	input  [31:0] wdata,
	//
	output [31:0] data1,
	output [31:0] data2
);

	reg [31:0] regmem[31:0];
	reg [31:0] data1       ;
	reg [31:0] data2       ;

	always @(addr1 or regmem[addr1]) begin
		if (0 == addr1) begin
			data1 = 0;
		end
		else if(24 ==addr1)
		begin
			data1=0;
		end
		else begin
			data1 = regmem[addr1];
		end
	end

	always @(addr2 or regmem[addr2]) begin
		if (0 == addr2) begin
			data2 = 0;
		end
		else if(24 ==addr2)
		begin
			data2=0;
		end
		else begin
			data2 = regmem[addr2];
		end
	end

	always@ (negedge clk) begin
		if(1'b1 == reg_write) begin
			regmem[addr3] = wdata;
		end
	end

	always @(addr1 or addr2 or reg_write or addr3 or wdata)
	begin
		$display("Change in reg file input: addr1:%d, addr2:%d, addr3:%d, reg_write:%d, wdata:%d", addr1, addr2, addr3, reg_write, wdata);
		#1 $display("Output of the register file: data1:%d, data2:%d", data1, data2);
	end

	always @(posedge clk)
	begin
		$display("\n\n-----------------------------------REGISTERS------------------------------------");
		$display("r1:%d, r2:%d, r3:%d, r4:%d, r5:%d, r6:%d, r10:%d",regmem[1], regmem[2], regmem[3], regmem[4], regmem[5], regmem[6], regmem[10]);
		$display("\n\n");
	end
endmodule
