module top (
  input clk,
  input reset
);
// PC wires
  wire [31:0] pc, pc_next, pc_plus4;
  
  // Instruction wires
  wire [31:0] instr;
  
  // Decoder wires
  wire [4:0]  rd, rs1, rs2;
  wire [31:0] imm;
  wire [3:0]  alu_ctrl;
  wire        reg_write, alu_src, mem_write, mem_to_reg, branch;
  
  // Register file wires
  wire [31:0] rd_data1, rd_data2;
  
  // ALU wires
  wire [31:0] alu_result;
  wire        zero;
  
  // Data memory wire
  wire [31:0] mem_rd_data;
  
  // Write back wire
  wire [31:0] wr_data;

  // PC + 4
  assign pc_plus4 = pc + 32'd4;
  
  // Next PC — either PC+4 or branch target
  assign pc_next = (branch && zero) ? (pc + (imm << 1)) : pc_plus4;
  
  // Write back — either ALU result or memory data
  assign wr_data = mem_to_reg ? mem_rd_data : alu_result;
  
  // ALU input B — either register or immediate
  wire [31:0] alu_b = alu_src ? imm : rd_data2;

  // Program Counter
  pc pc_inst (
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc(pc)
  );

  // Instruction Memory
  imem imem_inst (
    .addr(pc),
    .instr(instr)
  );

  // Decoder
  decoder dec_inst (
    .instr(instr),
    .rd(rd), .rs1(rs1), .rs2(rs2),
    .imm(imm), .alu_ctrl(alu_ctrl),
    .reg_write(reg_write), .alu_src(alu_src),
    .mem_write(mem_write), .mem_to_reg(mem_to_reg),
    .branch(branch)
  );

  // Register File
  register_file rf_inst (
    .clk(clk),
    .we(reg_write),
    .rd_addr1(rs1), .rd_addr2(rs2),
    .wr_addr(rd), .wr_data(wr_data),
    .rd_data1(rd_data1), .rd_data2(rd_data2)
  );

  // ALU
  alu alu_inst (
    .a(rd_data1),
    .b(alu_b),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
  );

  // Data Memory
  dmem dmem_inst (
    .clk(clk),
    .we(mem_write),
    .addr(alu_result),
    .wr_data(rd_data2),
    .rd_data(mem_rd_data)
  );

endmodule