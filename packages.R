file = 'packages.txt'
conn = file(file, open = 'r')
lines = readLines(conn)

for (i in 1:length(lines)) {
  p = lines[i]
  if (!require(p, character.only = T))
    install.packages(p, dependencies = TRUE, repos = 'http://cran.rstudio.com')
  library(p, character.only = T)
}
