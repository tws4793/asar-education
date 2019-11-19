# PACKAGES

packages = c(
  'shiny',
  'shinydashboard',
#   'shinythemes',
  'ggplot2',
  'dygraphs',
  'dplyr',
  'lsr',
  'maps'
)

for (p in packages) {
  if (!require(p, character.only = T))
    install.packages(p, dependencies = T)
  library(p, character.only = T)
}

# UI
common = fluidRow(
    column(
        width = 12,
        box(
            title = 'No of Countries',
            width = 4,
            textOutput('over_n_country')
        ),
        box(
            title = 'Singapore Mean',
            width = 4,
            textOutput('over_sg')
        ),
        box(
            title = 'OECD Mean',
            width = 4,
            textOutput('over_oecd')
        )
    )
)

p1 = fluidRow( # Overview of Time Spent Studying and Score
    common,
    fluidRow(
        column(
            width = 12,
            box(
                title = 'Settings',
                status = 'primary',
                width = 3,
                solidHeader = T,
                radioButtons(
                    inputId = 'in_rb_result_main',
                    label = 'Select',
                    choices = c('Study Time', 'Score'),
                    selected = 'Study Time'
                ),
                hr(),
                radioButtons(
                    inputId = 'in_rb_region_main',
                    label = 'Region',
                    choices = c(
                        'ALL',
                        'APAC',
                        'EMEA',
                        'Americas'
                    )
                )
            ),
            box(
                title = 'Country View',
                status = 'primary',
                width = 5,
                solidHeader = T,
                #plotOutput(),
                hr(),
                # plotOutput('plot_bw_cnt', click = 'cl_bw_cnt')
            ),
            box(
                title = 'Top 10 Countries',
                status = 'primary',
                width = 4,
                solidHeader = T,
                # plotOutput('bar_top_cnt', click = 'cl_bar_top_cnt')
            )
        )
    )
)

p2 = fluidRow( # Time Spent Studying vs Score
    # common,
    fluidRow(
        column(
            width = 12,
            box(
                title = 'Settings',
                status = 'primary',
                width = 3,
                solidHeader = T,
                selectInput(
                    inputId = 'in_dd_country_sc',
                    label = 'Select Country',
                    choices = NULL
                )
            ),
            box(
                title = 'Scatter Plot',
                status = 'primary',
                width = 9,
                solidHeader = T,
                # plotOutput('scatter_compare_cnt', click = 'scatter_cnt')
            )
        )
    )
)

p3 = fluidRow( # Time Spent Studying vs Score - Boxplot
    # common,
    fluidRow(
        column(
            width = 12,
            box(
                title = 'Settings',
                status = 'primary',
                width = 3,
                solidHeader = T,
                selectInput(
                    inputId = 'in_dd_country_bp',
                    label = 'Select Country',
                    choices = NULL
                )
            ),
            box(
                title = 'Result',
                status = 'primary',
                width = 9,
                solidHeader = T,
                # plotOutput('scatter_compare_cnt', click = 'scatter_cnt')
            )
        )
    )
)

p4 = fluidRow( # Compare Material Factors vs Time Spent Studying
    fluidRow(
        column(
            width = 12,
            'Hello'
        )
    ),
    fluidRow(
        column(
            width = 12,
            box(
                title = 'Scatter',
                status = 'primary',
                width = 3,
                solidHeader = T,
                radioButtons(
                    inputId = 'in_rb_result_sc',
                    label = 'Select',
                    choices = c('Study Time', 'Score')
                ),
                checkboxGroupInput(
                    inputId = 'in_cb_posessions_sc',
                    label = 'Select Some Posessions',
                    choices = NULL
                )
            ),
            box(
                title = 'Result',
                status = 'primary',
                width = 9,
                solidHeader = T
            )
        )
    )
)

p5 = fluidRow( # Predict Score by Material Factors
    column(
        width = 12,
        box(
            title = 'Settings',
            status = 'primary',
            width = 3,
            solidHeader = T,
            checkboxGroupInput(
                inputId = 'in_cb_posessions_fsc',
                label = 'Select Some Posessions',
                choices = NULL
            )
        ),
        box(
            title = 'Final Predicted Score',
            status = 'primary',
            width = 9,
            solidHeader = T,
            textOutput('txt_final_predict_result')
        )
    )
)

header = dashboardHeader(
    title = 'Education'
)

sidebar = dashboardSidebar(
    sidebarMenu(
        menuItem('Time Spent Studying', tabName = 'main', icon = icon('dashboard')),
        menuItem('Measuring Countries', tabName = 'two'),
        menuItem('Result - World', tabName = 'three'),
        menuItem('Result - Singapore', tabName = 'four'),
        menuItem('Prediction', tabName = 'five')
    )
)

body = dashboardBody(
    tabItems(
        tabItem(tabName = 'main', p1),
        tabItem(tabName = 'two', p2),
        tabItem(tabName = 'three', p3),
        tabItem(tabName = 'four', p4),
        tabItem(tabName = 'five', p5)
    )
)

ui = dashboardPage(
# skin = 'black',
    header,
    sidebar,
    body
)

# SERVER
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
    paste('n hours', '\n', '500')
  })

  output$over_oecd = renderText({
    paste('n hours', '\n', '500')
  })

  output$bar_top_cnt = renderPlot({
      plot()
  })

  output$scatter_compare_cnt = renderPlot({
    plot(
        ggplot(aes(TOT_OSCH_STUDYTIME, PV1_SCI)) +
        geom_point() + 
        geom_smooth(
            method = lm,
            color = 'blue'
        ) + 
        labs(
            title = 'Out of School Study Time over PV Score ',
            x = 'Out of school study time',
            y = 'Plausible Value_Science'
        )
    )
  })

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

shinyApp(ui = ui, server = server, options = list(port = 3838))
