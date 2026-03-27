module risc16_processor (
    input wire clk,
    input wire rst_n
);

    wire MUX_alu1, MUX_alu2, MUX_rf, WE_rf, WE_dmem;
    wire [1:0] FUNC_alu, MUX_pc, MUX_tgt;

    wire [15:0] pc_out;
    wire [15:0] instruction;

    wire [2:0] op;
    wire [2:0] rA;
    wire [2:0] rB;
    wire [2:0] rC;
    wire [6:0] imm7;
    wire [9:0] imm10;

    wire [15:0] alu_out;
    wire EQ;

    wire [15:0] reg_out1;
    wire [15:0] reg_out2;

    wire [15:0] mem_out;

    wire [15:0] pc_plus_1;
    assign pc_plus_1 = pc_out + 16'd1;

    assign op    = instruction[15:13];
    assign rA    = instruction[12:10];
    assign rB    = instruction[9:7];
    assign rC    = instruction[2:0];
    assign imm7  = instruction[6:0];
    assign imm10 = instruction[9:0];

    pc pc_unit (
        .clk(clk),
        .rst_n(rst_n),
        .MUX_output(MUX_pc),
        .imm(imm7),
        .alu_out(alu_out),
        .nxt_instr(pc_out)
    );

    instruction_memory imem_unit (
        .address(pc_out),
        .instruction(instruction)
    );

    control control_unit (
        .op(op),
        .FUNC_alu(FUNC_alu),
        .MUX_alu1(MUX_alu1),
        .MUX_alu2(MUX_alu2),
        .MUX_pc(MUX_pc),
        .MUX_rf(MUX_rf),
        .MUX_tgt(MUX_tgt),
        .WE_rf(WE_rf),
        .WE_dmem(WE_dmem)
    );

    register_file rf_unit (
        .clk(clk),
        .rA(rA),
        .rB(rB),
        .rC(rC),
        .alu_out(alu_out),
        .mem_out(mem_out),
        .pc_plus_1(pc_plus_1),
        .MUX_tgt(MUX_tgt),
        .MUX_rf(MUX_rf),
        .WE_rf(WE_rf),
        .reg_out1(reg_out1),
        .reg_out2(reg_out2)
    );

    alu alu_unit (
        .src1_reg(reg_out1),
        .src2_reg(reg_out2),
        .imm(imm10),
        .MUX_alu1(MUX_alu1),
        .MUX_alu2(MUX_alu2),
        .FUNC_alu(FUNC_alu),
        .alu_out(alu_out),
        .EQ(EQ)
    );

    data_memory dmem_unit (
        .clk(clk),
        .WE_dmem(WE_dmem),
        .address(alu_out),
        .data_in(reg_out2),
        .data_out(mem_out)
    );

endmodule