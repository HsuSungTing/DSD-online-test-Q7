//Q1 
module Rotator(Out3, Out2, Out1, In3, In2, In1, rMode);
input [7:0] In3, In2, In1;
input [1:0] rMode;

endmodule


//Q2
module RegisterFile(QA, QB, QC, D, Clk, RAA, RBA, RCA, WE, WA);
// RAA: read A-port Address
// RBA: read B-port Address
// RCA: read C-port Address
// WE: Write Enable
// WA: Write Address

endmodule

//Q3
module Count2D(XIndex, YIndex, Clk, Reset, En);
    parameter COL=50; // COL is smaller than 128, 0<=XIndex<=COL
    parameter ROW=25; // ROW is smaller than  64, 0<=YIndex<=ROW  
    input  Clk, Reset, En;
    

endmodule


//Q4
module RowComparator(MaxValue, MaxPos, Valid, In1, In2, In3, iMode);
    input  [7:0] In1,In2, In3; //Only one maximum exist
    input  iMode; //iMode=0, compare three inputs; iMode=1, send out center input
    

endmodule

//Q5
module PatternComparator3x3(MaxValue, MaxRow, MaxCol, Valid, In1_1, In2_1, In3_1, In1_2, In2_2, In3_2, In1_3, In2_3, In3_3, Pattern);
input [7:0] In1_1, In2_1, In3_1;
input [7:0] In1_2, In2_2, In3_2;
input [7:0] In1_3, In2_3, In3_3;
input [1:0] Pattern;

endmodule

//Q6
module DataFetch(Valid, TopData,MidData, BotData, Xindex, YIndex, En, Clk, Reset);
input Clk, Reset, En;



RegisterFile U6_1();

endmodule


//Q7
module MaxSearch2D(MaxValue, MaxXPos, MaxYPos, MaxValid, Clk, Reset, En, Pattern);


PatternComaparator3x3 U7_1();
DataFetch U7_2();
Count2D U7_3();


endmodule
