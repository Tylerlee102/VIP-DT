module instruction_memory (
    input wire [15:0] address,
    output wire [15:0] instruction
); 

    reg [15:0] memory [0:65535]; 
    assign instruction = memory[address]; 

    integer i; [cite: 204]
    initial begin [cite: 205]
        for (i = 0; i <= 65535; i = i + 1) begin 
            memory[i] = 16'h0000; 
        end

        $readmemh("program.mem", memory); [cite: 218, 220]
    end

endmodule 