
#
# Trying out the TenK package
# Jasper Ginn
# 15/10/2016
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("TenK package example"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      HTML("<p>This demo shiny app retrieves business description sections for 10-K reports using the TenK R package. You can read more about the package <a target='_blank' href='https://github.com/JasperHG90/TenK/wiki'>here</a>.</p>"),
      uiOutput("selectCompany")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("BD")
    )
  )
))
