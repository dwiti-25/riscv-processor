# RISC-V RV32I Single-Cycle Processor

A fully functional single-cycle RISC-V processor implemented in Verilog, supporting a subset of the RV32I instruction set.

## Architecture

PC → Instruction Memory → Decoder → Register File → ALU → Data Memory → Writeback

## Modules

- **pc.v** — Program counter, increments by 4 each cycle
- **imem.v** — Instruction memory, stores program
- **decoder.v** — Decodes 32-bit instructions, generates control signals
- **register.v** — 32x32-bit register file, x0 hardwired to zero
- **alu.v** — 32-bit ALU: ADD, SUB, AND, OR, XOR, SLT
- **dmem.v** — Data memory for load/store instructions
- **top.v** — Top-level integration

## Supported Instructions

| Instruction | Type | Operation |
|-------------|------|-----------|
| ADD | R | rd = rs1 + rs2 |
| SUB | R | rd = rs1 - rs2 |
| ADDI | I | rd = rs1 + imm |
| LW | I | rd = Memory[rs1 + imm] |
| SW | S | Memory[rs1 + imm] = rs2 |

## Simulation  iverilog -o sim.out src/pc.v src/imem.v src/decoder.v src/register.v src/alu.v src/dmem.v src/top.v tb/tb_top.v
vvp sim.out   ## Verified Results

- x1 = 10
- x2 = 20
- x3 = 30 (ADD result)
- x4 = 30 (loaded from data memory)
