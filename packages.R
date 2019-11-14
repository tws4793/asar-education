packages = c(
  'shiny',
  'shinythemes',
  'ggplot2',
#'plotly',
  'dygraphs',
  'dplyr',
  'lsr',
  'maps'
)

for (p in packages) {
  if (!require(p, character.only = T))
    install.packages(p, dependencies = TRUE, repos = 'http://cran.rstudio.com')
  library(p, character.only = T)
}