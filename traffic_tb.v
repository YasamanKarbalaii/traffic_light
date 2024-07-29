`timescale 1ns / 1ps
module traffic_tb;
	reg rst;
	reg clk;
	wire [2:0] light_ew;
	wire [2:0] light_ns;
	traffic uut (
		.rst(rst), 
		.clk(clk), 
		.light_ew(light_ew), 
		.light_ns(light_ns)
	);
	 initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

	initial begin
		rst = 1;
		#20;
		rst = 0;
		#300 $stop;
	end
      
endmodule

