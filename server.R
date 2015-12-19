library(ROCR)
data(ROCR.simple)
dr = as.data.frame(ROCR.simple)
s = dr$predictions + rnorm(200)*.1 - 200:1/2000
l = dr$labels
L = length(s)
P = sum(l==1)
N = sum(l==0)

tpr=tnr=rep(0,100)
for (i in 1:100) {
  cutoff=i/100
  sl=as.numeric(s>cutoff)
  c=sl==l
  tpr[i]=sum(c&(l==1))/P
  tnr[i]=sum(c&(l==0))/N
}

shinyServer(
  function(input, output) {
    output$newPlot=renderPlot({
      a=input$a
      b=1-a
      score=a*tpr+b*tnr
      plot(1:100/100,score,col='blue',xlab="cutoff",ylab="Weighted sum of TPR and NPR")
      co=input$co
      lines(c(co,co), c(0,2), col='red', lwd=3)
      text(.5,.65,paste("Score=",round(score[co*100],2)),col='blue')
      text(.5,.6,paste("cutoff=",co),col='red')
    })    
  }
)
 
