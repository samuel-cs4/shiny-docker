library(shiny)
library(shinydashboard)
library(waiter)

sidebar <- dashboardSidebar(
  
  waiter::use_waiter(),
  
  waiter::waiter_show_on_load(
    tagList(
      img(src = 'logo.png', width = '50%', heigh = '50%'),
      waiter::spin_fading_circles(), 
      span("Loading...", style = "font-size: 18px;")
    )
  ),
  
  sidebarMenu(
    
    menuItem('Home', tabName = 'home', icon = icon("home"))
    
  )
)

# ui
ui <- dashboardPage(
  
  skin = 'blue',
  
  title = '4intelligence', 
  
  dashboardHeader(title = tags$a(tags$img(src = 'logo.png', width = "90%", style = "margin-bottom: 5px;"))), 
  
  sidebar,
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              
              # Home Page
              fluidPage(
                
                div(align = 'center',
                    img(src = 'https://avatars.githubusercontent.com/u/62453560?s=200&v=4'),
                    
                    
                    h1(Sys.getenv('PROJECT_NAME')),
                    
                    h3('Informações do Sistema Operacional'),
                    
                    br(), br(),
                    
                    dataTableOutput('sys_info')
                ),
                
              )
      )
    )
  )
)

# server
server <- function(input, output, session) {
  
  # Loading...
  
  output$sys_info <- renderDataTable({
    
    table <- as.data.frame(Sys.info())
    
    table$info <- rownames(table)
    
    colnames(table) <- c('Descrição', 'Informação')
    rownames(table) <- NULL
    
    data.frame('Informação' = table$`Informação`, 
               'Descrição' = table$`Descrição`)
    
  }, options = list(searching = FALSE, ordering = FALSE, paging = FALSE))
  
  waiter::waiter_hide()
  
}

shinyApp(ui, server)