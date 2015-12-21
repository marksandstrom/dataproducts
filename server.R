library(ROCR)
data(ROCR.simple)
dr = as.data.frame(ROCR.simple)
l = dr$labels
L = length(l)
s = dr$predictions + rnorm(L)*.1 - L:1/(L*10)
P = sum(l==1)
N = sum(l==0)

tpr = tnr = rep(0,100)
for (i in 1:100) {
  cutoff = i/100
  sl = as.numeric(s>cutoff)
  c = sl==l
  tpr[i] = sum(c&(l==1))/P
  tnr[i] = sum(c&(l==0))/N
}

shinyServer(
  function(input, output) {
    output$newPlot = renderPlot({
      a = input$a
      b = 1-a
      score = a*tpr+b*tnr
      plot(1:100/100,score,col='blue',xlab='cutoff',ylab=paste('SCORE:',a,'* TPR + ',b,'* TNR'))
      co = input$co
      lines(c(co,co), c(0,2), col='red', lwd=3)
      x = ifelse (co<.5,co+.1,co-.1)
      text(x,.65,paste("SCORE =",round(score[co*100],2)),col='blue')
      text(x,.6,paste("cutoff =",co),col='red')    })    
  }
)
 
