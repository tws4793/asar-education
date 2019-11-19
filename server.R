# source('packages.R')

pisa_location = 'data/sgdpisa_c.csv'
region_location = 'data/region_code.csv'
pisa = read.csv(pisa_location, fileEncoding = 'UTF-8-BOM', header = T, stringsAsFactors = F)
region = read.csv(region_location, fileEncoding = 'UTF-8-BOM')[1:56, 1:3]

get_countries = region$CNT
get_regions = region %>% distinct('Sub-region')
get_resultant_factor = c(
    'Study Time',
    'Score'
)
get_posessions = c(
    'Books',
    'Maid',
    'Study'
)

# Data Cleaning
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
s_pisa = subset(pisa_r, CNT %in% get_countries)

server = function(input, output, session) {
    output$over_n_country = renderText({
        paste(110)
    })

    output$over_sg = renderText({
        paste('hours', '\n', '500')
    })

    output$over_oecd = renderText({
        paste('hours', '\n', '500')
    })

    # output$scatter_compare_cnt = renderPlot({
    #   plot()
    # })

    output$txt_final_predict_result = renderText({
        paste('You have selected ')
    })

    updateSelectInput(
        session,
        inputId = 'in_dd_country_sc',
        choices = get_countries,
        selected = get_countries[1]
    )
    updateSelectInput(
        session,
        inputId = 'in_dd_country_bp',
        choices = get_countries,
        selected = get_countries[1]
    )
    updateCheckboxGroupInput(
        session,
        inputId = 'in_cb_posessions_sc',
        choices = get_posessions,
        selected = get_posessions[1]
    )
    updateCheckboxGroupInput(session,
        inputId = 'in_cb_posessions_fsc',
        choices = get_posessions,
        selected = get_posessions[1]
    )
    updateRadioButtons(
        session,
        inputId = 'in_rb_result_main',
        label = 'Select',
        choices = get_resultant_factor,
        selected = get_resultant_factor[0]
    )
    updateRadioButtons(
        session,
        inputId = 'in_rb_result_sc',
        label = 'Select',
        choices = get_resultant_factor,
        selected = get_resultant_factor[0]
    )
}
