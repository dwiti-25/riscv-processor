module tb_top;

  reg clk;
  reg reset;

  top uut (.clk(clk), .reset(reset));

  initial clk = 0;
  always #5 clk = ~clk;

 initial begin
    $dumpfile("tb/tb_top.vcd");
    $dumpvars(0, tb_top);

    reset = 1; #10;
    reset = 0; #300;

    $display("x1 = %0d (expect 10)", uut.rf_inst.registers[1]);
    $display("x2 = %0d (expect 20)", uut.rf_inst.registers[2]);
    $display("x3 = %0d (expect 30)", uut.rf_inst.registers[3]);
    $display("x4 = %0d (expect 30)", uut.rf_inst.registers[4]);
    $finish;
  end

endmodule