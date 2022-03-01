#!/bin/sh
 
NAME='ecut'
RUNDIR='/root/q-e'

for CUTOFF in 5 10 15 20 25 30
do
	for DIST in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
	do
	cat > $RUNDIR/$NAME.$CUTOFF.$DIST.in << EOF
&control
	calculation = 'scf',
	prefix = '$PREFIX',
	pseudo_dir = '$RUNDIR/pseudo',
	verbosity = 'high'
/
&system
	ibrav = 1,
	celldm(1) = 30.0,
	nat = 2,
	ntyp = 1,
	nbnd = 2,
	ecutwfc = $CUTOFF,
	input_dft = 'BLYP'
/
&electrons
	conv_thr = 1e-8
/
&ions
	ion_dynamics='bfgs'
/
ATOMIC_SPECIES
 H 1.00784 H_US.van
ATOMIC_POSITIONS (angstrom)
 H 0.00 0.00 0.00
 H $DIST 0.00 0.00
K_POINTS (automatic)
 1 1 1 1 1 1
EOF

	$HOME/q-e/bin/pw.x < $RUNDIR/$NAME.$CUTOFF.$DIST.in > $NAME.$CUTOFF.$DIST.scf.out
	#rm -R /tmp/H_work*
	done
done
