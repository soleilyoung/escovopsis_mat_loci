#!/bin/sh
#
#unzipping the genome folder
tar -xzvf "$1".fasta.tar.gz

access="$1"
#
cp /staging/seyoung7/hypocreales_odb10.2024-01-08.tar.gz .
tar -xzvf hypocreales_odb10.2024-01-08.tar.gz
#
cat /usr/local/bin/busco/config/config.ini | sed 's|/usr/local/bin/|/usr/bin/|'> /usr/local/bin/busco/config/temp
mv /usr/local/bin/busco/config/temp /usr/local/bin/busco/config/config.ini
#
run_BUSCO.py -i "$access".fa -o "$access"_busco -l ./hypocreales_odb10 -m genome
#
tar -czf run_"$access"_busco.tar.gz run_"$access"_busco/
cp run_"$access"_busco.tar.gz /staging/seyoung7/busco