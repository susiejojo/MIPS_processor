# MIPS processor:

A simple MIPS processor implemented using Verilog capable of supporting basic I,J and R type instructions. Built using Xilinx Vivado 2019.1

### Main memory Design:

#### - Harvard style memory design:
    separate data and instruction memory
#### - Data memory:
    256*4= 1024 bytes = 1KB consisting of 256 32-bit registers.
    Addressing is word-aligned.
#### - Instruction memory: 
    1024 bytes = 1 KB consisting of 1024 8-bit registers. 
    Addressing is byte-aligned. Each instruction is of 4 bytes.

### Instructions supported:

#### - R-type:
    ◦ADD
    ◦SUB
    ◦AND
    ◦OR
    ◦NOR
    ◦XOR
    ◦SLT
    ◦SLTU
    ◦SRL
    ◦SRLV
    ◦SRA
    ◦SRAV
    ◦SLL
    ◦SLLV

#### - I-type:
    ◦ADDI
    ◦ORI
    ◦ANDI
    ◦XORI
    ◦SLTI
    ◦SLTIU
    ◦BEQ
    ◦BNE
    ◦BLTZ
    ◦BGTZ
    ◦LW
    ◦SW
#### - J-type:
    ◦J
    ◦JAL

### Instructions not supported:

Certain R-type instructions haven’t been implemented such as
NAND, XNOR etc. Also, more complex instructions like MUL, DIV,
move operations and trap instructions cannot be run on our simple
processor.

### Processor clock frequency:

Clock period = 100 ns = 10^(-8)s

So, clock frequency = 10^8 Hz = 100 MHz

### Other notable features:

#### - 2-stage pipeline: 
    A register between the fetch and the decode/exe stage stores the fetched instruction.
#### - No -Op instruction:
    Branch involves a No-Op instruction after the branch statement as due to the 2-stage pipeline, in the same clock cycle in which the Branch instruction is executed, the No-Op instruction is fetched and it doesn’t affect the overall running of the processor.
#### - CPI : 
    N+1/N where N is the no. Of instructions to be executed.
    CPI tends to 1 as N becomes very large.
### Tests performed:
    Sum of n numbers
    HCF of 2 numbers
