module register_file_tb;
	reg clk;
	reg we3;
	reg [4:0] a1;
	reg [4:0] a2;
	reg [4:0] a3;
	reg [31:0] wd3;
	wire [31:0] rd1;
	wire [31:0] rd2;
	
	reg [31:0] data;

	register_file dut (
		.clk(clk),
		.we3(we3),
		.a1(a1),
		.a2(a2),
		.a3(a3),
		.wd3(wd3),
		.rd1(rd1),
		.rd2(rd2)
	);

	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end

	always #5 clk=~clk;


	initial begin
		clk=0; we3=0; a1=0; a2=0; a3=0; wd3=0; #10;

		data=$random;
		write(0, data);
		read(0);
		if (rd1 !== 0 || rd2 !== 0) $error("Error in R0");
		
		data=$random;
		write(1, data);
		read(1);
		if (rd1 !== data || rd2 !== data) $error("Error in R1");
		
		data=$random;
		write(31, data);
		read(31);
		if (rd1 !== data || rd2 !== data) $error("Error in R31");

		#30 $finish;
	end

	task write (
		input [4:0] addr,
		input [31:0] data
	);
		begin
			@(negedge clk) we3=1; a3=addr; wd3=data;
			@(negedge clk) we3=0; a3=0; wd3=0;
		end
	endtask
	
	task read (
		input [4:0] addr
	);
		begin
			@(posedge clk) a1=addr; a2=addr;
		end
	endtask
endmodule

