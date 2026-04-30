  # busco

    #PBS -N jobName
    #PBS -o /storage/plzen1/home/user/Scripts/BUSCO/out.txt
    #PBS -e /storage/plzen1/home/user/Scripts/BUSCO/err.txt
    #PBS -l select=1:ncpus=2:ompthreads=2:mem=200gb:scratch_local=500gb
    #PBS -l walltime=168:00:00

    trap 'clean_scratch' TERM EXIT
    cd $"SCRATCHDIR" || exit 1

    module add conda-modules-py37
    conda activate busco

    busco \
    -i path/to/contigs.fasta \
    -l bacteria_odb10 \
    --out_path out/dir/path \
    -o outputName \
    -m genome \
    -c 2 
      
  # summary plot

    #PBS -N jobName  
    #PBS -o /storage/plzen1/home/user/Scripts/BUSCO/plot/out.txt     
    #PBS -e /storage/plzen1/home/user/Scripts/BUSCO/plot/err.txt     
    #PBS -l select=1:ncpus=1:mem=55gb:scratch_local=500gb     
    #PBS -l walltime=168:00:00     

    trap 'clean_scratch' TERM EXIT 
    cd $SCRATCHDIR || exit 1 

    module add conda-modules-py37
    conda activate busco

    generate_plot.py -wd path/to/summaries
