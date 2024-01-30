#!/bin/bash -ue
awk -F ""*,"*" '{print $2}' input/selected_samples_final.csv | cat
