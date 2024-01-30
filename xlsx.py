#!/usr/bin/env python3

"""
    usage:

"""

# METADATA VARIABLES
__author__ = "Orfeas Gkourlias"
__status__ = "WIP"
__version__ = "0.1"


import pandas as pd
import sys
from pathlib import Path

def convert(file_path):
   newF = pd.read_excel(Path(file_path))
   newF.to_csv(f"{Path(file_path).stem}.csv")

# MAIN
def main(args):
    """ Main function """
    convert(sys.argv[1])
    # FINISH
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))