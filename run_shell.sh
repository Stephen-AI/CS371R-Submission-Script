ZIPINDIR="proj2_sa46979_outputs"
GRAPHDIR="graphs"
mkdir -p "${ZIPINDIR}/n1"
mkdir -p "${ZIPINDIR}/n3"
mkdir -p "${ZIPINDIR}/n5"
mkdir -p "${GRAPHDIR}/n1"
mkdir -p "${GRAPHDIR}/n3"
mkdir -p "${GRAPHDIR}/n5"
for i in {1..5..2}
    do
        mkdir "n${i}"
        ./zip_shell.sh -e sa46979 -m ExperimentRelFeedbackRated.java -n 2 -l sources.txt -t rated -f ${i}
        cp "n${i}/rated" "${ZIPINDIR}/n${i}/"
        cp "n${i}/rated.ndcg" "${ZIPINDIR}/n${i}/"
        ./zip_shell.sh -e sa46979 -m ExperimentRelFeedbackRated.java -b 0 -n 2 -l sources.txt -t binary -f ${i}
        cp "n${i}/binary" "${ZIPINDIR}/n${i}/"
        cp "n${i}/binary.ndcg" "${ZIPINDIR}/n${i}/"
        ./zip_shell.sh -e sa46979 -m ExperimentRelFeedbackRated.java -z 0 -n 2 -l sources.txt -t control -f ${i}
        cp "n${i}/control" "${ZIPINDIR}/n${i}/"
        cp "n${i}/control.ndcg" "${ZIPINDIR}/n${i}/"
        cd "n${i}"
        gnuplot "combined.gplot" | ps2pdf - "../${GRAPHDIR}/n${i}/combined-n${i}.pdf"
        gnuplot "combined.ndcg.gplot" | ps2pdf - "../${GRAPHDIR}/n${i}/combinedNDCG-n${i}.pdf"
        cd ..
    done
cd "${ZIPINDIR}"
zip -r "${ZIPINDIR}.zip" n1 n3 n5
mv "${ZIPINDIR}.zip" ..
cd ..