module simpleALU(A,B,ALUcontrol ,Result,slt ,V,Z,C,N);
   input [31:0] A,B;
    input [2:0] ALUcontrol;
    output [31:0] Result;
    output[31:0]slt;
    output V,C,N,Z;
    wire [31:0]a_and_B;
    wire [31:0]a_or_b;
    wire [31:0] not_b;
    wire Cout ;
    assign a_and_B = A &B;
    assign a_or_b = A | B;
    assign not_b = ~B;

    wire [31:0]mux_1;
    wire[31:0]mux_2;
    wire [31:0]sum ;
    assign mux_1 = (ALUcontrol[0]==0) ? B : not_b;
    assign {Cout,sum} = A + mux_1 + ALUcontrol[0];
    assign slt  ={31'b0000000000000000000000000000000,sum[31]};

    assign mux_2 = (ALUcontrol[3:1]==3'b000) ? sum :
                    (ALUcontrol[3:1]==3'b001) ?sum :
                    (ALUcontrol[3:1]==3'b010) ?a_and_B:
                    (ALUcontrol[3:1]==3'b011) ?a_or_b:
                    (ALUcontrol[3:1]==3'b101) ?slt:
                    32'h0000000;
    assign Result = mux_2;

    /*introducing flags in ALU which will tell :
    1) C - is their any CARRY present 
    2) V - tells the overflow of bits in signed numbers
    3) N - is the number is negative
    4)Z - is the number in output is 000000..;
*/

 

assign Z = (~(Result)) & (Result);
assign N = (Result[31]);

assign C =( Cout &(~(ALUcontrol[1])));
assign V = (~(ALUcontrol[0] ^ A[31] ^ B[31]))&(A[31] ^sum[31] )&(~ALUcontrol[1]);


endmodule