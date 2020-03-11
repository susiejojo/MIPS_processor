`timescale 1ns / 1ps
module ALU(input [31:0] A, input [31:0] B, input [4:0] shift,input [3:0] ALU_op,output reg [31:0] ALU_out,output reg zero,output reg ovfl);
always@(*)
begin
zero = 1'bz;
ovfl = 1'b0;

case(ALU_op)
4'b0000 : {ovfl,ALU_out} = A + B;
4'b0001 : 
begin
ALU_out = A - B;
if (ALU_out== 32'd0)
begin
zero = 1'b1;
end
else
zero= 1'b0;
end
4'b0010 : ALU_out = A & B;  //AND
4'b0011 : ALU_out = A | B;  //OR
4'b0100 : ALU_out = A ^ B; //XOR
4'b0101 : 
begin
    if (A!==B)
        zero = 1'b1;
end
4'b0110 : ALU_out = ~(A | B); //NOR
4'b0111 : 
begin
ALU_out = $signed(A) > $signed(B); //BGTZ
if (ALU_out)
    zero = 1'b1;
end

4'b1000 : ALU_out = B << shift; //SLL
4'b1001 : ALU_out = B >>> shift; //SRA
4'b1010 : ALU_out = A < B; //SLTU
4'b1011 : ALU_out = B << A; //SLLV
4'b1100 : 
begin
ALU_out = $signed(A) < $signed(B);//SLT/BLTZ
if (ALU_out)
    zero = 1'b1;
end 
4'b1101 : ALU_out = B >>> A; //SRAV
4'b1110 : ALU_out = B >> shift; //SRL
4'b1111 : ALU_out = B >> A; //SRLV
default : ALU_out= 32'bz;
endcase
end
endmodule
