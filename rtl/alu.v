module alu (
	input [2:0] alucontrol,
	input [31:0] srca,
	input [31:0] srcb,
	output zero,
	output [31:0] aluresult
);

	localparam ADD = 3'b000;
	localparam SUB = 3'b001;
	localparam SLT = 3'b101;
	localparam OR  = 3'b011;
	localparam AND = 3'b010;

	assign aluresult = (alucontrol == ADD )? srca + srcb :
					   (alucontrol == SUB )? srca - srcb :
					   (alucontrol == SLT )? srca < srcb :
					   (alucontrol == OR  )? srca | srcb :
					   (alucontrol == AND )? srca & srcb : 32'b0;

	assign zero = (aluresult == 32'b0);

endmodule
