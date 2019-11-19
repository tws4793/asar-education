# install.packages('shinydashboard')
library(shinydashboard)

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

p1 = fluidRow(
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
                br(),
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

p2 = fluidRow(
    common,
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

p3 = fluidRow(
    common,
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

p4 = fluidRow(
    fluidRow(

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

p5 = fluidRow(
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
