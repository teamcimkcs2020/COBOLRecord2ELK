#!/bin/sh

module=BATCH001
batchID=BATCH003
copybook=location_message.cpy
inRecordFile=infile01.txt
outLogFile=~/efs/cob_${batchID}.log

for cnt in $(seq 50)
do
	echo ${batchID}_${cnt}
	date_time=$(date +%Y%m%d_%H%M%S)
	outRecordFile=temp_${batchID}_${date_time}.txt
	outJsonFile=~/efs/cob_${batchID}_${date_time}.json

	run.sh ${module} ${batchID} ${inRecordFile} ${outRecordFile} ${outJsonFile} ${copybook} >> ${outLogFile}
	#echo run.sh ${module} ${batchID} ${inRecordFile} ${outRecordFile} ${outJsonFile} ${copybook}

	if [ -e ${outRecordFile} ] ; then
		rm -f ${outRecordFile}
	fi
done


