`timescale 1ns/1ps

module tb();

  // Testbench signals
  reg [31:0] A, B;
  reg [2:0] ALUcontrol;
  wire [31:0] Result;
  wire [31:0] slt;
  wire V, C, N, Z;

  // Instantiate the DUT (Device Under Test)
  simpleALU dut (
    .A(A),
    .B(B),
    .ALUcontrol(ALUcontrol),
    .Result(Result),
    .slt(slt),
    .V(V),
    .C(C),
    .N(N),
    .Z(Z)
  );

  initial begin
    // Monitor output
    $monitor("time=%0t | A=%d, B=%d, ALUctrl=%b | Result=%d | C=%b V=%b N=%b Z=%b",
              $time, A, B, ALUcontrol, Result, C, V, N, Z);

    // Test cases
    A = 10; B = 5;

    // ADD
    ALUcontrol = 3'b000; #10;

    // SUB
    ALUcontrol = 3'b001; #10;

    // AND
    ALUcontrol = 3'b010; #10;

    // OR
    ALUcontrol = 3'b011; #10;

    // SLT (Set Less Than)
    A = 5; B = 10;
    ALUcontrol = 3'b101; #10;

    // Overflow test: signed addition
    A = 32'h7FFFFFFF; B = 1;
    ALUcontrol = 3'b000; #10;

    // Negative result test
    A = 5; B = 10;
    ALUcontrol = 3'b001; #10;

    // Zero result test
    A = 15; B = 15;
    ALUcontrol = 3'b001; #10;

    $finish;
  end

endmodule
