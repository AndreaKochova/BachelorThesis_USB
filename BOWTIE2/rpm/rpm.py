import sys, glob, os

cov_dir, totals_path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]

# read totals: sample -> raw read count
totals = {}
for line in open(totals_path):
    if line.strip():
        s, n = line.split()
        totals[s] = int(n)

with open(out_path, "w") as out:
    out.write("sample\treference\tnumreads\tbreadth\tmeandepth\trpm\n")
    for f in sorted(glob.glob(os.path.join(cov_dir, "stats_*.tsv"))):
        sample = os.path.basename(f)[len("stats_"):-len(".tsv")]
        if sample not in totals:
            print("no total for", sample, "- skipped", file=sys.stderr)
            continue
        per_mil = totals[sample] / 1_000_000
        header = open(f).readline().lstrip("#").split()
        for line in open(f).readlines()[1:]:
            r = dict(zip(header, line.split("\t")))
            nreads = int(r["numreads"])
            rpm = nreads / per_mil if per_mil else 0
            out.write(f"{sample}\t{r['rname']}\t{nreads}\t{r['coverage']}\t{r['meandepth']}\t{rpm:.2f}\n")

print("wrote", out_path)
