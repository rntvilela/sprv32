module alu (
	input [2:0] alucontrol,
	input [31:0] srca,
	input [31:0] srcb,
	output zero,
	output reg [31:0] aluresult
);

	localparam ADD = 3'b000;
	localparam SUB = 3'b001;
	localparam SLT = 3'b101;
	localparam OR  = 3'b011;
	localparam AND = 3'b010;

	always @(*) begin
		case(alucontrol)
			ADD : aluresult = srca + srcb;
			SUB : aluresult = srca - srcb; 
			SLT : aluresult = srca < srcb;
			OR  : aluresult = srca | srcb;
			AND : aluresult = srca & srcb; 
			default : aluresult = 32'b0;
		endcase
	end

	assign zero = (aluresult == 32'b0);

endmodule
