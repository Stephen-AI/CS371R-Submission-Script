EID="sa46979"
PROJNUM="3"
PREFIX="proj${PROJNUM}_${EID}"
MAIN_TRACE="${PREFIX}_trace.txt"
TEMP_TRACE="${PREFIX}_temp_trace.txt"

python3 submit.py -eid $EID -projnum $PROJNUM -classlist sources.txt
touch $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestNaiveBayes.java -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestKNN.java -k 1 -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestKNN.java -k 3 -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestKNN.java -k 5 -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestRocchio.java -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
./zip_shell.sh -p $PREFIX -m TestRocchio.java -n 0 -t temp
cat $TEMP_TRACE >> $MAIN_TRACE
rm $TEMP_TRACE
