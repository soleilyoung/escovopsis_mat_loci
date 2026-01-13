#!/usr/bin/env python
import argparse, subprocess

parser = argparse.ArgumentParser(description = '''
runs MAFFT, trimal, and iqtree2 to make gene trees for ASTRAL and SNAQ on busco single copy genes

Usage: make_gene_trees.py --gene_list <buscos.txt>
Flags:
    --gene_list text file with gene IDs
''')
parser.add_argument('--gene_list', help = 'text file with list of gene IDs', type = str)
args = parser.parse_args()
gene_list = args.gene_list

genes = []

with open(gene_list, 'r') as gene_f:
    for line in gene_f:
        line = line.rstrip("\n")
        genes.append(line)

for gene in genes:
    busco_seq = str("../busco_seq/"+gene+".fasta")
    subprocess.call("sed -i'' -e 's/:/_/' "+busco_seq, shell=True)
    subprocess.call("mafft --auto "+busco_seq+" > ../aligned_seqs/"+gene+"_aln.fasta", shell=True)
    trim = subprocess.Popen(["trimal","-automated1","-in","../aligned_seqs/"+gene+"_aln.fasta",
                             #"-out","../aligned_seqs/"+gene+"_trim.fasta"])
    trim.communicate()
    iqtree2 = subprocess.Popen(["iqtree2","--boot-trees","-T","3","-s",
                                "../aligned_seqs/"+gene+"_trim_fixed.fasta","-B","1000"])
    iqtree2.communicate()
