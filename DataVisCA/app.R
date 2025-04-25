#loaded in required libraries
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(rsconnect)

#load the data, PL is Player data, TD is Team data
PL2324=read.csv("PlayerData2324.csv")
PL0304=read.csv("PlayerData0304.csv")
TD2324=read.csv("TeamData2324.csv")
TD0304=read.csv("TeamData0304.csv")

#combined team data for analysis
premier_league_data <- bind_rows(
  TD2324 %>% mutate(Season = "2023-24"),
  TD0304 %>% mutate(Season = "2003-04")
)

#created team colours
team_colours <- c(
  "Arsenal" = "#EF4135",
  "Aston Villa" = "#95BFE5",
  "Bournemouth" = "#D00000",
  "Brentford" = "#9C1B32",
  "Brighton" = "#0059A0",
  "Burnley" = "#7A1000",
  "Chelsea" = "#034694",
  "Crystal Palace" = "#1B458F",
  "Everton" = "#003F87",
  "Fulham" = "#000000",
  "Liverpool" = "#C8102E",
  "Luton Town" = "#FFA500",
  "Manchester City" = "#6CABDD",
  "Manchester Utd" = "#DA291C",
  "Newcastle Utd" = "#232F3E",
  "Nott'ham Forest" = "#B91D2C",
  "Sheffield Utd" = "#EE3434",
  "Tottenham" = "#132F5C",
  "West Ham" = "#7A0019",
  "Wolves" = "#FDB913")

#created the user interface as a NavbarPage layout
ui <- navbarPage(
  title = "Shiny App",
  #this is the analysis of the 2023-24 player data
  tabPanel(
    title = "Premier League 2023-24",
    h1("Premier League 2023-24 Dashboard"),
    fluidRow(
      column(6, 
        selectInput(
        inputId = "squad_select", 
        label = "Select teams:", 
        choices = sort(PL2324$Squad),
        selected = PL2324$Squad,
        multiple = TRUE
        )
      ),
      #split into even parts as I wanted them horizontal       
      column(6, 
        sliderInput(
        inputId = "age_filter", 
        label = "Select age range:",
        min = min(PL2324$Age), 
        max = max(PL2324$Age),
        value = c(min(PL2324$Age), max(PL2324$Age)),
        step = 1
        )
      )
    ),
  #plotted the graph I created
  plotlyOutput("xGplot")
  ), 
  #this is the comparison between the 2023-24 season with 2003-04 season
  tabPanel(
    title = "Statistic Comparison",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "stat",
          label = "Select Statistic to Compare:",
          choices = c("Goals"="Gls", "Age", "Penalties"="PK", 
                      "Yellow Cards"="CrdY", "Red Cards"="CrdR"),
          selected = "Gls"
        )
      ),
      #plotted the graph and the summary statistics
      mainPanel(
        plotOutput("comparisonPlot"),
        br(),
        h4("Summary Statistics"),
        tableOutput("dataSummary")
      )
    )
  ),
  #this is the player data based on the filters using the two player datasets
  tabPanel(
    title = "Player Metrics",
    sidebarLayout(
      sidebarPanel(
        selectInput("squad", "Select Squad:",
                    choices = c("All", sort(PL2324$Squad), sort(PL0304$Squad)),
                    selected = "All"),
        selectInput("pos", "Select Pos:",
                    choices = c("All", unique(PL2324$Pos)),
                    selected = "All"),
        selectInput("metric", "Select Metric to Compare:",
                    choices = c("Goals" = "Gls", "Assists" = "Ast", 
                                "Penalties" = "PK", "Yellow Cards" = "CrdY"),
                    selected = "Gls")
      ),
      #plot the graph created
      mainPanel(
        h3("Comparison Plot"),
        plotlyOutput("player_plot")
      )
    )
  )
)

#created the server
server <- function(input, output, session) {
  #this is the first plot comparing goals with
  #expected goals from the 2023-24 season
  output$xGplot <- renderPlotly({
    df_filtered <- PL2324 %>%
      #this updates the plot based of the age filter
      filter(Squad %in% input$squad_select,
             Age >= input$age_filter[1], 
             Age <= input$age_filter[2])
    #this created the plotly scatterplot of xg and Goals with a basic slope
    plot1 = ggplot(df_filtered, aes(
      x = xG, y = Gls, 
      color = Squad,
      text = paste(
        'Name:', Player, '<br>', 
        'Club:', Squad, '<br>', 
        'Position:', Pos, '<br>', 
        'Goals:', Gls,'<br>',
        'xG:', xG,'<br>',
        'Number of Starts:', Starts
      )
    )) +
      geom_point() +
      geom_abline() +
      labs(
        title = "Goals vs Expected Goals",
        x = "xG",
        y = "Goals"
      ) +
      scale_color_manual(values = team_colours)
      theme_minimal()
      
    ggplotly(plot1, tooltip = "text")
  })
  #this created a boxplot of the different metrics of the 2003-04 and 2023-24 seasons
  output$comparisonPlot <- renderPlot({
    ggplot(data = premier_league_data, 
           aes_string(x = "Season", y = input$stat, fill = "Season")) +
      geom_boxplot() +
      labs(
        title = paste("Comparison of", input$stat, "between 2003-04 and 2023-24"),
        x = "Season",
        y = input$stat
      ) +
      theme_minimal()
  })
  #this is the general statistics of the selected metric to compare the seasons
  output$dataSummary <- renderTable({
    premier_league_data %>%
      group_by(Season) %>%
      summarise(
        Mean = mean(.data[[input$stat]]),
        Median = median(.data[[input$stat]]),
        Min = min(.data[[input$stat]]),
        Max = max(.data[[input$stat]])
      )
  })
  #this made the reactive options for the filters, multiple can be chosen using "if" statements
  filtered_data <- reactive({
    data2324 <- if (input$squad != "All") {
      PL2324 %>% filter(Squad == input$squad)
    } else {
      PL2324
    }
    
    data0304 <- if (input$squad != "All") {
      PL0304 %>% filter(Squad == input$squad)
    } else {
      PL0304
    }
    
    if (input$pos != "All") {
      data2324 <- data2324 %>% filter(Pos == input$pos)
      data0304 <- data0304 %>% filter(Pos == input$pos)
    }
    
    bind_rows(
      data2324 %>% mutate(Season = "2023-24"),
      data0304 %>% mutate(Season = "2003-04")
    )
  })
  #this plot creates scatterplots of the games played and the selected matches played
  output$player_plot <- renderPlotly({
    data <- filtered_data()
    plot_ly(data, 
            x = ~MP, 
            y = ~get(input$metric), 
            color = ~Season, 
            text = ~paste("Player:", Player, "<br>Squad:", Squad, "<br>Pos:", Pos),
            type = 'scatter', 
            mode = 'markers') %>%
      layout(
        title = paste(input$metric, "vs Matches Played"),
        xaxis = list(title = "Matches Played"),
        yaxis = list(title = input$metric),
        legend = list(title = list(text = "Season"))
      )
  })
}
rsconnect::setAccountInfo(name='daraghbrady',
                          token='8014620E5A0E7A5541FB4FC321B635E8',
                          secret='F2OhgT8AuM8dbiLAc5q+wcsThWhsaEC8iGCka1MB')
#this runs the shinyApp
shinyApp(ui = ui, server = server)