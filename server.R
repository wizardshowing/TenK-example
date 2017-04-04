
#
# Trying out the TenK package
# Jasper Ginn
# 15/10/2016
#

library(shiny)
library(TenK)
data("filings10K2015")

shinyServer(function(input, output) {
  
  output$selectCompany <- renderUI({
    companies <- unique(filings10K2015$company_name)[sample(1:7774, 100)]
    selectInput("companies", "select a company:", choices=companies, selected=companies[1])
  })
  
  # Get data for company
  data <- reactive({
    comp <- input$companies ; if(is.null(comp)) return("Loading ...")
    c <- filings10K2015[filings10K2015$company_name == comp, ]
    # Get data
    TenK_process(c$ftp_url, retrieve="BD")
  })
  
  # Renderui
  output$BD <- renderUI({
    desc <- data()
    if(desc == "Loading ...") return(HTML("<p>Loading ... </p>"))
    HTML(paste0("<div>",
                "<p><strong>CIK: </strong>",desc$CIK ,"</p>",
                "<p><strong>ARC: </strong>",desc$ARC ,"</p>",
                "<p><strong>Index URL: </strong>",desc$index.url ,"</p>",
                "<p><strong>Company name: </strong>",desc$company_name ,"</p>",
                "<p><strong>Filing date: </strong>",desc$filing_date ,"</p>",
                "<p><strong>Date accepted: </strong>",desc$date_accepted ,"</p>",
                "<p><strong>Year (period): </strong>",desc$period_report ,"</p>",
                "<p><strong>URL (html): </strong>",desc$htm10kurl ,"</p>",
                "<p><strong>URL (FTP): </strong>",desc$FTPurl ,"</p>",
                "<p><strong>Business description: </strong>",desc$busdescription ,"</p>",
                "</div>"))
  })

})
