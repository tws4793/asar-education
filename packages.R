# file = 'packages.txt'
# conn = file(file, open = 'r')
# lines = readLines(conn)

packages = c(
  'shiny',
  'shinydashboard',
  'shinythemes',
  'ggplot2',
  'dygraphs',
  'dplyr',
  'lsr',
  'maps'
)

for (p in packages) {
  # p = lines[i]
  if (!require(p, character.only = T))
    install.packages(p, dependencies = T)
  library(p, character.only = T)
}
