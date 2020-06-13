module dmem (
	input         clk  ,
	input         we   ,
	input  [31:0] addr ,
	input  [31:0] wdata,
	output [31:0] rdata
);

	reg [31:0] rdata;

	reg [31:0] memdata[63:0];

	initial
	begin
		memdata[0]=5;//n
		memdata[1]=0; //sum

		// array
		memdata[2] = 1;
		memdata[3]=2;
		memdata[4] =3;
		memdata[5] =4;
		memdata[6] = 5;
	end

	always @(memdata[addr]) begin
		rdata = memdata[addr];
	end

	always @(posedge clk) begin
		if(1'b1 == we) begin
			memdata[addr] = wdata;
		end
	end

	initial
	begin
		$monitor("Data: n:%d, sum:%d, a[0]:%d, a[1]:%d, a[2]:%d, a[3]:%d, a[4]:%d",
		memdata[0], memdata[1], memdata[2], memdata[3],
		memdata[4], memdata[5], memdata[6]);
	end
endmodule
