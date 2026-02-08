module instruction_memory (
    input wire [15:0] address,
    output wire [15:0] instruction
); [cite: 135, 136, 137]

    reg [15:0] memory [0:65535]; [cite: 147]

    assign instruction = memory[address]; [cite: 193]

    integer i; [cite: 204]
    initial begin [cite: 205]
        for (i = 0; i <= 65535; i = i + 1) begin [cite: 206]
            memory[i] = 16'h0000; [cite: 206]
        end

        $readmemh("program.mem", memory); [cite: 218, 220]
    end

endmodule [cite: 222]