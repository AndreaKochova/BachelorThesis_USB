set -euo pipefail
DIR="$1"
for f in "$DIR"/stats_*.tsv; do
  base=$(basename "$f")
  num=${base#stats_}          # -> XXX.tsv
  num=${num%.tsv}             # -> XXX
  # skip if already renamed
  [[ "$num" == PMLBSc* ]] && continue
  cp -n "$f" "$DIR/stats_PMLBSc${num}.tsv"
done
echo "done"
