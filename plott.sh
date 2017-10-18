#!/bin/bash
# script for Burstcoin plotting your whole drive with https://github.com/bhamon/gpuPlotGenerator
# it will create 4GB nonces until your HDD has no more free space
# creating small nonces makes gpuPlotGenerator run faster (12k nonces/minute with 5GB used RAM)
# modify DRIVE, PLOTTER, etc to suit your settings
# script assumes thet gpuPlotGenerator is configured and working and OpenCL/Cuda are installed
# DONATE HERE: BURST-CC6X-YEGA-92KJ-EUQV4
# tildasec [@] gmail.com

DRIVE='/media/burstcoin3/plots'
PLOTTER='/home/user/gpuPlot/gpuPlotGenerator-4.1.3/gpuPlotGenerator'
ADDRESS=13938318634448660637 #modify this
STARTNONCE=1
NONCESNUMBER=4096 # 4GB
NONCESNUMBER2=1024 # 1GB - let this alone
STAGGERSIZE=16384 # 4GB used RAM

HDDMAXSIZE=6895278972 # 8TB with ext4 filesystem, use "du -sb" on your system
FREESPACE=$(df -k $DRIVE | awk '{print $4}')

while :
 do
        if (($FREESPACE -ge 4294967296)); # 4GB in bytes
                then
                $PLOTTER generate direct $DRIVE\/$ADDRESS\_$STARTNONCE\_$NONCESNUMBER\_$STAGGERSIZE
                let STARTNONCE=$STARTNONCE+$NONCESNUMBER+100000
        else if (($FREESPACE -eq 1073741824)); # 1GB in bytes
                then
                $PLOTTER generate direct $DRIVE\/$ADDRESS\_$STARTNONCE\_$NONCESNUMBER2\_$STAGGERSIZE
                let STARTNONCE=$STARTNONCE+$NONCESNUMBER2+100000
        fi
echo -e 'Done. No more space on HDD.'
done
