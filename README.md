UART Communication System – Basys 3 FPGA
Overview

This project implements an 8-bit UART (Universal Asynchronous Receiver/Transmitter) communication system using SystemVerilog HDL.

The design consists of a UART transmitter and receiver, integrated using a top-level module and verified through simulation using Xilinx Vivado. The project is targeted for the Basys 3 FPGA board.

Features
8-bit UART data transmission and reception
UART transmitter (UART_TX)
UART receiver (UART_RX)
UART top-level integration (UART_TOP)
Start-bit and stop-bit handling
LSB-first data transmission
Parameterized clock frequency and baud rate
Behavioral simulation and verification
Basys 3 FPGA constraints
Successful synthesis and implementation
Successful bitstream generation
UART Configuration
Parameter	Value
Clock Frequency	1 MHz
Baud Rate	10,000 baud
Data Bits	8
Start Bits	1
Stop Bits	1
Parity	None
Design
UART Transmitter

The UART_TX module converts 8-bit parallel data into a serial UART data stream.

The UART frame is:
Idle → Start Bit → 8 Data Bits → Stop Bit
The data is transmitted LSB first.

UART Receiver

The UART_RX module receives the serial UART data stream. It detects the start bit, samples the incoming data bits, reconstructs the 8-bit data, and asserts rx_valid when a valid frame is received.

UART Top Module

The UART_TOP module integrates the transmitter and receiver into a single UART communication system.

Testbench

The UART_TB testbench verifies the complete UART transmission and reception process.

Simulation Result

The design was successfully verified using Vivado simulation.
Transmitted Data = 41
Received Data    = 41
Data Valid       = 1

TEST PASSED
The transmitted and received data are identical, confirming correct UART operation.

FPGA Implementation

The design was targeted to the Digilent Basys 3 FPGA board.

Target Device:
XC7A35T-1CPG236
Timing Results:
WNS: 4.580 ns
WHS: 0.161 ns
Tools Used
SystemVerilog
Xilinx Vivado 2025.1
Vivado Simulator
Digilent Basys 3 FPGA
Conclusion

An 8-bit UART transmitter-receiver system was successfully designed in SystemVerilog, functionally verified through simulation, synthesized and implemented in Vivado, and successfully generated into an FPGA bitstream for the Basys 3 platform.
