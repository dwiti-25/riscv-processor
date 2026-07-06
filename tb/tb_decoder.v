module tb_decoder;

  reg  [31:0] instr;
  wire [4:0]  rd, rs1, rs2;
  wire [31:0] imm;
  wire [3:0]  alu_ctrl;
  wire        reg_write, alu_src, mem_write, mem_to_reg, branch;

  decoder uut (
    .instr(instr),
    .rd(rd), .rs1(rs1), .rs2(rs2),
    .imm(imm), .alu_ctrl(alu_ctrl),
    .reg_write(reg_write), .alu_src(alu_src),
    .mem_write(mem_write), .mem_to_reg(mem_to_reg),
    .branch(branch)
  );

  initial begin
    $dumpfile("tb/tb_decoder.vcd");
    $dumpvars(0, tb_decoder);

    // ADD x3, x1, x2
    instr = 32'b0000000_00010_00001_000_00011_0110011; #10;
    $display("ADD: rd=%0d rs1=%0d rs2=%0d alu_ctrl=%b reg_write=%b", rd, rs1, rs2, alu_ctrl, reg_write);

    // ADDI x1, x0, 10
    instr = 32'b000000001010_00000_000_00001_0010011; #10;
    $display("ADDI: rd=%0d rs1=%0d imm=%0d alu_ctrl=%b alu_src=%b", rd, rs1, imm, alu_ctrl, alu_src);

    $finish;
  end

endmodule