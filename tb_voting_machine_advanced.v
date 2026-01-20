`timescale 1ns/1ps

module tb_voting_machine_advanced;

    reg clk;
    reg rst;
    reg enable;
    reg admin_mode;
    reg vote_A, vote_B, vote_C;

    wire [7:0] count_A, count_B, count_C;
    wire [1:0] winner;
    wire       valid_vote;
    wire [1:0] state_out;

    // DUT Instantiation
    voting_machine_advanced DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .admin_mode(admin_mode),
        .vote_A(vote_A),
        .vote_B(vote_B),
        .vote_C(vote_C),
        .count_A(count_A),
        .count_B(count_B),
        .count_C(count_C),
        .winner(winner),
        .valid_vote(valid_vote),
        .state_out(state_out)
    );

    // Clock Generation (100MHz => 10ns period)
    always #5 clk = ~clk;

    // Task: Apply one clean vote pulse
    task give_vote_A;
    begin
        vote_A = 1; vote_B = 0; vote_C = 0;
        #10;
        vote_A = 0;
        #10;
    end
    endtask

    task give_vote_B;
    begin
        vote_A = 0; vote_B = 1; vote_C = 0;
        #10;
        vote_B = 0;
        #10;
    end
    endtask

    task give_vote_C;
    begin
        vote_A = 0; vote_B = 0; vote_C = 1;
        #10;
        vote_C = 0;
        #10;
    end
    endtask

    // Task: Invalid vote (multiple press)
    task give_invalid_vote;
    begin
        vote_A = 1; vote_B = 1; vote_C = 0;
        #10;
        vote_A = 0; vote_B = 0;
        #10;
    end
    endtask

    initial begin
        // Dump Waveform
        $dumpfile("voting_machine_advanced.vcd");
        $dumpvars(0, tb_voting_machine_advanced);

        // Monitor output
        $monitor("T=%0t | rst=%b enable=%b admin=%b A=%b B=%b C=%b | CA=%0d CB=%0d CC=%0d | valid=%b winner=%b state=%b",
                 $time, rst, enable, admin_mode, vote_A, vote_B, vote_C,
                 count_A, count_B, count_C,
                 valid_vote, winner, state_out);

        // Initial values
        clk = 0;
        rst = 1;
        enable = 0;
        admin_mode = 0;
        vote_A = 0;
        vote_B = 0;
        vote_C = 0;

        // Reset
        #20;
        rst = 0;

        // Enable voting
        #10;
        enable = 1;

        // Vote A
        #10;
        give_vote_A();

        // Vote B
        #20;
        give_vote_B();

        // Vote C
        #20;
        give_vote_C();

        // Invalid vote (A+B)
        #20;
        give_invalid_vote();

        // Disable enable -> back to IDLE
        #20;
        enable = 0;

        // Admin mode -> check winner
        #20;
        admin_mode = 1;
        #40;
        admin_mode = 0;

        // Finish
        #50;
        $finish;
    end

endmodule
