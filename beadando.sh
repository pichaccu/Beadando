#!/bin/bash
if [ $# -eq 0 ]
 then
	echo "Which currency do you want to convert from?"
	read fromCurrency
	echo "Which currency do you want to convert it to?"
	read toCurrency
	echo "Required amount"
	read quality
 else
	fromCurrency=$1
	toCurrency=$2
	if [ -z "$3" ]
	then
		quality="1"
	else
		quality=$3
fi fi
RATE=`curl -sb -H "Accept: application/json" "https://api.exchangeratesapi.io/latest?symbols=${toCurrency^^}&base=${fromCurrency^^}" | awk 'BEGIN { FS="\""; RS="," }; { if ($2 == "rates") {print $5} }'| grep -Eo '[+-]?[0-9]+([.][0-9]+)?'`
echo "$quality $fromCurrency is $(($quality*$RATE) | bc -l) $toCurrency"
