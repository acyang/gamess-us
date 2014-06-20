#!/bin/csh
#BSUB -J runall
#BSUB -e %J.err
#BSUB -o %J.out
#BSUB -R 'span[ptile=48]'
#BSUB -q test
#BSUB -n 1
#BSUB -R "ipathavail==0"

# For Intel Compiler + impi
#source /pkg/intel/2013/bin/compilervars.csh intel64 
#source /pkg/intel/2013/impi/4.1.1.036/intel64/bin/mpivars.csh

source /pkg/intel/12/bin/compilervars.csh intel64 
source /pkg/intel/12/impi/4.0.3.008/intel64/bin/mpivars.csh
echo "Your GAMESS starts at "`date`

set i=1
set Ntest=47
while ($i <= $Ntest)
               set NUM=$i
  if ($i <= 9) set NUM=0$i
     ./rungms.ifort.sockets exam$NUM 05 $LSB_DJOB_NUMPROC >& exam$NUM.log
  @ i++
end

tests/standard/checktst >& check.ifort12.sockets.opt.serial.log

wait

echo "Your GAMESS job completed at "`date`