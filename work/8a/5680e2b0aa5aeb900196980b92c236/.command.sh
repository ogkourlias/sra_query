#!/bin/bash -ue
awk -F ""*,"*" '{print $2}' selected_samples_final.csv

# capture process environment
set +u
echo ids=${ids[@]} > .command.env
