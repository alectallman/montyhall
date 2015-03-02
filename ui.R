library(shiny)

# Define UI for application that plots random distributions 
#shinyUI(pageWithSidebar(
shinyUI(fluidPage(
    tags$head(includeScript("googleanalytics.js")),  
  
  # Application title
  headerPanel("Monty Hall Simulator!"),
    h3("Get your hands dirty with the 'Monty Hall Problem.'"),
    div("The Monty Hall Problem is fiendishly difficult to understand. The answer is counterintuitive, and there's just no simple way to explain it."),
    div("Instead, get a feel for it yourself using the controls below."),
    br(),
    
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    #div("The Monty Hall Problem is fiendishly difficult to understand. It's counterintuitive, with no simple way to explain it. Here we allow you to get a feel for the Monty Hall Problem yourself - see how the game plays out, and start to see why so many people have been fooled. Run thousands of game results with a single click!"),
    h4("Play more rounds"),
    sliderInput("rounds", 
                "Number of rounds to play:", 
                min = 1,
                max = 10000, 
                value = 100),
    p("~~"),

    h4("Change the Game"),
    p("Modify the rules to improve your odds."),
    
    sliderInput("gamedoors", 
                "Number of doors in the game:", 
                min = 3,
                max = 20, 
                value = 3),
    
    sliderInput("doorsremoved", 
                "How many doors will the host open each time:", 
                min = 1,
                max = 18, 
                value = 1),
    p("(Monty will always leave 2 doors for the final guess.)"),
    p("~~"),
    selectInput('playtype','Your Guessing Strategy',c('random','stay','switch')),
    checkboxInput('print_games', 'Print Detailed Results', value = TRUE),
    br(),
    br(),
    p(a(href="https://twitter.com/intent/tweet?text=Got%20a%20problem%20with%20the%20Monty%20Hall%20Problem%3f%20No%20longer%3a%20&url=http%3a%2f%2figotmontyhallproblems.us",img(src = "https://g.twimg.com/twitter-bird-16x16.png", width = "16px", height = "16px"),"Tweet this!")),
    br(),
    p("created by Alec Tallman in R Shiny ",br(),a(href="http://linkedin.com/in/alectallman",img(src = "https://static.licdn.com/scds/common/u/img/webpromo/btn_in_20x15.png", width = "20px", height = "15px"),"View Alec Tallman's Profile"))
    
    ),
  
  
  # Show a plot of the generated distribution
  mainPanel(
    htmlOutput("summary")
  )
))
