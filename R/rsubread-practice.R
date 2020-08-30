library(Rsubread)
# http://bioconductor.org/packages/release/bioc/vignettes/Rsubread/inst/doc/Rsubread.pdf

reads <- system.file("extdata","reads.txt.gz",package="Rsubread")
align.stat <- align(index="reference_index",
                    readfile1 = reads,
                    output_file = "alignResults.BAM",
                    phredOffset = 64)


reads1 <- system.file("extdata","reads1.txt.gz",package="Rsubread")
reads2 <- system.file("extdata","reads2.txt.gz",package="Rsubread")
align.stat2 <- align(index="reference_index",
                     readfile1 = reads1,
                     readfile2 = reads2,
                     output_file = "alignResultsPE.BAM", 
                     phredOffset = 64)



ann <- data.frame(
  eneID=c("gene1","gene1","gene2","gene2"),
  Chr="chr_dummy",
  Start=c(100,1000,3000,5000),
  End=c(500,1800,4000,5500),
  Strand=c("+","+","-","-"),
  stringsAsFactors=FALSE)
  
ann


fc_SE <- featureCounts("alignResults.BAM", annot.ext = ann)
