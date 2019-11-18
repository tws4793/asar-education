# pisa_data = function() {
#   location = 'data/sgdpisa_c.csv'
#   data = read.csv(location, fileEncoding = "UTF-8-BOM")

#   data = na_if(sgdpisa_c, "No Response")
#   data = na_if(sgdpisa_c, "")
#   data = na_if(sgdpisa_c, "Invalid")
#   data = na_if(sgdpisa_c, "Not Applicable")

#   # data$TOT_OSCH_STUDYTIME = as.numeric(as.character(data$TOT_OSCH_STUDYTIME))
#   # data$TOT_SCH_PRD_WK = as.numeric(as.character(data$TOT_SCH_PRD_WK))
#   # data$MINS_CLASS_PRD = as.numeric(as.character(data$MINS_CLASS_PRD))
#   # data$Age = as.numeric(as.character(data$Age))

#   return(data)
# }

pisa_location = 'data/sgdpisa_c.csv'
region_location = 'data/region_code.csv'
pisa = read.csv(pisa_location, fileEncoding = "UTF-8-BOM")
region = read.csv(region_location, fileEncoding = 'UTF-8-BOM')[1:56, 1:3]

pisa = na_if(pisa, "No Response")
pisa = na_if(pisa, "")
pisa = na_if(pisa, "Invalid")
pisa = na_if(pisa, "Not Applicable")
pisa$TOT_OSCH_STUDYTIME = as.numeric(as.character(pisa$TOT_OSCH_STUDYTIME))
pisa$TOT_SCH_PRD_WK = as.numeric(as.character(pisa$TOT_SCH_PRD_WK))
pisa$MINS_CLASS_PRD = as.numeric(as.character(pisa$MINS_CLASS_PRD))
pisa$Age = as.numeric(as.character(pisa$Age))
pisa$CNT[pisa$CNT == 'Spain (Regions)'] = 'Spain'
pisa$CNT[pisa$CNT == 'Massachusettes (USA)'] = 'United States'
pisa$CNT[pisa$CNT == 'North Carolina (USA)'] = 'United States'

pisa_r = merge(x = pisa, y = region, by = 'CNT', all, x = T)

# Comparing Out-of-School Study Time Across Countries
# s_pisa = subset(pisa_r, CNT %in% c('Singapore'))

server = function(input, output) {
  # output$selected_var = renderText({
  #   paste("You have selected", input$var)
  #   paste(input$range, "percent")
  # })

  output$table = renderText({
    paste(117)
  })

  output$over_n_country = renderValueBox({
    valueBox(
      paste(137),
      'Countries',
      color='purple'
    )
  })
  
  output$over_sg_mean_time = renderValueBox({
    valueBox(
      paste(237),
      'Mean Time',
      color='purple'
    )
  })

  output$over_sg_mean_score = renderText({
    paste()
  })

  output$over_oecd_mean_time = renderText({
    paste()
  })

  output$over_oecd_mean_score = renderText({
    paste()
  })

  output$scatter_compare_cnt = renderPlot({
    plot()
  })

  # output$cnt_criteria =

  output$final_predict_result = renderPrint({
    paste('You have selected ', input$in_cb_posessions)
  })
}
