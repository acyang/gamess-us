#!/bin/csh
#BSUB -J runall
#BSUB -e %J.err
#BSUB -o %J.out
#BSUB -R 'span[ptile=48]'
#BSUB -q test
#BSUB -n 48
#BSUB -R "ipathavail==0"

# For GNU Compiler + MVAPICH2
source /pkg/mpi/gcc/4.6.1/mvapich2-1.8/bin/mpivars.sh
source /pkg/local/gcc/4.6.1/gcc461.sh

echo "Your GAMESS starts at "`date`

set i=1
set Ntest=47
while ($i <= $Ntest)
               set NUM=$i
  if ($i <= 9) set NUM=0$i
     ./rungms.gfortran.socket exam$NUM 00 $LSB_DJOB_NUMPROC >& exam$NUM.log
  @ i++
end

tests/standard/checktst >& check.gfortran.socket.parallel.log

wait

echo "Your GAMESS job completed at "`date`