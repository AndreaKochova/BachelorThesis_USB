    #PBS -N jobname
    #PBS -l select=1:ncpus=1:mem=200gb:scratch_local=300gb
    #PBS -l walltime=03:59:00
    #PBS -o /auto/plzen1/home/user/Scripts/BBMap/clumpify/out.txt 
    #PBS -e /auto/plzen1/home/user/Scripts/BBMap/clumpify/err.txt

    trap 'clean_scratch' TERM EXIT
    cd $SCRATCHDIR || exit 1

    module add mambaforge
    mamba activate /storage/plzen1/home/user/Software/bbmap

    R1Var=/mnt/storage-brno12-cerit/nfs4/home/user/Project/clumpify/sampleX.R1.fastq
    R2Var=/mnt/storage-brno12-cerit/nfs4/home/user/Project/clumpify/sampleX.R2.fastq
    
    clumpify.sh \
     in=$R1Var\
     in2=$R2Var \
     out=/mnt/storage-brno12-cerit/nfs4/home/user/Project/BBMap/clumpify/sampleX_R1_dedup.fastq \
     out2=/mnt/storage-brno12-cerit/nfs4/home/user/Project/BBMap/clumpify/sampleX_R2_dedup.fastq \
     dedupe=t \
     tossbrokenreads \
     spany=t \
     adjacent=t \
     optical=t \
     dupedist=40 \
     containment=f 
    
