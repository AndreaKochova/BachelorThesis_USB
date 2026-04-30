#FastQC 
  #PBS -N job_name
  #PBS -l select=1:ncpus=1:mem=10gb:scratch_local=300gb
  #PBS -l walltime=00:59:00
  #PBS -o /path/to/output/file/file.txt 
  #PBS -e /path/to/error/file/file.txt

  #clean scratch after the end
  trap 'clean_scratch' TERM EXIT

  # go to scratch directory
  cd $SCRATCHDIR || exit 1

  source /storage/plzen1/home/yourUser/.bashrc
  module load fastqc

  for i in {001..012}; do
  fastqc -o /path/to/your/outputDirectory/ R1.fastq R2.fastq
  done

#MultiQC
    module load mambaforge
    mamba activate /storage/plzen1/home/andrea_kochova/Software/multiqc
    multiqc .
