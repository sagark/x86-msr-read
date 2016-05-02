#!/bin/bash

# define the Integrated Memory Controller performance counter event sets to measure the four events:
#    All Read CAS operations                Event 0x04, Umask 0x03
#    All Write CAS operations               Event 0x04, Umask 0x0C
# Each of the two "SET" variables below includes each of these events on all four memory controller channels.

SET1='-e "uncore_imc_0/event=0x04,umask=0x03/" -e "uncore_imc_1/event=0x04,umask=0x03/" -e "uncore_imc_2/event=0x04,umask=0x03/" -e "uncore_imc_3/event=0x04,umask=0x03/"'
SET2='-e "uncore_imc_0/event=0x04,umask=0x0c/" -e "uncore_imc_1/event=0x04,umask=0x0c/" -e "uncore_imc_2/event=0x04,umask=0x0c/" -e "uncore_imc_3/event=0x04,umask=0x0c/"'

# Since the uncore counters are "per chip", I only need to read these on one core per chip.
# For all of TACC's systems, I know that cores 0 and 9 are on different chips, whichever assignment scheme is used.
#
# "perf stat" flags:
#    "-a" counts for all processes (not just the process run under "perf stat")
#    "-A" tells perf to report results separately for each core, rather than summed
#    "-x ," tells perf to report results as a comma-separated list (easier to import into scripts or spreadsheets)
#    "-o file" directs the output of perf to a separate log file (rather than stdout)

perf stat -o perf.out.imc.test1 -x , -a -A -C 0 $SET1 $SET2 "./a.out"
