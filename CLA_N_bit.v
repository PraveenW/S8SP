module CLA_N_bit (in1,in2,sum,cin,cout);
parameter N=4;
input [N-1 :0 ] in1,in2;
input cin;
output [N-1 : 0] sum;
output cout;

reg [N : 0] c;

integer i;
always @(*)
begin
c[0] = cin;
for (i=0; i<N; i=i+1) begin:CARRY_BLK
c[i+1] = (in1[i] & in2[i]) | ((in1[i] ^ in2[i]) & c[i]);
end
end

genvar j;
generate
	for( j=0; j<N; j=j+1) begin:SUM_BLK
	xor u1 (sum[j],c[j],in1[j],in2[j]);
	end
endgenerate

assign cout = c[N];

endmodule

