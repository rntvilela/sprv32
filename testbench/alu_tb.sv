module alu_tb;
	reg [2:0] alucontrol;
	reg [31:0] srca;
	reg [31:0] srcb;
	wire zero;
	wire [31:0] aluresult;
	
	localparam ADD = 3'b000;
	localparam SUB = 3'b001;
	localparam SLT = 3'b101;
	localparam OR  = 3'b011;
	localparam AND = 3'b010;

	alu dut (
		.alucontrol(alucontrol),
		.srca(srca),
		.srcb(srcb),
		.zero(zero),
		.aluresult(aluresult)
	);

	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end

	initial begin
		alucontrol=0; srca=0; srcb=0; #10;

		// ADD
		alucontrol=ADD;
		srca=$random; srcb=$random; #10;
		if (aluresult !== (srca + srcb)) $error("Add error!");
		
		// SUB
		alucontrol=SUB;
		srca=$random; srcb=$random; #10;
		if (aluresult !== (srca - srcb)) $error("SUB error!");
		
		// SLT
		alucontrol=SLT;
		srca=$random; srcb=$random; #10;
		if (aluresult !== (srca < srcb)) $error("SLT error!");
		
		// OR
		alucontrol=OR;
		srca=$random; srcb=$random; #10;
		if (aluresult !== (srca | srcb)) $error("OR error!");
		
		// AND
		alucontrol=AND;
		srca=$random; srcb=$random; #10;
		if (aluresult !== (srca & srcb)) $error("AND error!");

		srca=$random; srcb=0; #10;
		if (zero !== 1) $error("Zero flag error!");

		#10 $finish;
	end

endmodule

