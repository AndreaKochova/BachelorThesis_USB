# prep
  # gather genomes RefSeq only 
    for ref in /mnt/storage-brno12-cerit/nfs4/home/user/Bowtie/DB/ncbi_dataset/ncbi_dataset/data/*/*.fna; do  
      cp $ref /mnt/storage-brno12-cerit/nfs4/home/user/Bowtie/DB/refGenomes
    done 
    cat /mnt/storage-brno12-cerit/nfs4/home/user/Bowtie/DB/refGenomes/*.fna > ref_wolb_genoms_DB.fasta   

  # create custom DB
    #PBS -N jobname
    #PBS -l select=1:ncpus=1:mem=10gb:scratch_local=300gb
    #PBS -l walltime=24:00:00
    #PBS -o /storage/plzen1/home/user/Scripts/Bowtie/DB/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/Bowtie/DB/err.txt

    module load bowtie2

    bowtie2-build \
    /mnt/storage-brno12-cerit/nfs4/home/user/Bowtie/DB/ref_wolb_genoms_DB.fasta \
    /mnt/storage-brno12-cerit/nfs4/home/user/Bowtie/DB/ref_wolb_genoms_DB/ref_wolb_genoms_DB  

# First cycle - extraction
  # MAPPING
  
    #PBS -N jobname
    #PBS -o /storage/plzen1/home/andrea_kochova/Scripts/Bowtie/13bowtie/map/sampleX/out.txt
    #PBS -e /storage/plzen1/home/andrea_kochova/Scripts/Bowtie/13bowtie/map/sampleX/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=500gb
    #PBS -l walltime=168:00:00
      
    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load bowtie2

    bowtie2 \
      --very-sensitive-local \
      --no-unal \
      -x path/to/custom/DB \
      -1 path/to/R1.fq.gz \
      -2 path/to/R2.fq.gz \
      -S output/directory/sampleX_MAP.sam
    

  # View

    #PBS -N jobname
    #PBS -o /storage/plzen1/home/user/Scripts/SAMtools/BW2/map/view/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/SAMtools/BW2/map/view/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools view -h -F 4 -b -S path/to/mapped/sampleX_MAP.sam > $out/dir/viewSMT_sampleX_MAP.bam
     
  # Sort
    #PBS -N jobName
    #PBS -o/storage/plzen1/home/user/Scripts/SAMtools/BW2/map/sort/out.txt
    #PBS -e/storage/plzen1/home/user/Scripts/SAMtools/BW2/map/sort/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools sort -n viewed/sampleX.bam -o out/dir/sampleX_sorted.bam
     

  # Extract
    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/BedTools/BamToFastq/map/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/BedTools/BamToFastq/map/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load bedtools

    bedtools bamtofastq -i sorted/sampleX.bam -fq out/dir/sampleX_R1.fastq -fq2 out/dir/sampleX_R2.fastq
     

    for i in {001..077}; do
      qsub extractB2Fq_13BW2_MAP_$i.sh
      mv extractB2Fq_13BW2_MAP_$i.sh PMLBSc$i/
    done
  
# Second cycle - remapping + final statistics
  # REMAPPING

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/Bowtie/remap/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/Bowtie/remap/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=100gb
    #PBS -l walltime=168:00:00
        
    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load bowtie2

    bowtie2 \
      --very-sensitive-local \
      --no-unal \
      -x path/to/DB \
      -1 path/to/extracted/sampleX_R1.fastq \
      -2 path/to/extracted/sampleX_R2.fastq \
      -S out/dir/sampleX_remap.sam
  
  # View

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/view/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/view/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools view -h -F 4 -b -S path/to/sampleX_remap.sam > out/dir/sampleX_remap_viewed.bam
     
  # Sort !!! -n !!!

    #PBS -N jobName 
    #PBS -o /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/sort/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/sort/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools sort -n path/to/sampleX_remap_viewed.bam -o out/dir/sampleX_remap_sorted.bam
     
  # Extract

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/BedTools/BamToFastq/remap/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/BedTools/BamToFastq/remap/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    bedtools bamtofastq -i path/to/sampleX_remap_sorted.bam -fq out/dir/sampleX_remap.R1.fastq -fq2 out/dir/sampleX_remap.R2.fastq

  # Coverage Statistics

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/coverage/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/coverage/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools coverage path/to/sampleX_remap_sorted.bam -o out/dir/coverage.tsv

  # Historgram

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/histogram/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/SAMtools/BW2/remap/histogram/err.txt
    #PBS -l select=1:ncpus=1:mem=25gb:scratch_local=200gb
    #PBS -l walltime=24:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
      
    module load samtools

    samtools coverage path/to/sampleX_remap_sorted.bam -m -o out/dir/histogram.txt
       
