    #PBS -N job_name  
    #PBS -o /auto/plzen1/home/user/Scripts/SPAdes/out.txt  
    #PBS -e /auto/plzen1/home/user/Scripts/SPAdes/err.txt  
    #PBS -l select=1:ncpus=4:ompthreads=4:mem=200gb:scratch_local=500gb  
    #PBS -l walltime=168:00:00  

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1
    mkdir tmp_dir 
    export TMPDIR=$"SCRATCHDIR"/tmp_dir 
    source /auto/plzen1/home/user/.bashrc 

    mkdir output/directory 
    module load spades 


    spades.py \
        --tmp-dir "$"TMPDIR"" \
        -t 4 \
        -k 21,33,77 \
        -m 200 \
        -1 R1.fq \
        -2 R2.fq \
        -o output/directory 

    done
