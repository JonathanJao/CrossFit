function all_j2c {
    for i in *.jsonl; do
        [ -f "$i" ] || break
        jsonl_to_tsv $i
    done
}
function jsonl_to_csv {
    FILENAME=${1%.*}
    echo $FILENAME
    dasel -r json -w csv <  $FILENAME.jsonl > $FILENAME.tsv
}