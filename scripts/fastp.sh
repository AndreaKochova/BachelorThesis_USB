  #PBS -N jobname
  #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=300gb
  #PBS -l walltime=09:59:00
  #PBS -o /mnt/storage-brno12-cerit/nfs4/home/andrea_kochova/Project/fastp/out.txt 
  #PBS -e /mnt/storage-brno12-cerit/nfs4/home/andrea_kochova/Project/fastp/err.txt

  trap 'clean_scratch' TERM EXIT
  cd $SCRATCHDIR || exit 1

  module add mambaforge
  mamba activate /auto/plzen1/home/user/Software/fastp


  fastp -i /storage/brno12-cerit/home/user/Project/rawData/R1.fastq \
  -I /storage/brno12-cerit/home/user/Project/rawData/R2.fastq \
  -o /storage/brno12-cerit/home/user/Project/rawData/clean.R1.fastq \
  -O /storage/brno12-cerit/home/user/Project/rawData/clean.R2.fastq \
  --adapter_fasta /mnt/storage-brno12-cerit/nfs4/home/user/adaptersFasta/custom.fa #optional, used in specific cases
