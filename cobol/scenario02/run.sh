#!/bin/sh


if [ $# -lt 6 ]; then
        echo "Usage:"
        echo " $ "$0 "<cob_module> <batchID> <inRecordFile> <outRecordFile> <outJsonFile> <copybook>"
        echo " "
        echo " Example1:"
        echo "  $ "$0 "BATCH001 BATCH001 infile01.txt outfile01.txt ~/efs/outfile01.json location_message.cpy"
        echo " "
        exit 1
fi

module=$1
batchID=$2
inRecordFile=$3
outRecordFile=$4
outJsonFile=$5
copybook=$6

##### Invoke cobol program
#
export INFILENAME=${inRecordFile}
export OUTFILENAME=${outRecordFile}
export BATCHID=${batchID}

cobcrun ${module}


##### Convert cobol record file to Json
#
sed -i '/^$/d' ${outRecordFile}
c2j.sh ${copybook} ${outRecordFile} ${outJsonFile} 


