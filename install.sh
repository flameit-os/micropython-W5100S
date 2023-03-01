#!/bin/bash

echo "Installing MicroPython for W5100S EVB board"

FIRMWARE_FILENAME=firmware-rp2-W5100S-EVB-Pico-$(date +"%Y-%m-%d").uf2

if [[ -d "micropython" ]]
then
    echo "MicroPython exists on your filesystem"
    cd micropython
    git pull --recurse-submodules
    cd ..
else
    echo "Clonning MicroPython"
    git clone -b master https://github.com/micropython/micropython.git
fi

cd micropython
make -C ports/rp2 submodules
make -C ports/rp2 BOARD=W5100S_EVB_PICO submodules
make -C mpy-cross
cd ports/rp2
make BOARD=W5100S_EVB_PICO submodules
make BOARD=W5100S_EVB_PICO

cd ../../../
echo "Compiling finished"

cp micropython/ports/rp2/build-W5100S_EVB_PICO/firmware.uf2 ./$FIRMWARE_FILENAME
