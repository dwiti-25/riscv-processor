module tb_imem;
reg [31:0] addr;
wire [31:0] instr;

imem uut(.addr(addr), .instr(instr));

initial begin
  $dumpfile("tb/tb_imem.vcd");
  $dumpvars(0, tb_imem);

  addr = 32'd0; #10;
  $display("addr=0: instr=%b", instr);

  addr = 32'd4; #10;
  $display("addr=4: instr=%b", instr);

  addr = 32'd8; #10;
  $display("addr=8: instr=%b", instr);

  $finish;
end

endmodule