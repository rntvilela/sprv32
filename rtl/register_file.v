module register_file (
	input clk,
	input we3,
	input [4:0] a1,
	input [4:0] a2,
	input [4:0] a3,
	input [31:0] wd3,
	output [31:0] rd1,
	output [31:0] rd2
);

	reg [31:0] mem [31:0];

	always @(posedge clk) begin
		if(we3) begin
			mem[a3] <= (a3 == {5{1'b0}})? {32{1'b0}} : wd3;
		end
	end

	assign rd1 = mem[a1];
	assign rd2 = mem[a2];

endmodule

