module tb_pc;
reg clk;
reg reset;
reg  [31:0] pc_next;
  wire [31:0] pc;

pc uut(.clk(clk), .reset(reset), .pc_next(pc_next), .pc(pc));


 initial clk =0;
  always #5 clk = ~clk;

initial begin
    $dumpfile("tb/tb_pc.vcd");
    $dumpvars(0, tb_pc);

//Test reset
reset =1; pc_next= 32'd0; #10;
$display("After reset: pc = %0d (expect 0)", pc);

//release reset, increment by 4
 reset = 0; pc_next = pc + 4; #10;
    $display("After cycle 1: pc = %0d (expect 4)", pc);

    pc_next = pc + 4; #10;
    $display("After cycle 2: pc = %0d (expect 8)", pc);

    pc_next = pc + 4; #10;
    $display("After cycle 3: pc = %0d (expect 12)", pc);

    $finish;
  end

endmodule