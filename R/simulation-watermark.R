watermark <- unlist(strsplit("GTRGCNATHGCNTTYGTNGGNGAYGCNAARGTNGTNATHCTNGAYGARCCNACNAGYGGN", ""))


sample_watermark <- function(n) {
  replicate(n, {
    sapply(watermark, function(s){
      switch(s,
             A = return("A"),
             C = return("C"),
             G = return("G"),
             T = return("T"),
             H = sample(c("A", "C", "T"), 1),
             R = sample(c("A", "G"), 1),
             S = sample(c("C", "G"), 1),
             Y = sample(c("C", "T"), 1),
             N = sample(c("A", "C", "G", "T"), 1))
      }, simplify = TRUE)
  })
}