#!/bin/bash -ue
awk -F ""*,"*" '{print $2}' selected_samples_final.csv
