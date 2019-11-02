#!/bin/bash
EID=''
PROJNUM=""
CLASSLIST=""
MAINCLASS=""
CORPORA=""
TRACENAME=""
U=""
C=""
D=""
WEIGHT=""
CORPORA=""
while getopts e:n:l:m:u:t:c:d:w:r:* o
do
    case $o in
        e) EID="$OPTARG";;
        n) PROJNUM="$OPTARG";;
        l) CLASSLIST="$OPTARG";;
        m) MAINCLASS="$OPTARG";;
        t) TRACENAME="$OPTARG";;
        u) U="-u $OPTARG";;
        c) C="-c $OPTARG";;
        d) D="-d $OPTARG";;
        w) WEIGHT="-w $OPTARG";;
        r) CORPORA="$OPTARG";;
    esac
done
shift $OPTIND-1
python3 submit.py -eid $EID -projnum $PROJNUM -classlist $CLASSLIST
prefix="proj${PROJNUM}_${EID}"
trace_file="${prefix}_${TRACENAME}_trace.txt"
main_class=$(find ir -name "${MAINCLASS}")
IFS='.' # hyphen (-) is set as delimiter
read -ra ADDR <<< "$main_class"
class="${ADDR[0]}"
echo "java ${class} ${U} ${C} ${D} ${WEIGHT} ${CORPORA}"
script -c "java ${class} ${U} ${C} ${D} ${WEIGHT} ${CORPORA}" "${trace_file}"