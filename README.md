# atariwifi
# Atari ST Pico W Wi-Fi Interface Project

 Overview

This project enables an "Atari ST 1040" to access "modern Wi-Fi networks" by offloading all TCP/IP and 802.11 functionality to a "Raspberry Pi Pico W". The Atari communicates with the Pico W through a "hardware interface (cartridge port or serial)" using a deterministic command protocol, while the Pico W acts as a "network coprocessor".

The result is a "period-correct, low-latency network solution" that allows classic Atari ST systems to use Wi-Fi without modifying TOS or burdening the 68000 CPU with modern networking stacks.

This design intentionally mirrors historical approaches used by Ethernet cartridges, ACSI peripherals, and modem drivers—modernized with embedded Wi-Fi hardware.



 Design Philosophy

- "No Wi-Fi stack on the Atari"
- "No TCP/IP stack on the Atari"
- "All networking is offloaded"
- "Deterministic, debuggable protocol"
- "Compatible with real hardware and emulators"
- "Built using period-appropriate tools"

The Atari ST behaves as a "client of a network device", not as a network host.



 System Architecture



Atari ST 1040 (68000, TOS)
│
│  Cartridge Port (preferred) or RS-232
│
└── Raspberry Pi Pico W (RP2040)
├── CYW43439 Wi-Fi chipset
├── lwIP TCP/IP stack
├── Command parser
├── Socket manager
└── Atari protocol adapter



# Responsibilities

| Component | Responsibility |
|--||
| Atari ST | Application logic, GEM UI, legacy software |
| Pico W | Wi-Fi, DHCP, DNS, TCP, buffering, retransmission |
| Protocol | Framing, commands, responses |



 Supported Atari Systems

- Atari 1040ST / STF / STFM
- Atari STE
- Atari Mega ST
- Atari TT (planned)
- Atari Falcon (planned)



 Transport Options

# Option A — Cartridge Port (Recommended)

- 8-bit parallel interface
- Very low latency
- High throughput (~300–600 KB/s)
- Ideal for TCP/IP offload
- Historically accurate (side-car devices)

# Option B — RS-232 Serial (Fallback)

- 19200–115200 baud
- Easy wiring
- Compatible with existing serial stacks
- Lower throughput

Both transports use the "same command protocol".



 Protocol Overview

The Atari communicates with the Pico W using a "binary command/response protocol".

# Command Frame (Atari → Pico)

[CMD][LEN][DATA...]

# Response Frame (Pico → Atari)



[STATUS][LEN][DATA...]

# Core Commands

| CMD | Function |
|-||
| 0x01 | Initialize Wi-Fi |
| 0x02 | Connect to Access Point |
| 0x03 | Open TCP Socket |
| 0x04 | Send TCP Data |
| 0x05 | Receive TCP Data |
| 0x06 | Close TCP Socket |
| 0x07 | Query Status |

The protocol is intentionally simple to allow:
- Easy debugging on logic analyzers
- Deterministic behavior
- Stable driver behavior under TOS



 Software Components

# Atari ST Side

- Written in "ANSI C"
- Compatible with:
  - HiSoft C
  - Pure C
  - Mark Williams C
- Can be built as:
  - `.PRG` user program
  - `.ACC` desk accessory
  - STiNG network driver (optional)

 Features

- Cartridge or serial I/O routines
- Protocol encoder/decoder
- Error handling and retry logic
- Optional GEM configuration UI
- Optional STiNG compatibility layer



# Pico W Firmware

- Written in "C using Pico SDK"
- Uses:
  - CYW43 Wi-Fi driver
  - lwIP TCP/IP stack
- Responsibilities:
  - Wi-Fi management
  - DHCP / DNS
  - TCP socket lifecycle
  - Buffering and flow control
  - Atari command parsing

The Pico W appears to the Atari as a "smart modem / network adapter".



 Directory Layout

atari-pico-wifi/ ←Root 
Refer to the create_project.sh
This create_project.sh will create the development tree.
The below commands will convert the script into an executable and will generate the necessary development folders.

chmod +x create_project.sh
./create_project.sh

 STiNG / MiNTNet Integration (Optional)

This project can optionally expose itself as a "STiNG network device", enabling legacy applications such as:

- FTP clients
- Telnet
- IRC
- Web browsers (CAB, HighWire)

This requires:
- Implementing STiNG device hooks
- Mapping socket operations to Pico commands

 Hardware Notes

- "Level shifting is required" (5V Atari ↔ 3.3V Pico)
- Cartridge port provides sufficient bandwidth
- Pico W power can be supplied via:
  - External 5V
  - Regulated cartridge rail (with care)

A side-car enclosure is recommended for mechanical safety.

 Emulation Support

Fully compatible with:
- Hatari
- Real Atari ST hardware

Development and debugging can be performed in Hatari before deployment to real machines.

Limitations

- No raw Ethernet support (Wi-Fi only)
- No UDP multicast (initially)
- One or limited concurrent sockets (configurable)
- Throughput limited by Atari I/O speed

These are intentional tradeoffs to maintain stability and correctness.



 Project Status

- Architecture defined
- Protocol specified
- Atari driver skeleton implemented
- Pico firmware skeleton implemented
- Full TCP socket handling
- STiNG compatibility layer
- GEM configuration UI

 Goals

- Reliable Wi-Fi access for Atari ST systems
- Clean driver design with no TOS patches
- Educational reference for retro-modern hardware bridges
- Long-term maintainability

 License

This project is intended for “educational, research, and hobbyist use”.  
Licensing terms used MIT Licensing.

Acknowledgements

- Atari ST hardware and documentation
- RP2040 and Pico SDK
- Retro-computing community
- Developers who pioneered cartridge-port networking devices

Final Note

This project treats the Atari ST as a "first-class computer", not a novelty.  
Modern connectivity is added "without compromising historical authenticity".
