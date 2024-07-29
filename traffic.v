`timescale 1ns / 1ps
module traffic(
    input rst,
	 input clk,
	 output reg [2:0] light_ew,
	 output reg [2:0] light_ns
    );
	 reg [1:0] green = 2'b00;
	 reg [1:0] yellow = 2'b01;
	 reg [1:0] red = 2'b10;
	 reg [1:0] state_ns;
	 reg [1:0] state_ew;
	 reg [3:0] g_time = 4'b1010;
	 reg [3:0] y_time = 4'b0010;
	 reg [3:0] r_time = 4'b1100;
	 reg [3:0] counter;
	 always @(posedge clk or posedge rst)begin
	    if(rst)begin
		    counter = 0;
			 state_ns = green;
			 state_ew = red;
		 end else begin
		    counter = counter + 1;
			 case(state_ns)
			   green : if(counter >= g_time)begin
				   state_ns = yellow;
					counter = 0;
				end
				yellow : if(counter >= y_time)begin
				   state_ns = red;
					state_ew = green;
					counter = 0;
				end
				red : if(counter < r_time && counter > g_time)
					state_ew = yellow;
					else if(counter >= r_time)begin
					 state_ns = green;
					 state_ew = red;
					 counter = 0;
					end
			endcase
		end
	end
   always @(state_ns or state_ew)begin
	  case(state_ns)
	    green : light_ns = 3'b001;
		 yellow : light_ns = 3'b010;
		 red : light_ns = 3'b011;
	 endcase
	 case(state_ew)
	   green : light_ew = 3'b001;
		yellow : light_ew = 3'b010;
		red : light_ew = 3'b011;
	 endcase
   end
endmodule
