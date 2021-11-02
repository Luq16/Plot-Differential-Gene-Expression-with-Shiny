# ==== global.R START ===========================================================
library(shiny)
library(ggplot2)
library(DT)
library(shinythemes)
library(shinydashboard)
library(GeneBook)
gn <- read.csv('./inc/genes_names.csv')
g1 <- read.csv("./inc/g1.csv")
g2 <- read.csv("./inc/g2.csv")
g3 <- read.csv("./inc/g3.csv")
# ===================================================== global.R END ============

# ==== ui.R START ===============================================================

# ==== NEW UI using shinydashboard ==============================================
ui <- dashboardPage(
    dashboardHeader(
        title = "Gene Expression"
        ,
        # ==== Messages Menu =======================================
        dropdownMenu(
            type = "messages",
            messageItem(
                from = "The Other Side",
                message = "I'll leave that up to you.",
                href = "http://coursera.org/search?query=rhyme",
                icon = icon("user"),  # Try another icon: 'question', 'life-ring'
                time = "13:31")       # Try different date/time format '2020-4-29', '2020-4-29 01:45'
            
            # , 
            
        ),
        
        # ==== Tasks Menu ==========================================
        dropdownMenu(
            type = "tasks",
            badgeStatus = "success",
            
            taskItem(
                value = 92,
                color = "green",
                text = "Documentation")
            ,
            taskItem(
                value = 75,
                color = "yellow",
                text = "Sequencing")
            ,
            taskItem(
                value = 17,
                color = "aqua",
                text = "Project X"
            ),
            
            taskItem(
                value = 19,
                color = "red",
                text = "Known Interaction Network")
        ),
        
        # ==== Notifications menu ==================================
        dropdownMenu(
            type = "notifications",
            notificationItem(
                text = "5 new users today",
                icon = icon("users"),
                status = "info"
            ),
            
            notificationItem(
                text = "12 items delivered",
                icon = icon("truck"),
                status = "success"
            ),
            notificationItem(
                text = "Server load at 86%",
                icon = icon("exclamation-triangle"),
                status = "warning"
            )
        ),
        
        # ====  Message Menu =============
         dropdownMenuOutput("messageMenu")
    ) 
    ,
    
    dashboardSidebar(
        selectInput(
            inputId = "G_groups",
            label = "A- Choose Group to plot:",
            choices = c(
                "1- Genes down regulated in resistant while
                                   up regulated in susceptible " = "g1",
                "2- Genes down regulated in both resistant
                                   and susceptible" = "g2",
                "3- Genes up regulated in both resistant and
                                   susceptible " = "g3"
            )
        )
        ,
        
        selectInput(
            inputId = "My_dataset",
            label = "B- Choose Gene ID to show it's full name:",
            choices = levels(gn$GeneID)
        ),
        
        selectInput(
            inputId = "More_info",
            label = "C- Documentation:",
            choices = c(
                'Introduction',
                'Information',
                'Help',
                'References',
                'Table-1',
                'Table-2',
                'Table-3'
            ),
            selected = "Introduction"
        )
        
    ),
    
    dashboardBody(
        downloadButton(outputId = "downloadData",
                       label = "Download Data"),
        
        plotOutput(
            outputId = "myplot",
            width = "100%",
            height = "400px"
        ),
        
        verbatimTextOutput(outputId = "odataset"),
        
        uiOutput(outputId = "odataset_link"),
        
        uiOutput(outputId = "text1")
        
    )
)

# ===================================================== NEW UI END ==============
# ===================================================== ui.R END ================

# ==== server.R START ===========================================================
server <- function(input, output) {
    
}
# ===================================================== server.R END ============

# Run the application
shinyApp(ui = ui, server = server)
