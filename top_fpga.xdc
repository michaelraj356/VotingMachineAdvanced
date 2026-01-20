# CLOCK 100MHz
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk -period 10.00 [get_ports clk]

# SWITCHES
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports enable_sw]   ;# SW0
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports admin_sw]    ;# SW1
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports sw2]         ;# SW2
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports sw3]         ;# SW3

# PUSH BUTTONS
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports rst_btn]     ;# BTNC
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports btn_A]       ;# BTNU
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports btn_B]       ;# BTNL
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports btn_C]       ;# BTNR

# LEDs (LED0..LED12)
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {led[3]}]
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports {led[4]}]
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports {led[5]}]
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports {led[6]}]
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports {led[7]}]

set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports {led[8]}]
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports {led[9]}]
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports {led[10]}]
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports {led[11]}]
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports {led[12]}]
