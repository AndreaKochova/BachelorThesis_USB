# kraken DB
    #PBS -N jobName
    #PBS -l select=1:ncpus=1:mem=100gb:scratch_local=300gb
    #PBS -l walltime=24:00:00
    #PBS -o /storage/plzen1/home/user/Scripts/Kraken2/DB/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/Kraken2/DB/err.txt
    
    cd $SCRATCHDIR || exit 1
    trap 'clean_scratch' TERM EXIT

    module load kraken2

    kraken2-build --download-taxonomy --db $DBVar 

    for ref in path/to/ref/genomes/*.fna; do 
      kraken2-build --add-to-library $ref --db path/to/DB 
    done 

    kraken2-build --build --db path/to/DB  

  #. Kraken2
  
    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/Kraken2/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/Kraken2/err.txt
    #PBS -l select=1:ncpus=4:ompthreads=4:mem=200gb:scratch_local=500gb
    #PBS -l walltime=168:00:00
      
    cd $SCRATCHDIR || exit 1
    trap 'clean_scratch' TERM EXIT

    module load kraken2

    kraken2 \
    --db path/to/DB --threads 4 --report-zero-counts --use-names \
    --confidence 0.05 \
    --paired $R1Var $R2Var \
    --output out/dir/kraken2_results.out \
    --report out/dir/kraken2_report
