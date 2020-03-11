`timescale 1ns / 1ps

module stage2(output reg mem_to_reg,input [31:0] instr,output reg branch,output reg jump,output reg data_memwe,output reg mem_regwe,output reg[3:0]ALU_op,output reg [4:0] rs,
output reg [4:0] rt,output reg [4:0] rd,output reg [31:0]imm,output reg alu_src,output reg regdst,output reg [4:0]shift,output reg r_shift,output reg [15:0]beq_offset,output reg [25:0] target_addr,reg prev_PC);
always@(instr)
begin
    alu_src = 1'bz;
    //sa = 5'd0;
    imm = 32'd0;
    rd = 5'd0;
    regdst = 1'bz;
    rs = 5'd0;
    rt = 5'd0;
   
    
    data_memwe = 1'b0;
    mem_to_reg = 1'bz;
    mem_regwe = 1'b0;
    prev_PC = 1'b0;
    ALU_op = 4'd15;
    branch = 1'b0;
    jump = 1'b0;
    shift = 5'b00000;
    r_shift = 1'b0;
    beq_offset = 16'd0;
    target_addr = 26'd0;

if(instr[31:26] == 6'b000000) //R-type
begin
        alu_src = 1'b0;
        data_memwe = 1'b0;
        mem_to_reg = 1'b0;
        mem_regwe = 1'b1;
        regdst = 1'b1;
        if(instr[5:0] == 6'b100000) //ADD
        begin
        ALU_op = 4'b0000;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b100111) //NOR
        begin
        ALU_op = 4'b0110;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b100010) //SUB
        begin
        ALU_op = 4'b0001;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b100110) //XOR
        begin
        ALU_op = 4'b0100;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b101010) //SLT
        begin
        ALU_op = 4'b1100;
        rt = instr[20:16];
        rs = instr[25:21];
        end
        if(instr[5:0] == 6'b100100) //AND
        begin
        ALU_op = 4'b0010;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b100101) //OR
        begin
        ALU_op = 4'b0011;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b101011) //SLTU
        begin
        ALU_op = 4'b1010;
        rs = instr[25:21];
        rt = instr[20:16];
        end
        if(instr[5:0] == 6'b000000) //SLL
        begin
        ALU_op = 4'b1000;
        //rd = instr[15:11];
        rs = 5'b00000;
        rt = instr[20:16];
        shift = instr[10:6];
        r_shift = 1'b1;
        end
         if(instr[5:0] == 6'b000100) //SLLV
        begin
        ALU_op = 4'b1011;
        rt = instr[20:16];
        rs = instr[25:21];
        end
        if(instr[5:0] == 6'b000011) //SRA
        begin
        rt = instr[20:16];
        shift = instr[10:6];
        ALU_op = 4'b1001;
        //rd = instr[15:11];
        rs = 5'b00000;
        r_shift = 1'b1;
        end
        if(instr[5:0] == 6'b000111) //SRAV
        begin
        ALU_op = 4'b1101;
        rt = instr[20:16];
        rs = instr[25:21];
        end
        if(instr[5:0] == 6'b000010) //SRL
        begin
        shift = instr[10:6];
        rs = 5'b00000;
        r_shift = 1'b1;
        ALU_op = 4'b1110;
        rt = instr[20:16];
        //rd = instr[15:11];

        end
        if(instr[5:0] == 6'b000110) //SRLV
        begin
        ALU_op = 4'b1111;
        //rd = instr[15:11];
        rs = instr[25:21];
        rt = instr[20:16];
        end
rd = instr[15:11];
end

else if(instr[31:26]==6'b001100) //ANDI
begin
ALU_op = 4'b0010;
regdst = 1'b0;
rs = instr[25:21];
imm = {{16{1'b0}},instr[15:0]};
data_memwe = 1'b0;
mem_to_reg = 1'b0;
mem_regwe = 1'b1;
rt = instr[20:16];
alu_src = 1'b1;
end

else if(instr[31:26]==6'b001110) //XORI
begin
ALU_op = 4'b0100;
rs = instr[25:21];
mem_regwe = 1'b1;
regdst = 1'b0;
rt = instr[20:16];
data_memwe = 1'b0;
mem_to_reg = 1'b0;
imm = {{16{1'b0}},instr[15:0]};
alu_src = 1'b1;
end

else if(instr[31:26]==6'b001000) //ADDI
begin
ALU_op = 4'b0000;
rs = instr[25:21];
alu_src = 1'b1;
data_memwe = 1'b0;
regdst = 1'b0;
rt = instr[20:16];
mem_to_reg = 1'b0;
mem_regwe = 1'b1;
imm = {{16{instr[15]}},instr[15:0]};
end

else if(instr[31:26]==6'b001011) //SLTIU
begin
rs = instr[25:21];
data_memwe = 1'b0;
mem_to_reg = 1'b0;
ALU_op = 4'b1010;
mem_regwe = 1'b1;
imm = {{16{instr[15]}},instr[15:0]};
rt = instr[20:16];
alu_src = 1'b1;
regdst = 1'b0;
end

else if(instr[31:26]==6'b001010) //SLTI
begin
ALU_op = 4'b1100;
mem_to_reg = 1'b0;
data_memwe = 1'b0;
rt = instr[20:16];
mem_regwe = 1'b1;
imm = {{16{instr[15]}},instr[15:0]};
regdst = 1'b0;
alu_src = 1'b1;
rs = instr[25:21];
end

else if(instr[31:26]==6'b001101) //ORI
begin
ALU_op = 4'b0011;
rs = instr[25:21];
mem_to_reg = 1'b0;
alu_src = 1'b1;
data_memwe = 1'b0;
regdst = 1'b0;
imm = {{16{1'b0}},instr[15:0]};
rt = instr[20:16];
mem_regwe = 1'b1;
end

else if(instr[31:26]==6'b000100) //BEQ
begin
ALU_op = 4'b0001;
beq_offset[15:0] = instr[15:0];
rs = instr[25:21];
rt = instr[20:16];
branch = 1'b1;
alu_src = 1'b0;

end

else if(instr[31:26]==6'b100011) //LW
begin
ALU_op = 4'b0000;
rs = instr[25:21];
mem_to_reg = 1'b1;
imm = {{16{instr[15]}},instr[15:0]};
rt = instr[20:16];
alu_src = 1'b1;
mem_regwe = 1'b1;
data_memwe = 1'b0;
regdst = 1'b0;
end



else if(instr[31:26]==6'b000101) //BNE
begin
ALU_op = 4'b0101;
rt = instr[20:16];
branch = 1'b1;
rs = instr[25:21];
alu_src = 1'b0;
beq_offset[15:0] = instr[15:0];
end



else if(instr[31:26]==6'b000001) //BLEZ
begin
ALU_op = 4'b1100;
branch = 1'b1;
beq_offset[15:0] = instr[15:0];
rs = instr[25:21];
rt = 4'b0000;
alu_src = 1'b0;
//rt = instr[20:16];
end

else if(instr[31:26]==6'b101011) //SW
begin
ALU_op = 4'b0000;
rs = instr[25:21];
mem_to_reg = 1'bz;
mem_regwe = 1'b0;
rt = instr[20:16];
alu_src = 1'b1;
data_memwe = 1'b1;
imm = {{16{instr[15]}},instr[15:0]};
regdst = 1'bz;
end

else if(instr[31:26]==6'b000111) //BGTZ
begin
rs = instr[25:21];
branch = 1'b1;
beq_offset[15:0] = instr[15:0];
alu_src = 1'b0;
//rt = instr[20:16];
rt = 4'b0000;
ALU_op = 4'b0111;
end

else if(instr[31:26] == 6'b000011)//JAL
begin
mem_regwe = 1'b1;
target_addr[25:0] = instr[25:0];
jump = 1'b1;
prev_PC = 1'b1;
end

else if(instr[31:26] == 6'b000010)//JUMP
begin
target_addr[25:0] = instr[25:0];
jump = 1'b1;
end



end

endmodule
