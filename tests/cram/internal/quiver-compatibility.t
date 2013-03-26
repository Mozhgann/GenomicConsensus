
Quiver should abort if the cmp.h5 is not suitable.  Let's make sure it does the right thing.

First make sure we abort once we recognize the tiny fluidigm file is CCS data.

  $ export DATA=$TESTDIR/../../data
  $ export INPUT=$DATA/fluidigm_amplicons/040500.cmp.h5
  $ export REFERENCE=$DATA/fluidigm_amplicons/Fluidigm_human_amplicons.fasta
  $ variantCaller.py --algorithm=quiver -r $REFERENCE -o variants.gff $INPUT 2>1
  Failure: The Quiver algorithm requires a cmp.h5 file containing standard (non-CCS) reads.
  [255]


Tiny lambda file.  Make sure it recognizes this cmp.h5 has an imcomplete set of QVs.

  $ export INPUT=/mnt/secondary/Share/Quiver/TestData/tinyLambda/aligned_reads_1.cmp.h5
  $ export REFERENCE=/mnt/secondary/Share/Quiver/TestData/tinyLambda/lambdaNEB.fa
  $ variantCaller.py --parameterSet=C2.AllQVsModel --algorithm=quiver -r $REFERENCE -o variants.gff $INPUT
  Failure: Selected Quiver parameter set is incompatible with this cmp.h5 file due to missing data tracks.
  [255]

And should fail informatively when we ask for a non-existent parameter set.

  $ variantCaller.py --parameterSet=SuperChem.Model --algorithm=quiver -r $REFERENCE -o variants.gff $INPUT
  Quiver: no available parameter set named SuperChem.Model
  [255]