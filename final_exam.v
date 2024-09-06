//Q1
module Rotator(Out3, Out2, Out1, In3, In2, In1, rMode);

input [7:0] In3, In2, In1;
input [1:0] rMode;
output reg [7:0] Out1, Out2, Out3;

always@(*) begin
    case(rMode)
        2'd0: begin Out1 = In1; Out2 = In2; Out3 = In3; end
        2'd1: begin Out1 = In2; Out2 = In3; Out3 = In1; end
        2'd2: begin Out1 = In3; Out2 = In1; Out3 = In2; end
        default: begin Out1 = 8'd0; Out2 = 8'd0; Out3 = 8'd0; end
    endcase
end
endmodule

//Q2
module RegisterFile(QA, QB, QC, D, Clk, RAA, RBA, RCA, WE, WA);
input [9:0] RAA, RBA, RCA;
input [9:0] WA;
input Clk, WE;
input [7:0] D;
output reg [7:0] QA, QB, QC;
reg [7:0] MemArray [1023:0];

always@(posedge Clk) begin
    if (WE)
        MemArray[WA]<=D;
end

always@(posedge Clk) begin
    QA<=MemArray[RAA];
    QB<=MemArray[RBA];
    QC<=MemArray[RCA];
end
endmodule

//Q3
module Count2D(XIndex, YIndex, Clk, Reset, En);

parameter COL=50; // COL is smaller than 128, 0<=XIndex<=COL
parameter ROW=25; // ROW is smaller than  64, 0<=YIndex<=ROW  
input  Clk, Reset, En;
output reg [6:0] XIndex;
output reg [5:0] YIndex;

always@(posedge Clk or posedge Reset) begin
    if (Reset) begin
        XIndex <= 7'd0;
        YIndex <= 6'd0;
    end
    else begin
        if (En) begin
            if (XIndex == COL) begin
                XIndex <= 7'd1;
                if (YIndex == ROW)
                    YIndex <= 6'd1;
                else
                    YIndex <= YIndex + 6'd3;
            end
            else begin
                XIndex <= XIndex+1'd1;
                if(YIndex == 6'd0)
                    YIndex <= 6'd1;
                else
                    YIndex <= YIndex;
            end
        end
    end
end

endmodule


//Q4
module RowComparator(MaxValue, MaxPos, Valid, In1, In2, In3, iMode);
input  [7:0] In1,In2, In3; 
input  iMode; 
output reg [7:0] MaxValue;
output reg [1:0] MaxPos;
output reg Valid;

always@(In1 or In2 or In3 or iMode) begin
    if (iMode==0) begin
        if ((In1>=In2) && (In1 >= In3)) begin
            MaxValue=In1;
            MaxPos=2'd1;
            Valid=1'b1;
        end
        else if ((In2>=In1) && (In2 >= In3)) begin
            MaxValue=In2;
            MaxPos=2'd2;
            Valid=1'b1;
        end
        else if ((In3>=In1) && (In3 >= In2)) begin
            MaxValue=In3;
            MaxPos=2'd3;
            Valid=1'b1;
        end
        else begin
            MaxValue=8'd0;
            MaxPos=2'd0;
            Valid=1'b0;
        end
    end
    else begin
        if( In1 >= 0 && In2 >= 0 && In3 >= 0) begin
            MaxValue = In2;
            MaxPos = 2'd2;
            Valid = 1'b1; 
        end
        else begin
            MaxValue = 8'd0;
            MaxPos = 2'd0;
            Valid = 1'b0;
        end
    end
end
endmodule


//Q5
module PatternComparator3x3(MaxValue, MaxRow, MaxCol, Valid, In1_1, In2_1, In3_1, In1_2, In2_2, In3_2, In1_3, In2_3, In3_3, Pattern);
input [7:0] In1_1, In2_1, In3_1;
input [7:0] In1_2, In2_2, In3_2;
input [7:0] In1_3, In2_3, In3_3;
input [1:0] Pattern;

reg R1Mode, R2Mode, R3Mode;
wire [7:0] Max1, Max2, Max3;
wire [1:0] MaxP1, MaxP2, MaxP3;
output reg [7:0] MaxValue;
output reg [1:0] MaxRow, MaxCol;
output reg Valid;


always@(Pattern) begin
    if (Pattern==2'd0) begin
        R1Mode=1'b0;//###
        R2Mode=1'b0;//###
        R3Mode=1'b0;//###
    end
    else if (Pattern==2'd1) begin
        R1Mode=1'b1;// #
        R2Mode=1'b0;//###
        R3Mode=1'b1;// #
    end
    else begin
        R1Mode=1'b1;// #
        R2Mode=1'b1;// #
        R3Mode=1'b1;// #
    end
end

//RowComparator(MaxValue, MaxPos, Valid, In1, In2, In3, iMode)
RowComparator U1(Max1, MaxP1, Valid1, In1_1, In2_1, In3_1, R1Mode);
RowComparator U2(Max2, MaxP2, Valid2, In1_2, In2_2, In3_2, R2Mode);
RowComparator U3(Max3, MaxP3, Valid3, In1_3, In2_3, In3_3, R3Mode);

always@(*) begin
    if (Valid1&Valid2&Valid3) begin
        if ((Max1>=Max2)&&(Max1>=Max3)) begin
            MaxValue=Max1;
            MaxRow=2'd1;
            MaxCol=MaxP1;
            Valid = 1'd1;
        end
        else if ((Max2>=Max1)&&(Max2>=Max3)) begin
            MaxValue=Max2;
            MaxRow=2'd2;
            MaxCol=MaxP2;
            Valid = 1'd1;
        end
        else if((Max3>=Max1)&&(Max3>=Max2)) begin
            MaxValue=Max3;
            MaxRow=2'd3;
            MaxCol=MaxP3;
            Valid = 1'd1;
        end
        else begin
            MaxValue=8'd0;
            MaxRow=2'd0;
            MaxCol=2'd0;
            Valid = 1'd1;
        end
    end
    else begin
        MaxValue=8'd0;
        MaxRow=2'd0;
        MaxCol=2'd0;
        Valid = 1'd0;
    end
end
endmodule

//Q6
module DataFetch(Valid, TopData,MidData, BotData, XIndex, YIndex, En, Clk, Reset, D,WA);
parameter COL=50; // COL is smaller than 128, 0<=XIndex<=COL
parameter ROW=25; // ROW is smaller than  64, 0<=YIndex<=ROW
input Clk, Reset, En;
input [6:0] XIndex;
input [5:0] YIndex;
output reg Valid;
output [7:0] TopData, MidData, BotData;

reg [9:0] Row1Add, Row2Add, Row3Add;
input [9:0] WA;
reg ValidNext;
input [7:0] D;

always@(En or XIndex or YIndex)
begin
    if (En)
    begin
        Row1Add=(XIndex-1)+(YIndex-1)*COL;
        Row2Add=(XIndex-1)+(YIndex)*COL;
        Row3Add=(XIndex-1)+(YIndex+1)*COL;
    end
    else
    begin
        Row1Add=10'd0;
        Row2Add=10'd0;
        Row3Add=10'd0;
    end
end
always@(posedge Clk,posedge Reset)
begin
    if(Reset)
        Valid<=0;
    else
        if(XIndex==1)
            Valid<=1;
        else
            Valid<=Valid;
end
RegisterFile U6_1(.QA(TopData), .QB(MidData), .QC(BotData), .D(D), .Clk(Clk), .RAA(Row1Add), .RBA(Row2Add), .RCA(Row3Add), .WE(1'b1), .WA(WA));

endmodule

//Q7
module MaxSearch2D(MaxValue, MaxXPos, MaxYPos, MaxValid, Clk, Reset, En, Pattern,D,WA,XIndex_out,YIndex_out);
input Clk, Reset, En;
input [1:0] Pattern;
input [7:0] D;//就是input data 全部，好原來你在這裡....
input [9:0] WA;
output [7:0] MaxValue;
output reg[1:0] MaxXPos;
output [1:0] MaxYPos;
output MaxValid;

output [6:0] XIndex_out;
output [5:0] YIndex_out;

wire [6:0] XIndex;
wire [5:0] YIndex;

wire [1:0]MaxXPos_out;
wire Valid, Valid2;
wire [7:0] TopData, MidData, BotData;

reg [7:0]  In2_1, In1_1;
reg [7:0]  In2_2, In1_2;
reg [7:0]  In2_3, In1_3;
reg Valid_tmp1, Valid_tmp2, Valid_tmp3;

wire [7:0] In3_1;
wire [7:0] In3_2;
wire [7:0] In3_3;

assign MaxValid = Valid & Valid_tmp1 & Valid_tmp2 & Valid2;
assign In3_1= TopData;
assign In3_2= MidData;
assign In3_3= BotData;

assign XIndex_out=XIndex;
assign YIndex_out=YIndex;
//PatternComparator3x3(MaxValue, MaxRow, MaxCol, Valid, In1_1, In2_1, In3_1, In1_2, In2_2, In3_2, In1_3, In2_3, In3_3, Pattern);
PatternComparator3x3 U7_1(.MaxValue(MaxValue),.MaxRow(MaxYPos),. MaxCol(MaxXPos_out),.Valid(Valid),.In1_1(In1_1),.In2_1(In2_1),.In3_1(In3_1),.In1_2(In1_2),.In2_2(In2_2),.In3_2(In3_2),.In1_3(In1_3),.In2_3(In2_3),.In3_3(In3_3),.Pattern(Pattern));
//DataFetch(Valid, TopData,MidData, BotData, XIndex, YIndex, En, Clk, Reset, D,WA);
DataFetch U7_2(.Valid(Valid2),.TopData(TopData),.MidData(MidData),.BotData(BotData),.XIndex(XIndex),.YIndex(YIndex),.En(En),.Clk(Clk),.Reset(Reset),.D(D),.WA(WA));
//Count2D(XIndex, YIndex, Clk, Reset, En);
Count2D U7_3(.XIndex(XIndex),.YIndex(YIndex),.Clk(Clk),.Reset(Reset),.En(En));

always@(*)begin
    MaxXPos=MaxXPos_out;
end
always@(posedge Clk, posedge Reset) begin
	if(Reset) begin
		In2_1<= 8'd0;
		In1_1<= 8'd0;
		In2_2<= 8'd0;
		In1_2<= 8'd0;
		In2_3<= 8'd0;
		In1_3<= 8'd0;
		Valid_tmp1 <= 1'b0;
		Valid_tmp2 <= 1'b0;
	end
	else begin
		In2_1<= In3_1;
		In2_2<= In3_2;
		In2_3<= In3_3;
		In1_1<= In2_1;
		In1_2<= In2_2;
		In1_3<= In2_3;
		Valid_tmp1 <= Valid2;
		Valid_tmp2 <= Valid_tmp1;
	end
end
endmodule
