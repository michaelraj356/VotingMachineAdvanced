# Voting Machine Advanced (RTL Verilog) - Nexys A7

## Project Overview
This is a secure RTL-based voting machine implemented in Verilog for the Digilent Nexys A7 FPGA board.
It supports 3 candidates (A, B, C) and allows one vote per enable cycle.

## FPGA Board
- Board: Digilent Nexys A7-100T
- FPGA: XC7A100T-CSG324-1
- Clock: 100 MHz

## Inputs
- BTNC : Reset
- SW0  : Enable voting
- SW1  : Admin mode (view winner)
- SW3, SW2 : Display select
- BTNU : Vote A
- BTNL : Vote B
- BTND : Vote C (temporary mapping)

## Outputs
- LED0 - LED7   : Selected vote count (A/B/C)
- LED8          : Valid vote indicator
- LED9 - LED10  : Winner output
- LED11 - LED12 : FSM state output

## Display Select (SW3 SW2)
- 00 -> Show Candidate A count
- 01 -> Show Candidate B count
- 10 -> Show Candidate C count
- 11 -> Debug (state + winner)

## How Voting Works
1. Press BTNC to reset counts.
2. Turn SW0 ON to enable voting.
3. Press one vote button (A/B/C).
4. System locks after one vote.
5. For next voter: SW0 OFF then SW0 ON again.

## Files
- src/voting_machine_advanced.v
- src/top_fpga.v
- constraints/top_fpga.xdc
- sim/tb_voting_machine_advanced.v (optional)

## How to Run in Vivado
1. Create a new RTL project.
2. Add src Verilog files to Design Sources.
3. Add top_fpga.xdc to Constraints.
4. Run Synthesis -> Implementation -> Generate Bitstream.
5. Program FPGA using Hardware Manager.

## Author
Michael raj A
