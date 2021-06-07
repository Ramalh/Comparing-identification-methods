# Comparison of *in silico* species identification methods
This series of R codes can make a list of organisms which are present in both NCBI RefSeq nucleotide database and Timetree.org then compare genomic dissimilarity value and phylogenetic distances. [GenDisCal](https://github.com/LM-UGent/GenDisCal) is a tool that calculates dissimilarity values of genomes while [Timetree.org](http://www.timetree.org/) is a database that employs evolutionary distances (phylogenetic distances) of species. Then using the list of organisms, two kinds of files (one from GenDisCal, another is from Timetree.org) can be made. GenDisCal provides genetic distances (dissimilarity values) of these organisms, and Timetree.org provides phylogenetic distances. These two output files can be compared by plotting 

## Common species list
RForComparison makes a file which is the list of common organisms shared by both NCBI RefSeq nucleotide database and Timetree.org (All_asmpls.txt). This file has information about the common species and can be used for making input files of GenDisCal and Timetree.org. Another file that is made, is phylogenetic distances list (named as "timetree-dist.Rdata"). To run this file, some files from NCBI are need. The first file is taxonomy dump [file](https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump/). "Names.dmp" file in this directory is the first input file. Other input files are:

[assemly summary refseq](https://ftp.ncbi.nlm.nih.gov/genomes/refseq/assembly_summary_refseq.txt)

[category taxonomy](https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxcat.zip)

## GenDisCal taxonomy
You may want GenDisCal output file to have taxonomic relation of compared organisms. Two files are need for this. One is "Nodes.dmp" in taxonomy dump directory. Another can be written by NCBI_taxonomyR. There is one input for it: which is the output of the RForComparison labeled as "All_asmbl.txt".

**!These two mentioned files should be in the same directory when GenDisCal is running**

## Sorting GenDisCal and Timetree output files
These files sort several output GenDisCal files in series. Input files for GenDisCal sorting are the file contains phylogeny of the organisms (named as "timetree-dist.Rdata"), paths of GenDisCal output files,  and names of these file in a file. Output files are sorted GenDisCal files. "Sorting tree file.r" file puts  all comparisons, which are in the matrix, in a list. Then sort this list according to a fixed column which is the common column with GenDisCal files. In this way, both GenDisCal and Timetree files will be sorted in  the same way.

## Multi-plots
 Both timetree and GenDisCal files should be ready after using sorting codes. All GenDisCal sorted output files can be compared by their relations with phylogeny. Input files are outputs of sorting GenDisCal and Timetree, paths of GenDisCal files, and lastly names of GenDIsCal files. All signatures and methods can not be displayed at the same time, since there are more than 25 combinations.

## Histogram Distance
The distribution of the distances can be examined with colored taxonomy. The only output file is a GenDisCal output file.

## Eukarya Bacteria
Eukaryotes and Bacteria can be separated with this file. There are two output files: the common species list which has the species belong to Bacteria superkingdom and the second list which has the species belong to the Eukaryote superkingdom. Input files are common organisms (All_asmbls.txt) and category taxonomy files (categories.dmp).

## Boxplot GenDisCal
This one makes a boxplot that shows what part of the phylogeny occupied by the genetic distance in a range of 0.1 width
