# Prep BUSCO input → unique vals & Wolb Contig
    # tbale filter (AWK)
        for i in {001..077}; do
        tableVar=/path/to/PMLBSc$i/blastx$i.tsv
        outDirVar=/out/dir/filtered/
        awk '$9<1e-10 && $10>300 && $12>95' $tableVar > $outDirVar/filtered$i.tsv
        done
    # grep, count and store number of contig_nodes
        touch seqCounts.txt 
        for i in {001..077}; do
        echo ">PMLBSc$i" >> seqCounts.txt
        grep "NODE" filtered$i.tsv | wc -l >> seqCounts.txt
        done
    # uniq pair filter
        for i in {001..077}; do
        tableVar=/out/dir/filtered/filtered$i.tsv
        outDirVar=/out/dir/uniqueVals/
        if [ -s $tableVar ]; then
            # file exists and it is not empty
            awk -F'\t' '!arr[$1 "\t" $3]++' $tableVar > $outDirVar/unique$i.tsv
        fi
        done
    # list of unique seq_ids
        # compile seq_ids to a list
        touch extratedIDs.list
        for file in *.tsv; do
        awk -F '\t' '{print $1}' $file >> extratedIDs.list
        done
