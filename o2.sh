#!/bin/sh
 
NAME='ecuto2'
RUNDIR='/root/q-e'

for CUTOFF in 10 15 20 25 30
do
cat > $RUNDIR/$NAME.$CUTOFF.in << EOF
&control
	calculation = 'scf',
	prefix = '$PREFIX',
	pseudo_dir = '$RUNDIR/pseudo',
	verbosity = 'high'
/
&system
	ibrav = 1,
	celldm(1) = 32.0,
	nat = 2,
	ntyp = 1,
	nbnd = 8,
	ecutwfc = $CUTOFF
/
&electrons
	conv_thr = 1e-8
/
ATOMIC_SPECIES
 O 15.999 O_US.van
ATOMIC_POSITIONS (angstrom)
 O 0.00 0.00 0.00
 O 1.198458 0.00 0.00
K_POINTS (automatic)
 1 1 1 1 1 1
EOF

$HOME/q-e/bin/pw.x < $RUNDIR/$NAME.$CUTOFF.in > $NAME.$CUTOFF.bands.out
#rm -R /tmp/H_work*

done
