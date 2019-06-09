module program_counter(out,in,clock);
 
input [31:0] in;
input clock;

output reg [31:0] out;


initial begin
	out <= 32'b0;
end


always @(posedge clock)
begin
	out <= in;
end

endmodule