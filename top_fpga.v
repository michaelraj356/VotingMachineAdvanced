`timescale 1ns/1ps

module top_fpga (
    input  wire clk,
    input  wire rst_btn,

    input  wire enable_sw,
    input  wire admin_sw,

    input  wire sw2,
    input  wire sw3,

    input  wire btn_A,
    input  wire btn_B,
    input  wire btn_C,

    output reg  [12:0] led
);

    wire rst = rst_btn;

    // Edge detect registers
    reg btnA_d, btnB_d, btnC_d;

    always @(posedge clk) begin
        btnA_d <= btn_A;
        btnB_d <= btn_B;
        btnC_d <= btn_C;
    end

    wire vote_A_pulse = btn_A & ~btnA_d;
    wire vote_B_pulse = btn_B & ~btnB_d;
    wire vote_C_pulse = btn_C & ~btnC_d;

    // DUT wires
    wire [7:0] count_A, count_B, count_C;
    wire [1:0] winner;
    wire       valid_vote;
    wire [1:0] state_out;

    voting_machine_advanced DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable_sw),
        .admin_mode(admin_sw),

        .vote_A(vote_A_pulse),
        .vote_B(vote_B_pulse),
        .vote_C(vote_C_pulse),

        .count_A(count_A),
        .count_B(count_B),
        .count_C(count_C),

        .winner(winner),
        .valid_vote(valid_vote),
        .state_out(state_out)
    );

    // Display select
    wire [1:0] sel = {sw3, sw2};
    reg  [7:0] disp_val;

    always @(*) begin
        case (sel)
            2'b00: disp_val = count_A;
            2'b01: disp_val = count_B;
            2'b10: disp_val = count_C;
            2'b11: disp_val = {4'b0000, state_out, winner};
            default: disp_val = 8'h00;
        endcase
    end

    // LED outputs
    always @(*) begin
        led[7:0]   = disp_val;
        led[8]     = valid_vote;
        led[10:9]  = winner;
        led[12:11] = state_out;
    end

endmodule
