shinyUI(pageWithSidebar(
  headerPanel("Find classification cutoff for maximizing weighted sum of True Positive Rate (TPR) and True Negative Rate (TNR)"),
  sidebarPanel(
    sliderInput('a', 'Enter weight for TPR (weight for TNR = 1-weight for TPR)', .5, min = 0, max = 1, step = .01),
    sliderInput('co', 'Enter desired cutoff', .5, min = 0, max = 1, step = .01)    
  ),
  mainPanel(
    plotOutput('newPlot')
  )
))
