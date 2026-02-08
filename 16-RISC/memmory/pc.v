module pc (
    input clk,
    input rst_n,
    input [1:0] MUX_output,
    input [6:0] imm,
    input [15:0] alu_out,
    output wire [15:0] nxt_instr
); [cite: 263, 265, 266, 267, 268, 269, 271, 272]

    reg [15:0] current_pc; [cite: 283, 284]
    
    assign nxt_instr = current_pc; [cite: 287]

    wire [15:0] imm_ext = {{9{imm[6]}}, imm[6:0]}; [cite: 291, 292, 294]

    always @(posedge clk or negedge rst_n) begin [cite: 305]
        if (!rst_n) begin [cite: 312]
            current_pc <= 16'h0000; [cite: 316]
        end else begin
            case (MUX_output) [cite: 321]
                2'b00: current_pc <= current_pc + 1; [cite: 322, 323]
                2'b01: current_pc <= current_pc + 1 + imm_ext; [cite: 325]
                2'b10: current_pc <= alu_out; [cite: 326, 327]
                default: current_pc <= current_pc + 1; [cite: 328, 329]
            endcase [cite: 330]
        end
    end

endmodule [cite: 340]