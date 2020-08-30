library(dada2); packageVersion("dada2")

args <- commandArgs(trailingOnly = TRUE)
            
# File parsing
fastqFs <- args[1]
fastqRs <- args[2]

filter_dir <- file.path(dirname(fastqFs), "filtered")

filtFs <- file.path(filter_dir, gsub(".fastq.gz", "_dada2_filtered.fastq.gz", basename(fastqFs)))
filtRs <- file.path(filter_dir, gsub(".fastq.gz", "_dada2_filtered.fastq.gz", basename(fastqRs)))

cat("Filtering FASTQs:", args[1], "and", args[2], "\n")
out <- filterAndTrim(fwd = fastqFs, 
                     filt = filtFs, 
                     rev = fastqRs, 
                     filt.rev = filtRs,
                     truncLen = 0,
                     maxN = 0, 
                     maxEE = c(2,2), 
                     minQ = 10, 
                     rm.phix = TRUE,
                     compress = TRUE,
                     multithread = TRUE)

write.csv(out, "dada2-read-filter-log.csv", append = TRUE)


cat("Saving Quality Plots of Raw FASTQs ... \n")
png(paste0(gsub("_R1_001.fastq.gz", "-quality-plot.png", basename(fastqFs))))
plotQualityProfile(c(fastqFs, fastqRs))
dev.off()


cat("Saving Quality Plots of Filtered FASTQs ... \n")
png(paste0(gsub("_R1_001_dada2_filtered.fastq.gz", "dada2-filtered-quality-plot.png", basename(filtFs))))
plotQualityProfile(c(filtFs, filtRs))
dev.off()


