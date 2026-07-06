module tb_register_file;

  reg        clk;
  reg        we;
  reg  [4:0] rd_addr1;
  reg  [4:0] rd_addr2;
  reg  [4:0] wr_addr;
  reg  [31:0] wr_data;
  wire [31:0] rd_data1;
  wire [31:0] rd_data2;

  register_file uut (
    .clk(clk),
    .we(we),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_data1(rd_data1),
    .rd_data2(rd_data2)
  );

  initial clk =0;
  always #5 clk = ~clk;

initial begin
    $dumpfile("tb/tb_register_file.vcd");
    $dumpvars(0, tb_register_file);

    we=0; wr_addr=0; wr_data=0; rd_addr1=0; rd_addr2=0;
    #10;

    // Write 42 into register 1
    we=1; wr_addr=5'd1; wr_data=32'd42; #10;
    we=0; rd_addr1=5'd1; #10;
    $display("rd_data1 = %d", rd_data1);

    // Write 100 into register 5
    we=1; wr_addr=5'd5; wr_data=32'd100; #10;
    we=0; rd_addr1=5'd5; #10;
    $display("rd_data1 = %d", rd_data1);

    // Write to x0 - should always return 0
    we=1; wr_addr=5'd0; wr_data=32'd999; #10;
    we=0; rd_addr1=5'd0; #10;
    $display("Register x0 = %0d (expect 0)", rd_data1);

 $finish;
  end

endmodule

