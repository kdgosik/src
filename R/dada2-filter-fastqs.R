library(dada2); packageVersion("dada2")

args <- commandArgs(trailingOnly = TRUE)
            
# File parsing
fastqFs <- args[1]
fastqRs <- args[2]


sample.names <- sapply(strsplit(basename(fastqFs), "_"), `[`, 1)

filter_dir <- file.path(dirname(fastqFs), "filtered")

filtFs <- file.path(filter_dir, gsub(".fastq.gz", "_dada2_filtered.fastq.gz", basename(fastqFs)))
filtRs <- file.path(filter_dir, gsub(".fastq.gz", "_dada2_filtered.fastq.gz", basename(fastqRs)))

cat("Filtering FASTQs:", args[1], "and", args[2], "\n")
out <- filterAndTrim(fwd = fastqFs, 
                     filt = filtFs, 
                     rev = fastqRs, 
                     filt.rev = filtRs,
                     truncQ = 0,
                     truncLen = 0,
                     maxN = 0, 
                     maxEE = c(3,3), 
                     minQ = 10,
                     compress = TRUE,
                     multithread = TRUE)

write.csv(out, "dada2-read-filter-log.csv", append = TRUE)


cat("Saving Quality Plots of Raw FASTQs ... \n")
pdf(paste0("results/", sample.names, "-quality-plot.pdf"))
plotQualityProfile(c(fastqFs, fastqRs))
dev.off()


cat("Saving Quality Plots of Filtered FASTQs ... \n")
pdf(paste0("results/", sample.names, "-dada2-filtered-quality-plot.pdf"))
plotQualityProfile(c(filtFs, filtRs))
dev.off()


