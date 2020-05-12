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
        while getopts f:t:q: option
        do
        case "${option}"
        in
        f) fromCurrency=${OPTARG};;
        t) toCurrency=${OPTARG};;
        q) quality=${OPTARG};;
        esac
        done

        if [ -z "$fromCurrency" ]
        then
                echo "Which currency do you want to convert from?"
                read fromCurrency
        fi

        if [ -z "$toCurrency" ]
        then
                toCurrency="huf"
        fi

        if [ -z "$quality" ]
        then
                quality=1
        fi
 fi
RATE=`curl -sb -H "Accept: application/json" "https://api.exchangeratesapi.io/latest?symbols=${toCurrency^^}&base=${fromCurrency^^}" | awk 'BEGIN { FS="\""; RS="," }; { if ($2 == "rates") {print $5} }'| grep -Eo '[+-]?[0-9]+([.][0-9]+)?'`
sum=$(bc <<< "${quality} * ${RATE}")
echo "$quality $fromCurrency is $sum $toCurrency"
