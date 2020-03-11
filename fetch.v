`timescale 1ns / 1ps

module CPU(clk,reg_memory,main_memory,instr,get);


input clk;
input get;
output reg[31:0] reg_memory;//for obtaining op
wire var1;
output reg[31:0] main_memory;



reg [31:0] reg_mem [0:31];
reg [31:0] pipeline,stored,PC;
reg [7:0] instr_mem [0:1023];
output [31:0] instr;
reg [31:0] data_mem [0:255];

initial begin

//regfile
reg_mem[0] = 0;
reg_mem[2] = 0;

reg_mem[4] = 4;
reg_mem[1] = 20;
reg_mem[3] = 3;
reg_mem[5] = 5;
reg_mem[7] = 7;
reg_mem[8] = 8;

//instr_mem[4] = 8'b00100010;//sub
//instr_mem[5] = 8'b00100000;
//instr_mem[6] = 8'b01000011;    
//instr_mem[7] = 8'b00000000;

//instr_mem[20] = 8'b00111110;//?
//instr_mem[21] = 8'b00000000;
//instr_mem[22] = 8'b01000011;
//instr_mem[23] = 8'b00100000;

//instr_mem[0] = 8'b00100000;//add
//instr_mem[1] = 8'b00100000;
//instr_mem[2] = 8'b01000011;
//instr_mem[3] = 8'b00000000;

//instr_mem[20] = 8'b00111110;//addi
//instr_mem[21] = 8'b00000000;
//instr_mem[22] = 8'b01000011;
//instr_mem[23] = 8'b00100000;


//instr_mem[24] = 8'b11111110;//slti
//instr_mem[25] = 8'b11111111;
//instr_mem[26] = 8'b01000011;
//instr_mem[27] = 8'b00101000;

//instr_mem[8] = 8'b00100100;//and
//instr_mem[9] = 8'b00100000;
//instr_mem[10] = 8'b01000011;
//instr_mem[11] = 8'b00000000;

//instr_mem[12] = 8'b00100101;
//instr_mem[13] = 8'b00100000;//or
//instr_mem[14] = 8'b01000011;
//instr_mem[15] = 8'b00000000;

//instr_mem[16] = 8'b00101010;//slt
//instr_mem[17] = 8'b00100000;
//instr_mem[18] = 8'b01000011;
//instr_mem[19] = 8'b00000000;			

//instr_mem[28] = 8'b00000001;//lw
//instr_mem[29] = 8'b00000000;
//instr_mem[30] = 8'b01000011;
//instr_mem[31] = 8'b10001100;	
		
//instr_mem[40] = 8'b00000000;//beq
//instr_mem[41] = 8'b00000000;
//instr_mem[42] = 8'b01000010;
//instr_mem[43] = 8'b00010000;


//instr_mem[44] = 8'b00100000;//no-op
//instr_mem[45] = 8'b01000000;
//instr_mem[46] = 8'b00000000;
//instr_mem[47] = 8'b00000000;

//instr_mem[36] = 8'b00111110;//ori
//instr_mem[37] = 8'b00000000;
//instr_mem[38] = 8'b01000011;
//instr_mem[39] = 8'b00110100;	

////instr_mem[48] = 8'b00000001;//jal
////instr_mem[49] = 8'b00000000;
////instr_mem[50] = 8'b00000000;
////instr_mem[51] = 8'b00001100;

//instr_mem[32] = 8'b00000001;//sw
//instr_mem[33] = 8'b00000000;
//instr_mem[34] = 8'b01000011;
//instr_mem[35] = 8'b10101100;	

//instr_mem[52] =8'b11111100; //bltz
//instr_mem[53]= 8'b11111111;
//instr_mem[54]= 8'b01000000;
//instr_mem[55]= 8'b00011100;

//instr_mem[4] = 8'b00000100;//sllv r8,r8,r1
//instr_mem[5] = 8'b01000000;
//instr_mem[6] = 8'b01001000;
//instr_mem[7] = 8'b00000000;

//instr_mem[56] = 8'b01000011;//sra
//instr_mem[57] = 8'b00100000;
//instr_mem[58] = 8'b00000010;
//instr_mem[59] = 8'b00000000;

//instr_mem[60] = 8'b01000010;//srl
//instr_mem[61] = 8'b00100000;
//instr_mem[62] = 8'b00000010;
//instr_mem[63] = 8'b00000000;

instr_mem[0]= 8'b00100000;//add r2,r0,r0
instr_mem[1]= 8'b00010000;
instr_mem[2]= 8'b00000000;
instr_mem[3]= 8'b00000000;

instr_mem[4] = 8'b00000011;//beq r1,r0,#3
instr_mem[5]=  8'b00000000;
instr_mem[6] = 8'b00100000;
instr_mem[7] = 8'b00010000;

instr_mem[8] =  8'b00100000;//add r2,r2,r1
instr_mem[9] =  8'b00010000;
instr_mem[10] = 8'b00100010;
instr_mem[11] = 8'b00000000;

instr_mem[12] = 8'b11111111;//addi r1,r1,#-1
instr_mem[13]=  8'b11111111;
instr_mem[14] = 8'b00100001;
instr_mem[15] = 8'b00100000;

instr_mem[16] = 8'b00000001;//j to #4
instr_mem[17] = 8'b00000000;
instr_mem[18] = 8'b00000000;
instr_mem[19] = 8'b00001000;



pipeline = 32'bz;
stored = 32'bz;
PC = 32'b0;			
		

data_mem[7] = 70;
data_mem[0] = 30;
data_mem[1] = 30;
data_mem[5] = 0;
data_mem[6] = 60;
data_mem[2] = 10;
data_mem[8] = 80;
data_mem[3] = 30;
data_mem[4] = 0;



end
wire [29:0] PC_add,PC_jump;
reg [29:0] PC_update_1,PC_update_2;
reg signed [29:0] PC_temp;
wire zero,branch,jump;
wire [25:0] target_addr;
wire [15:0] beq_offset;
wire newvar;


mux21 mux7(zero,branch,jump,var1);
assign PC_jump = {PC[31:28],target_addr[25:0]};
assign newvar = 0;
mux21 mux3(zero,branch,jump,var1);
//assign PC_add = PC[31:2] + 30'd1; 
assign PC_add = PC[31:2]; 
mux21 mux10(zero,branch,jump,var1);
//stored = 32'bz;


always@(PC_add or branch or zero)//BEQ/BNE/BLTZ/BGTZ
begin
if(branch == 1'b1 & zero == 1'b1 & ~newvar)
    begin
        PC_temp = {{14{beq_offset[15]}},beq_offset[15:0]};
        PC_update_1 = PC_add + PC_temp;
       // $monitor("Branching...%d",zero);
    end 
else
    begin
        PC_update_1 = PC_add + newvar+30'b1;
    end

end

//always@(PC_add or branch or zero)//BNE/BLTZ/BGTZ
//begin
//if(branch == 1'b1 & zero == 1'b0 & ~newvar)
//    begin
//        PC_update_1 = PC_add + {{14{beq_offset[15]}},beq_offset[15:0]};
//    end 
//else
//    begin
//        PC_update_1 = PC_add + newvar+30'b1;
//    end
//end

always@(PC_jump | PC_update_1 | jump) //JUMP
begin
if(jump == 1'b1)
begin
PC_update_2 = PC_jump+newvar;
end
else
begin
PC_update_2 = PC_update_1+newvar;
end
//if(jump == 1'b1)
//begin
//PC_update_2 = PC_jump;
//end
//else
//begin
//PC_update_2 = PC_update_1;
    
//end
end

always@(negedge clk)
begin 
stored = 1;
pipeline = {instr_mem[PC+3],instr_mem[PC+2],instr_mem[PC+1],instr_mem[PC]+newvar};
stored = 0;
PC[31:0] = {PC_update_2+newvar,{2{1'b0}}};
end

assign instr = pipeline;


wire mem_regwe,data_memwe,mem_to_reg;
wire [3:0]ALU_op;
wire [4:0] rs,rt,rd;

wire [31:0]imm;
wire alu_src,regdst,ovfl,prev_PC,r_shift;

wire [4:0]shift;

wire [31:0] Rx,R_new,R_d,R_e;
reg [31:0] Ra,Rb,R_temp;
reg [4:0] Rp;
reg [31:0] Rm,Rq;
reg [31:0] par;
wire [31:0] temp_Ra,temp_Rb,Rc;

assign R_d = data_mem[1];
stage2 X(mem_to_reg,instr,branch,jump,data_memwe,mem_regwe,ALU_op,rs,rt,rd,imm,alu_src,regdst,shift,r_shift,beq_offset,target_addr,prev_PC);
assign R_e = data_mem[2];
mux21 mux1(Rx,Ra,Rb,var1);
assign temp_Rb = reg_mem[rt] + newvar; 
assign var1 = 0;
assign temp_Ra = reg_mem[rs]; 



always@(temp_Ra or temp_Rb or imm or alu_src) //for i-type(immediate data)
begin
    Ra = temp_Ra;
    Rq = 32'b0 + newvar;
    R_temp = 32'b0;
    Rb = 32'bz;
    //Rb = alu_src&imm | ~alu_src&temp_Rb;
    if(alu_src == 1'b1) //mux with alu_src as control
    begin
    Rb = imm;
    end
    else if(alu_src == 1'b0)
        Rb = temp_Rb;
end


always@(r_shift or shift or temp_Ra)
begin
Ra <= temp_Ra + newvar;
if(r_shift == 1'b1)
begin
Ra[4:0] <= shift;
Ra[31:5] <= 26'd0;
end
end

assign R_d = data_mem[2];
ALU Y(Ra,Rb,shift,ALU_op,Rc,zero,ovfl); 

assign R_new = data_mem[Rc];

mux21 mux2(Rx,Ra,Rb,var1);
assign R_e = data_mem[1];
assign Rx = data_mem[Rc]; 

always@(negedge clk) //to control writing of data to data_mem
begin
    $monitor("instr in fetch:%b",instr); 
    if(~newvar & data_memwe == 1'b1)
    begin
        R_temp = 32'b1;
        data_mem[Rc] = temp_Rb + newvar;
        main_memory = temp_Rb + newvar;
        //$display("data_mem addr: %d %d %d",Rc,temp_Rb,Rx);
        //$display("below data_mem addr %d %d %d %d %d %d",Ra,Rb,shift,ALU_op,Rc,reg_memory);

    end
end


always@(mem_to_reg or Rx or Rc) //mux with control as mem_to_reg
begin
    Rm = 32'bz;
    par = 0;
    //$monitor("Rm:%d",Rm);
    if(mem_to_reg == 1'b1)
        Rm = Rx+newvar;
        
        //stored <= 0;
    else if(mem_to_reg == 1'b0)
        Rm = Rc+newvar;
end

always@(regdst or rt or rd) //destination registers: mux with control as regdst
begin
    Rp = 5'bz;
    par = 1;
    if(regdst == 1'b1)
    Rp = rd + newvar;
    else if (regdst == 1'b0)
    Rp = rt + newvar;
//Rp = ~regdst&rt | regdst&rd;
end


always@(negedge clk) 
begin
    $monitor("In execute unit:R2:%d R1:%d",reg_mem[2], reg_mem[1]);
    //$monitor("%d %d %d %d %d %d",rs,rt,rd,shift,imm,beq_offset);
    if((mem_regwe == 1'b1))
    begin
    reg_mem[Rp] = Rm + newvar;
    reg_memory = Rm - newvar;
    //$monitor("data_mem: %d",main_memory);
    end
    if ((mem_regwe==1'b1)& (jump==1'b1) & (prev_PC==1'b1)) //jal/j
    begin
        reg_memory = PC+8+newvar;
        reg_mem[31] = PC+8+newvar;
    end
end

endmodule
