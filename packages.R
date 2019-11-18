# packages = c(
#   'shiny',
#   'shinythemes',
#   'ggplot2',
# #'plotly',
#   'dygraphs',
#   'dplyr',
#   'lsr',
#   'maps'
# )

file = 'packages.txt'
conn = file(file, open = 'r')
lines = readLines(conn)

for (i in 1:length(lines)) {
  if (!require(lines[i], character.only = T))
    install.packages(p, dependencies = TRUE, repos = 'http://cran.rstudio.com')
    # install.packages(p, repos = '$MRAN')
    # install.packages(p)
  library(lines[i], character.only = T)
}