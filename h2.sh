#!/bin/sh

NAME='ecut'
RUNDIR='$HOME/QE'

for CUTOFF in 5 10 15 20 25 30
do
cat > $RUNDIR/$NAME.$CUTOFF.in << EOF
&control
	calculation = 'scf',
	prefix = '$PREFIX',
	pseudo_dir = '$RUNDIR',
	outdir = '/tmp/',
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
ATOMIC_SPECIES
 H 1.00784 H_US.van
ATOMIC_POSITIONS (angstron)
 H 0.00 0.00 0.00
 H 1.00 0.00 0.00
K_POINTS (automatic)
 1 1 1 1 1 1
EOF

$HOME/pw.x < $RUNDIR/$NAME.$CUTOFF.in > $NAME.$CUTOFF.out
rm -R /tmp/H_work*
done
