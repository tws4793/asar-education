source('packages.R')

pisa_data = function() {
  location = 'data/sgdpisa_c.csv'
  data = read.csv(location, fileEncoding = "UTF-8-BOM")

  data = na_if(sgdpisa_c, "No Response")
  data = na_if(sgdpisa_c, "")
  data = na_if(sgdpisa_c, "Invalid")
  data = na_if(sgdpisa_c, "Not Applicable")

  return(data)
}

pisa_data$TOT_OSCH_STUDYTIME <- as.numeric(as.character(sgdpisa_c$TOT_OSCH_STUDYTIME))
pisa_data$TOT_SCH_PRD_WK <- as.numeric(as.character(sgdpisa_c$TOT_SCH_PRD_WK))
pisa_data$MINS_CLASS_PRD <- as.numeric(as.character(sgdpisa_c$MINS_CLASS_PRD))
pisa_data$Age <- as.numeric(as.character(sgdpisa_c$Age))

selpisa = subset(pisa_r, CNT %in% c('Singapore'))
# group_by(selpisa, CNT) %&gt;% summarise
# (count = n(), meanstudy = mean(TOT_OSCH_STUDYTIME, na.rm = TRUE), maxstudy = max(TOT_OSCH_STU
# DYTIME, na.rm = TRUE), sdstudy = sd(TOT_SCH_PRD_WK, na.rm = TRUE))

server = function(input, output) {
  # output$selected_var <- renderText({
  #   paste("You have selected", input$var)
  #   paste(input$range, "percent")
  # })

  output$table = renderText({
    #paste(sgdpisa_c)
    paste(selpisa)
  })
}
