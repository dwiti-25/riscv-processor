module tb_alu;

    reg[31:0] a,b;
    reg[3:0] alu_ctrl;
    wire[31:0] result;
    wire zero;

alu uut (.a(a), .b(b), .alu_ctrl(alu_ctrl), .result(result), .zero(zero));

initial begin
    $dumpfile("tb/tb_alu.vcd");
    $dumpvars(0, tb_alu);

    // ADD: 15 + 10 = 25
    a = 32'd15; b = 32'd10; alu_ctrl = 4'b0000; #10;
    $display("ADD: %0d + %0d = %0d", a, b, result);

    // SUB: 15 - 10 = 5
    a = 32'd15; b = 32'd10; alu_ctrl = 4'b0001; #10;
    $display("SUB: %0d - %0d = %0d", a, b, result);

    // AND
    a = 32'hFF00; b = 32'h0FF0; alu_ctrl = 4'b0010; #10;
    $display("AND: %h & %h = %h", a, b, result);

    // SLT: 5 < 10 = 1
    a = 32'd5; b = 32'd10; alu_ctrl = 4'b0101; #10;
    $display("SLT: %0d < %0d = %0d (expect 1)", a, b, result);

    $finish;
  end

endmodule


