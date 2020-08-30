library(dada2); packageVersion("dada2")

args <- commandArgs(trailingOnly = TRUE)

# File parsing
filtFs <- args[1]
filtRs <- args[2]


sample.names <- sapply(strsplit(basename(filtFs), "_"), `[`, 1) # Assumes filename = samplename_XXX.fastq.gz
sample.namesR <- sapply(strsplit(basename(filtRs), "_"), `[`, 1) # Assumes filename = samplename_XXX.fastq.gz

if(!identical(sample.names, sample.namesR)) stop("Forward and reverse files do not match.")

names(filtFs) <- sample.names
names(filtRs) <- sample.names

set.seed(100)
cat(as.character(Sys.time()), ": Learn forward error rates ... \n")
errF <- learnErrors(filtFs, nbases=1e8, multithread=TRUE)

cat(as.character(Sys.time()), ": Learn reverse error rates ... \n")
errR <- learnErrors(filtRs, nbases=1e8, multithread=TRUE)

cat(as.character(Sys.time()), ": Sample inference and merger of paired-end reads ... \n")
mergers <- vector("list", length(sample.names))
names(mergers) <- sample.names


cat(as.character(Sys.time()), ": Processing:", sample.names, "\n")

derepF <- derepFastq(filtFs[[sample.names]])
ddF <- dada(derepF, err=errF, multithread=TRUE)
  
derepR <- derepFastq(filtRs[[sample.names]])
ddR <- dada(derepR, err=errR, multithread=TRUE)
  
merger <- mergePairs(ddF, derepF, ddR, derepR)
mergers[[sample.names]] <- merger


rm(derepF); rm(derepR)

# Construct sequence table and remove chimeras
seqtab <- makeSequenceTable(mergers)
saveRDS(seqtab, paste0("results/dada2-seqtab-", sample.names, ".rds"))