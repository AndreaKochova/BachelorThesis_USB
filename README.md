# Supplementary Material M1

This repository contains Supplementary Material M1 associated with Andrea Kochova’s BSc thesis. These files were not incorporated directly into the thesis text because of their size and logistical constraints. This README reproduces the inventory and descriptions provided in Supplementary Table S4.

## BLASTX analysis

- [`BLASTX/3blastx_ver2/`](BLASTX/3blastx_ver2) — Directory containing the BLASTX analysis outputs, filtered tables, extracted candidate _Wolbachia_ contigs, and additional intermediate files generated during the assembly-based screening.
- [`BLASTX/3blastx_ver2/3blastx_DB/`](BLASTX/3blastx_ver2/3blastx_DB) — Directory containing the raw reference protein files and the generated BLASTX database.
- [`BLASTX/3blastx_ver2/contigs/`](BLASTX/3blastx_ver2/contigs) — Directory containing the _Wolbachia_ contigs extracted after the BLASTX search and table filtering.
- [`BLASTX/3blastx_ver2/filtered/`](BLASTX/3blastx_ver2/filtered) — Directory containing the filtered BLASTX tables and the extracted number of contigs per sample, stored in `3blastx_ver2_num_of_contig_nodes.txt`.
- [`BLASTX/3blastx_ver2/idLists/`](BLASTX/3blastx_ver2/idLists) — Directory containing the IDs of the contigs selected for extraction.
- [`BLASTX/3blastx_ver2/uniqueVals/`](BLASTX/3blastx_ver2/uniqueVals) — Directory containing tables of unique values used to compile the contig ID lists.

## BOLD-based taxonomic investigation

- [`BOLD_system_reports/`](BOLD_system_reports) — Directory containing MitoFinder-derived nucleotide FASTA files and associated material used to support BOLD-based taxonomic investigation of specimens whose original identification was uncertain.

## Bowtie2 mapping and coverage analysis

- [`BOWTIE2/`](BOWTIE2) — Directory containing the complete mapping-cycle outputs and intermediate files, including the reference database and raw references, per-sample and combined mapping statistics, coverage histograms, and reads-per-million calculations.
- [`BOWTIE2/stats/`](BOWTIE2/stats) — Directory containing the per-sample `stats_###.tsv` mapping summaries and the combined `stats.tsv` table, including reference-level mapped-read counts, breadth of coverage, and mean depth.
- [`BOWTIE2/hist/`](BOWTIE2/hist) — Directory containing per-sample histogram-format outputs generated with SAMtools coverage, describing the distribution of mapped-read depth across the reference genomes.
- [`BOWTIE2/rpm/`](BOWTIE2/rpm) — Directory containing the files used for library-size normalisation, including raw-read totals, the RPM calculation script, and the resulting `rpm_out.tsv` table.

## BUSCO assessment

- [`BUSCO/3busco_ver2_for_3blastxver2/`](BUSCO/3busco_ver2_for_3blastxver2) — Directory containing BUSCO output files for the candidate _Wolbachia_-associated contig sets. It includes BUSCO short-summary files for the 26 samples identified by the permissive BLASTX screen and assessed against `bacteria_odb10`. The directory also contains the data and R code used to visualise BUSCO completeness.

## Quality-control reports

- [`QC_reports/`](QC_reports) — Directory containing the quality-control reports generated with FastQC, together with the associated MultiQC summaries.

## Reference genomes

- [`reference_genomes_for_mapping/`](reference_genomes_for_mapping) — Directory containing the _Wolbachia_ reference-genome files used to construct the custom mapping database. The final reference inventory used for the thesis mapping analysis is described separately in Supplementary Table S2 of the thesis.

## Analysis scripts

- [`scripts/BBMap_clumpify.sh`](scripts/BBMap_clumpify.sh) — Shell script for duplicate-read removal with the Clumpify utility from BBMap, including optical-duplicate detection and spatial-adjacency settings.
- [`scripts/QC.sh`](scripts/QC.sh) — Shell script for generating quality-control reports with FastQC and MultiQC.
- [`scripts/blastx.sh`](scripts/blastx.sh) — Shell script for translated BLASTX searches of assembled contigs against the selected _Wolbachia_ protein database, producing tabular alignment output.
- [`scripts/busco.sh`](scripts/busco.sh) — Shell script for assessing candidate bacterial contigs with BUSCO in genome mode against `bacteria_odb10` and generating the standard BUSCO summary plot.
- [`scripts/count_total_reads.sh`](scripts/count_total_reads.sh) — Shell script that counts the total paired-end reads in each sequencing library with SeqKit and writes the results to `total_reads.tsv`. These values provide the denominator used for RPM normalisation.
- [`scripts/fastp.sh`](scripts/fastp.sh) — Shell script for read trimming and filtering with fastp. It includes the optional use of a custom adapter FASTA file for samples with persistent adapter contamination.
- [`scripts/mapping_and_coverage_stats.sh`](scripts/mapping_and_coverage_stats.sh) — Script containing commands for the complete Bowtie2 mapping and remapping workflow, including reference-database construction, SAMtools filtering and sorting, BEDTools read extraction, and calculation of coverage statistics and coverage histograms.
- [`scripts/rpm.py`](scripts/rpm.py) — Python script that combines the per-sample mapping-statistics files with `total_reads.tsv` to calculate mapped-read counts, breadth of coverage, mean depth, and reads per million total reads (RPM), writing the combined results to `rpm_out.tsv`.
- [`scripts/spades.sh`](scripts/spades.sh) — Shell script for de novo assembly of paired-end reads with SPAdes using k-mer sizes 21, 33, and 77.
- [`scripts/table_filters.sh`](scripts/table_filters.sh) — Shell and AWK commands used to filter BLASTX tables by E-value (< 1 × 10⁻¹⁰), alignment length (> 300), and percentage identity (> 95%); count retained contig nodes; remove repeated query–subject pairs; and extract candidate sequence identifiers.
