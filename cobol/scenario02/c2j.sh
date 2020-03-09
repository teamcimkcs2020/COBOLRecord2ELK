#!/bin/sh

copybook=$1
inRecordFile=$2
outJsonFile=$3

tempFile=${outJsonFile}_temp

/home/ec2-user/c2j/lib/Cobol2Json.sh -cobol ${copybook} -fileOrganisation Text -input ${inRecordFile} -output ${tempFile} # > /dev/null 2> /dev/null
jq -c . ${tempFile} > ${outJsonFile}

if [ -e ${tempFile} ]; then
	rm -f ${tempFile}
fi
