#!/bin/sh
# ============================================================
# Atari ST ↔ Raspberry Pi Pico W Wi-Fi Project
# Project tree bootstrap script
# ============================================================

set -e

PROJECT_ROOT="atari-pico-wifi"

echo "Creating project: ${PROJECT_ROOT}"

# ------------------------------------------------------------
# Create directories
# ------------------------------------------------------------
mkdir -p \
"${PROJECT_ROOT}/atari/driver" \
"${PROJECT_ROOT}/atari/test" \
"${PROJECT_ROOT}/atari/gem" \
"${PROJECT_ROOT}/pico/src" \
"${PROJECT_ROOT}/hardware" \
"${PROJECT_ROOT}/docs"

# ------------------------------------------------------------
# Create Atari-side files
# ------------------------------------------------------------
touch \
"${PROJECT_ROOT}/atari/driver/pico_wifi.c" \
"${PROJECT_ROOT}/atari/driver/pico_wifi.h" \
"${PROJECT_ROOT}/atari/driver/cart_io.s" \
"${PROJECT_ROOT}/atari/test/wifi_test.prg" \
"${PROJECT_ROOT}/atari/gem/wifi_config.c"

# ------------------------------------------------------------
# Create Pico-side files
# ------------------------------------------------------------
touch \
"${PROJECT_ROOT}/pico/src/main.c" \
"${PROJECT_ROOT}/pico/src/protocol.c" \
"${PROJECT_ROOT}/pico/src/wifi.c" \
"${PROJECT_ROOT}/pico/src/tcp.c" \
"${PROJECT_ROOT}/pico/CMakeLists.txt" \
"${PROJECT_ROOT}/pico/pico_sdk_import.cmake"

# ------------------------------------------------------------
# Create hardware documentation files
# ------------------------------------------------------------
touch \
"${PROJECT_ROOT}/hardware/cartridge_port_pinout.md" \
"${PROJECT_ROOT}/hardware/wiring_diagram.png" \
"${PROJECT_ROOT}/hardware/level_shifting_notes.md"

# ------------------------------------------------------------
# Create project documentation
# ------------------------------------------------------------
touch \
"${PROJECT_ROOT}/docs/protocol_spec.md" \
"${PROJECT_ROOT}/docs/sting_integration.md" \
"${PROJECT_ROOT}/docs/troubleshooting.md"

# ------------------------------------------------------------
# Create root README
# ------------------------------------------------------------
touch "${PROJECT_ROOT}/README.md"

echo "Project structure created successfully."
