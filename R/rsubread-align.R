library(Rsubread)
# http://bioconductor.org/packages/release/bioc/vignettes/Rsubread/inst/doc/Rsubread.pdf

args <- commandArgs(trailingOnly = TRUE)

##
reads1 <- args[1]
reads2 <- args[2]


sample.names <- sapply(strsplit(basename(reads1), "_"), `[`, 1)

align.stat2 <- align(index="reference_index",
                     readfile1 = reads1,
                     readfile2 = reads2,
                     TH1 = ,
                     TH2 = ,
                     maxMismatches = 3,
                     nBestLocations = 5,
                     indels = 2,
                     nthreads = 6,
                     output_file = paste0("data/bam/", sample.names, "-subread-align.bam"))


