#!/bin/sh

module=BATCHD01
batchID=BATCHD01
copybook=order_message.cpy
inRecordFile=infile_sjis01.txt
outLogFile=~/efs/order_${batchID}.log

date_time=$(date +%Y%m%d_%H%M%S)
outRecordFile=temp_${batchID}_${date_time}.txt
outJsonFile=~/efs/order_${batchID}_${date_time}.json

run_dbcs.sh ${module} ${batchID} ${inRecordFile} ${outRecordFile} ${outJsonFile} ${copybook} >> ${outLogFile}
#echo run.sh ${module} ${batchID} ${inRecordFile} ${outRecordFile} ${outJsonFile} ${copybook}

if [ -e ${outRecordFile} ] ; then
	rm -f ${outRecordFile}
fi


