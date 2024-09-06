`timescale 1ns / 0.1ps
module test_exam;
reg Clk, Reset, En;
reg [1:0] Pattern;
reg [7:0] D;//就是input data 全部，好原來你在這裡....
reg [9:0] WA;
wire [7:0] MaxValue;
wire [1:0] MaxXPos;
wire [1:0] MaxYPos;
wire MaxValid;

wire [6:0] XIndex_out;
wire [5:0] YIndex_out;

MaxSearch2D U0(.MaxValue(MaxValue),.MaxXPos(MaxXPos), .MaxYPos(MaxYPos), .MaxValid(MaxValid),.Clk(Clk),.Reset(Reset),.En(En),.Pattern(Pattern),.D(D),.WA(WA),.XIndex_out(XIndex_out),.YIndex_out(YIndex_out));

always 
    #5 Clk=~Clk;
initial begin
    Reset=1'b0;Clk=1'b0;En=1'b0;Pattern=2'd2; 
    #5 Reset=1'b1;
    #5 Reset=1'b0;
    #10 D=8'd13;WA=10'd0;
    #10 D=8'd23;WA=10'd1;
    #10 D=8'd34;WA=10'd2;
    #10 D=8'd17;WA=10'd3;
    #10 D=8'd36;WA=10'd4;
    #10 D=8'd39;WA=10'd5;
    #10 D=8'd123;WA=10'd6;
    #10 D=8'd243;WA=10'd7;
    #10 D=8'd134;WA=10'd8;
    #10 D=8'd117;WA=10'd9;
    #10 D=8'd236;WA=10'd10;
    #10 D=8'd239;WA=10'd11;
   
    #10 D=8'd32;WA=10'd50;
    #10 D=8'd37;WA=10'd51;
    #10 D=8'd46;WA=10'd52;
    #10 D=8'd65;WA=10'd53;
    #10 D=8'd78;WA=10'd54;
    #10 D=8'd91;WA=10'd55;
    #10 D=8'd223;WA=10'd56;
    #10 D=8'd173;WA=10'd57;
    #10 D=8'd144;WA=10'd58;
    #10 D=8'd107;WA=10'd59;
    #10 D=8'd216;WA=10'd60;
    #10 D=8'd209;WA=10'd61;
    
    #10 D=8'd21;WA=10'd100;
    #10 D=8'd22;WA=10'd101;
    #10 D=8'd55;WA=10'd102;
    #10 D=8'd78;WA=10'd103;
    #10 D=8'd98;WA=10'd104;
    #10 D=8'd93;WA=10'd105;
    #10 D=8'd221;WA=10'd106;
    #10 D=8'd229;WA=10'd107;
    #10 D=8'd155;WA=10'd108;
    #10 D=8'd178;WA=10'd109;
    #10 D=8'd198;WA=10'd110;
    #10 D=8'd153;WA=10'd111;
    
    #10 En=1'b1;
    #200 $finish;
end

endmodule
