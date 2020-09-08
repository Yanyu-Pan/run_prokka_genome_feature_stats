#!/bin/bash
printUsage(){
        echo "usage: run_prokka_genome_feature_stats.sh -i <filename.tsv> "
        exit -1
    }
    if [ $# -eq 0 ];then
        printUsage
    fi
    while getopts :hi: opts;do
        case "$opts" in
            i)
                inputfile=$OPTARG
                if [ ! -f $inputfile ];then
                    echo "The input file $inputfile doesn't exist!"
                    exit -1
                fi
                ;;
            h)
                printUsage
                ;;
            :)
                echo "$0 must supply an argument to option -$OPTARG!"
                printUsage
                ;;
            ?)
                echo "invalid option -$OPTARG ignored!"
                printUsage
                ;;
        esac
    done
awk '{if($2=="CDS") ++sum1;if($2=="tRNA") ++sum2;if($2=="rRNA") ++sum3;if($4=="5S") ++sum4;if($4=="16S") ++sum5;if($4=="23S") ++sum6}END{print "CDS""\t"sum1"\n""tRNA""\t"sum2"\n""rRNA""\t"sum3"\n""5S""\t"sum4"\n""16S""\t"sum5"\n""23S""\t"sum6}' $inputfile
