EID="sa46979"
PROJNUM="3"
PREFIX="proj${PROJNUM}_${EID}"
RETRIEVE_TRACE="${PREFIX}_retrieve_trace.txt"
TEMP_TRACE="${PREFIX}_temp_trace.txt"

python3 submit.py -eid $EID -projnum $PROJNUM -classlist sources.txt
./zip_shell.sh -p $PREFIX -m PageRankSiteSpider.java -c 200 -d crawled -t spider -u http://www.cs.utexas.edu/~mooney/ir-course/proj3/a.html 
rm $RETRIEVE_TRACE
touch $RETRIEVE_TRACE
./zip_shell.sh -p $PREFIX -m PageRankInvertedIndex.java -t temp -w 0.0 -r crawled
cat $TEMP_TRACE >> $RETRIEVE_TRACE
./zip_shell.sh -p $PREFIX -m PageRankInvertedIndex.java -t temp -w 5.0 -r crawled
cat $TEMP_TRACE >> $RETRIEVE_TRACE
./zip_shell.sh -p $PREFIX -m PageRankInvertedIndex.java -t temp -w 10.0 -r crawled
cat $TEMP_TRACE >> $RETRIEVE_TRACE
rm $TEMP_TRACE