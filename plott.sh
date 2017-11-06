#!/bin/bash
# script for Burstcoin plotting your whole drive with https://github.com/bhamon/gpuPlotGenerator
# it will create 4GB nonces until your HDD has no more free space
# creating small nonces makes gpuPlotGenerator run faster (12k nonces/minute with 5GB used RAM)
# modify DRIVE, PLOTTER, etc to suit your settings
# script assumes thet gpuPlotGenerator is configured and working and OpenCL/Cuda are installed
# DONATE HERE: BURST-CC6X-YEGA-92KJ-EUQV4
# tildasec [@] gmail.com

DRIVE='/media/burstcoin/plots'
PLOTTER='/home/cristi/gpuPlot/gpuPlotGenerator-4.1.3/gpuPlotGenerator'
ADDRESS=13938318634448660637
STARTNONCE=600000000
NONCESNUMBER=409 # 1GB
STAGGERSIZE=8192

HDDMAXSIZE=
FREESPACE=

HDDMAXSIZE=$(df -k $DRIVE | awk '{print $3}' | tail -n1)
FREESPACE=$(du -s $DRIVE | awk '{ print $1 }')

NONCESIZE=262144


while :
 do
  if [ $FREESPACE -gt 2000000 ]
   then printf "Plotting from $STARTNONCE \n"
   $PLOTTER generate direct $DRIVE\/$ADDRESS\_$STARTNONCE\_$NONCESNUMBER\_$STAGGERSIZE
   let STARTNONCE=$STARTNONCE+$NONCESNUMBER+10000
  else
   printf 'Done. Or no more available space \n'
fi

if [ $FREESPACE -eq 0 ]
 then exit 1
fi
done
