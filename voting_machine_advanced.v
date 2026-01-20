`timescale 1ns/1ps

module voting_machine_advanced (
    input  wire       clk,
    input  wire       rst,
    input  wire       enable,
    input  wire       admin_mode,

    input  wire       vote_A,
    input  wire       vote_B,
    input  wire       vote_C,

    output reg  [7:0] count_A,
    output reg  [7:0] count_B,
    output reg  [7:0] count_C,

    output reg  [1:0] winner,
    output reg        valid_vote,

    output reg  [1:0] state_out
);

    // FSM states
    localparam IDLE   = 2'b00;
    localparam VOTING = 2'b01;
    localparam LOCK   = 2'b10;
    localparam RESULT = 2'b11;

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Debug output state
    always @(*) begin
        state_out = state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (enable) next_state = VOTING;
                else        next_state = IDLE;
            end

            VOTING: begin
                if (vote_A || vote_B || vote_C)
                    next_state = LOCK;
                else
                    next_state = VOTING;
            end

            LOCK: begin
                if (admin_mode)
                    next_state = RESULT;
                else if (!enable)
                    next_state = IDLE;
                else
                    next_state = LOCK;
            end

            RESULT: begin
                if (!admin_mode)
                    next_state = IDLE;
                else
                    next_state = RESULT;
            end

            default: next_state = IDLE;
        endcase
    end

    // Vote counting
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count_A    <= 8'd0;
            count_B    <= 8'd0;
            count_C    <= 8'd0;
            valid_vote <= 1'b0;
        end
        else if (state == VOTING) begin
            valid_vote <= 1'b0;

            if (vote_A && !vote_B && !vote_C) begin
                count_A    <= count_A + 8'd1;
                valid_vote <= 1'b1;
            end
            else if (vote_B && !vote_A && !vote_C) begin
                count_B    <= count_B + 8'd1;
                valid_vote <= 1'b1;
            end
            else if (vote_C && !vote_A && !vote_B) begin
                count_C    <= count_C + 8'd1;
                valid_vote <= 1'b1;
            end
        end
        else begin
            valid_vote <= 1'b0;
        end
    end

    // Winner logic (only in RESULT state)
    always @(*) begin
        if (state == RESULT) begin
            if ((count_A > count_B) && (count_A > count_C))
                winner = 2'b00;  // A wins
            else if ((count_B > count_A) && (count_B > count_C))
                winner = 2'b01;  // B wins
            else if ((count_C > count_A) && (count_C > count_B))
                winner = 2'b10;  // C wins
            else
                winner = 2'b11;  // tie
        end
        else begin
            winner = 2'b11;      // default
        end
    end

endmodule
