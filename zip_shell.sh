#!/bin/bash
EID=''
PROJNUM=""
CLASSLIST=""
MAINCLASS=""
CORPORA=""
TRACENAME=""
BINARY=""
CONTROL=""
N="0"
while getopts e:n:l:m:b:t:z:f:* o
do
    case $o in
        e) EID="$OPTARG";;
        n) PROJNUM="$OPTARG";;
        l) CLASSLIST="$OPTARG";;
        m) MAINCLASS="$OPTARG";;
        t) TRACENAME="$OPTARG";;
        b) BINARY="-binary";;
        z) CONTROL="-control";;
        f) N="$OPTARG";;
    esac
done
shift $OPTIND-1
python3 submit.py -eid $EID -projnum $PROJNUM -classlist $CLASSLIST
trace_file=$(echo "proj${PROJNUM}_${EID}_${TRACENAME}_trace.txt" | tr -d "\r")
echo $trace_file
main_class=$(find ir -name "${MAINCLASS}")
IFS='.' # hyphen (-) is set as delimiter
read -ra ADDR <<< "$main_class"
class="${ADDR[0]}"
echo "java ${class} ${BINARY} ${CONTROL} /u/mooney/ir-code/corpora/cf/ /u/mooney/ir-code/queries/cf/queries-rated/ ./n${N}/${TRACENAME} ${N}"
script -c "java ${class} ${BINARY} ${CONTROL} /u/mooney/ir-code/corpora/cf/ /u/mooney/ir-code/queries/cf/queries-rated/ ./n${N}/${TRACENAME} ${N}" "${trace_file}"
