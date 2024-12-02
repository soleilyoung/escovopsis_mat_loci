#!/usr/bin/env python
import argparse, subprocess

parser = argparse.ArgumentParser(description = '''
Makes bed and cds files for mcscan. Must be run in enviroment with JCVI installed

Usage: python mcscan_prep.py --strain_list <strains.txt>
Flags:
    --strain_list text file with strain accessions
''')
parser.add_argument('--strain_list', help = 'text file with strain accesions', type = str)
args = parser.parse_args()
strain_list = args.strain_list

strains = []

with open(strain_list, 'r') as strain_f:
    for line in strain_f:
        line = line.rstrip("\n")
        strains.append(line)

for strain in strains:
    strain_gff_path = strain+"/"+strain+".genemodels.gff"
    strain_cds_path = strain+"/"+strain+".all.maker.transcripts.fasta"
    make_bed = subprocess.Popen(["python","-m","jcvi.formats.gff","bed","--type=mRNA",strain_gff_path,\
	"-o","../../"+strain+".bed"])
    make_bed.communicate()
    make_cds = subprocess.Popen(["python","-m","jcvi.formats.fasta","format",strain_cds_path,"../../"+strain+".cds"])
    make_cds.communicate()
