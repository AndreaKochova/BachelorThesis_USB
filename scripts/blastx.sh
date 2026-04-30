# Blast X

    #PBS -N jobName
    #PBS -o /auto/plzen1/home/user/Scripts/BLAST/BLASTX/out.txt
    #PBS -e /auto/plzen1/home/user/Scripts/BLAST/BLASTX/err.txt
    #PBS -l select=1:ncpus=2:ompthreads=2:mem=200gb:scratch_local=500gb
    #PBS -l walltime=24:00:00
        
    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1

    module load blast

    blastx \
    -db path/tp/DB \
    -query path/to/contig.fasta \
    -num_threads 2 \
    -out /mnt/storage-brno12-cerit/nfs4/home/andrea_kochova/BLAST/BLASTX/blastx.tsv \
    -outfmt "6 qseqid qlen sseqid slen qstart qend sstart send evalue bitscore length pident nident mismatch gapopen gaps qseq sseq delim=;"

