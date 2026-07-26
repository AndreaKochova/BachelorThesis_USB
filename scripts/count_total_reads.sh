# Counts raw reads per sample (R1+R2) and writes total_reads.tsv.
# This total is the RPM denominator and must come from the raw butterfly
# reads (cleaned, of course), before any Wolbachia filtering.
#
# Usage:
#   ./01_count_reads.sh <raw_fastq_dir> <sample_list.txt> <out_dir>
#
# sample_list.txt: one sample name per line, e.g. PMLBSc001
# Expects files: <raw_fastq_dir>/<sample>.R1.fq.gz and .R2.fq.gz

set -euo pipefail

FASTQ_DIR="$1"
SAMPLE_LIST="$2"
OUT_DIR="$3"
mkdir -p "$OUT_DIR"

# Build an infile list of every R1/R2 that exists for the listed samples.
FASTQ_LIST=$(mktemp)
while read -r s; do
  [ -z "$s" ] && continue
  echo "${FASTQ_DIR}/${s}.R1.fq.gz"
  echo "${FASTQ_DIR}/${s}.R2.fq.gz"
done < "$SAMPLE_LIST" > "$FASTQ_LIST"

# seqkit stats: -T tab output, column 4 (num_seqs) is the read count.
# Strip directory and .R[12].fq.gz suffix so both mates collapse to one key,
# then sum R1+R2 per sample.

module load mambaforge
mamba activate PUT PATH HERE
seqkit stats -T -j 4 --infile-list "$FASTQ_LIST" \
  | awk 'NR>1 {
      f=$1;
      sub(/.*\//,"",f);              # drop directory
      sub(/\.R[12]\.fq\.gz$/,"",f);  # drop mate + extension
      sum[f]+=$4
    } END {
      for (s in sum) print s"\t"sum[s]
    }' \
  | sort > "${OUT_DIR}/total_reads.tsv"

rm -f "$FASTQ_LIST"
echo "Wrote ${OUT_DIR}/total_reads.tsv"