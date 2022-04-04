#!/usr/bin/env python3

from smbus2 import SMBus, i2c_msg
import struct
from time import sleep

def calculateCRC(input):
    crc = 0xFF
    for i in range (0, 2):
        crc = crc ^ input[i]
        for j in range(8, 0, -1):
            if crc & 0x80:
                crc = (crc << 1) ^ 0x31
            else:
                crc = crc << 1
    crc = crc & 0x0000FF
    return crc

def checkCRC(result):
    for i in range(2, len(result), 3):
        data = []
        data.append(result[i-2])
        data.append(result[i-1])

        crc = result[i]
