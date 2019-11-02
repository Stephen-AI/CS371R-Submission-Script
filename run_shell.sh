EID="sa46979"
PROJNUM="3"
PREFIX="proj${PROJNUM}_${EID}"
RETRIEVE_TRACE="${PREFIX}_retrive_trace.txt"
TEMP_TRACE="${PREFIX}_temp_trace.txt"

./zip_shell.sh -e $EID -m PageRankSiteSpider.java -n $PROJNUM -l sources.txt -c 200 -d crawled -t spider -u http://www.cs.utexas.edu/~mooney/ir-course/proj3/a.html 
touch $RETRIEVE_TRACE
./zip_shell.sh -e $EID -m PageRankInvertedIndex.java -n $PROJNUM -l sources.txt -t temp -d crawled -w 0.0
cat $TEMP_TRACE >> $RETRIEVE_TRACE
./zip_shell.sh -e $EID -m PageRankInvertedIndex.java -n $PROJNUM -l sources.txt -t temp -d crawled -w 5.0
cat $TEMP_TRACE >> $RETRIEVE_TRACE
./zip_shell.sh -e $EID -m PageRankInvertedIndex.java -n $PROJNUM -l sources.txt -t temp -d crawled -w 10.0
cat $TEMP_TRACE >> $RETRIEVE_TRACE