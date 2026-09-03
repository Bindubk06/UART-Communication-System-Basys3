UART Communication System – Basys 3
Overview

This project implements an 8-bit UART (Universal Asynchronous Receiver/Transmitter) communication system using Verilog/SystemVerilog HDL.

The design includes a UART transmitter and receiver integrated through a top-level module and verified using behavioral simulation in Xilinx Vivado 2025.1. The design is targeted for the Basys 3 FPGA.

Features
8-bit UART communication
UART Transmitter
UART Receiver
Start and stop bit handling
LSB-first data transmission
Parameterized clock frequency and baud rate
Behavioral simulation and verification
Basys 3 FPGA implementation
Successful timing analysis
Successful bitstream generation
UART Configuration
Parameter	Value
Clock Frequency	1 MHz
Baud Rate	10,000
Data Bits	8
Start Bit	1
Stop Bit	1
Parity	None
Project Structure
UART-Communication-System-Basys3/
│
├── RTL/
│   ├── UART_TX.sv
│   ├── UART_RX.sv
│   └── UART_TOP.sv
│
├── Simulation/
│   └── UART_TB.sv
│
├── Constraints/
│   └── UART_Basys3.xdc
│
├── Results/
│   ├── UART_Simulation.png
│   ├── Timing_Summary.png
│   └── Bitstream_Completed.png
│
└── README.md
Module Description
UART_TX

The transmitter converts 8-bit parallel data into serial UART data.

The transmission frame consists of:

Idle → Start Bit → 8 Data Bits → Stop Bit

The data is transmitted LSB first.

UART_RX

The receiver detects the start bit, samples the incoming serial data, reconstructs the 8-bit received data, and generates rx_valid when a valid byte is received.

UART_TOP

The top-level module integrates the UART_TX and UART_RX modules.

UART_TB

The testbench verifies the UART transmitter and receiver by transmitting a data byte and checking whether the receiver correctly receives the same byte.

Simulation Result

The UART design was successfully verified through behavioral simulation.

Transmitted Data = 41
Received Data    = 41
RX Valid         = 1

TEST PASSED

The transmitted and received data match, confirming correct UART operation.

FPGA Implementation

Target Board: Basys 3
FPGA: XC7A35T-CPG236-1
Tool: Xilinx Vivado 2025.1

Implementation status:

Synthesis — Completed
Implementation — Completed
Timing Analysis — Passed
Bitstream Generation — Successfully Completed
Timing Result
Worst Negative Slack (WNS): 4.580 ns
Total Negative Slack (TNS): 0.000 ns
Failing Endpoints: 0

All user-specified timing constraints were met.

Tools Used
SystemVerilog
Xilinx Vivado 2025.1
Vivado Simulator
Basys 3 FPGA
Author

Bindu BK
