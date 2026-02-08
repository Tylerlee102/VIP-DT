module pc (
    input clk,
    input rst_n,
    input [1:0] MUX_output,
    input [6:0] imm,
    input [15:0] alu_out,
    output wire [15:0] nxt_instr
); 

    reg [15:0] current_pc; 
    
    assign nxt_instr = current_pc; 

    wire [15:0] imm_ext = {{9{imm[6]}}, imm[6:0]}; 

    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin 
            current_pc <= 16'h0000; 
        end else begin
            case (MUX_output) 
                2'b00: current_pc <= current_pc + 1; 
                2'b01: current_pc <= current_pc + 1 + imm_ext; 
                2'b10: current_pc <= alu_out; 
                default: current_pc <= current_pc + 1; 
            endcase [cite: 330]
        end
    end

endmodule [cite: 340]