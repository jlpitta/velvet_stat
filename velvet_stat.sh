#! /bin/bash
# Script para ler os arquivos "contigs" do velvet, extrair as estatísticas de montagem e gerar um csv.
# By João Pitta (jlpitta82@gmail.com)
# At FIOCRUZ-PE (Recife - PE)
# Tue 03 Mar 2020 14:54 BRT (Primeira versão)

### INICIO: verificações iniciais ###
rm -f listaInput.txt
rm -f result.csv
cabecalho="Strain;number of contigs;total contigs length;mean contig size;contig size first quartile;median contig size;contig size third quartile;longest contig;shortest contig;contigs > 500 nt;contigs > 1K nt;contigs > 10K nt;contigs > 100K nt;contigs > 1M nt;N50;L50;N80;L80"

## Acessa a pasta input para criar a lista com os arquivos
ls input/ > listaInput.txt
sed -e 's/input\///' listaInput.txt -i

## imprime o cabeçalho no arquivo de resultado
echo $cabecalho >> result.csv

while read line; do

    strain=$(echo $line | sed 's/.fasta//' | sed 's/.fna//' | sed 's/.fa//')
    #echo -e "cepa é: $strain"
    echo -e "\nTratando arquivo: $line"
    result=$(gt seqstat -contigs input/$line | sed 's/#.*://' | sed 's/ //g' | tr '\n' ';' | sed 's/;$//')
    echo -e "$strain;$result"
    echo -e "$strain;$result" >> result.csv

done < listaInput.txt

rm -f listaInput.txt
