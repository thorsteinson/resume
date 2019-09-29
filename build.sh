#!/bin/bash

if [ -z $PHONE ]
then
    echo Please export \$PHONE variable
else
    <resume.tex sed "s/(999)-999-9999/$PHONE/" | xelatex
fi
