library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output, session) {
  
  output$summary <- renderUI({
       
    ###########STARTING VARS
    gamedoors<-input$gamedoors
    #doors removed = all doors minus those remaining.
    #At least 1, but leaving at least 2 (1<=doorsremoved<=gamedoors-2) 
    doorsremoved<- input$gamedoors-input$doorsleft
    doorsremoved <- max(min(doorsremoved,gamedoors-2),1)
    updateSliderInput(session, "doorsleft", value = (gamedoors-doorsremoved))
    
    
    playtype <- input$playtype
    N <- input$rounds
    
    resultoutput <- character()
      doors<-1:gamedoors #create the doors 
      playcount <-0 
      switchcount <-0 #track switchgames
      staycount <-0 #track switchgames
      wincount <-0 #track total wins
      staywin <- 0 #track stay wins
      switchwin <- 0 #track switch wins
   
    
    
    
      for(i in 1:N)
      {
        
        #prize <- 3
        #guess1 <- 1
        prize <-sample(doors, 1) #select a prize-winning door at random
        guess1 <-sample(doors, 1) #select a contestant's first guess at random
        prize
        guess1
        
        ## Reveal a few of the  remaining doors, excluding the prize door and the guess door
        doorsforhost <-doors[-unique(c(prize,guess1))]
        #How many doors to remove? At most gamedoors-2?? the guess, the truth
        doorsforhost
        
        #Take as many doors as needed,  provided we leave two.
        if (doorsremoved >= length(doorsforhost)) {
          doorsopened <- doorsforhost } 
        
        #otherwise take away the # of doors needed
        else {
          doorsopened <- sample(doorsforhost,doorsremoved)
        }
        remainingdoors <- doors[! doors %in% doorsopened]
        
        
        ## Stay with your initial guess or switch
        if(playtype=='random') ifelse(sample(1:2,1)==1,strat<-'stay',strat<-'switch') else (strat<-playtype)
        #logic to work around sampling length issue
        #    if(strat=='switch') ifelse(length(remainingdoors) <=2,guess2<-remainingdoors[-(guess1)],guess2<-sample(remainingdoors[-c(guess1)],1) )
        if(strat=='switch') ifelse(length(remainingdoors) <=2,guess2<-remainingdoors[! remainingdoors %in% guess1],guess2<-sample(remainingdoors[-c(guess1)],1) )
        
        if(strat=='stay') guess2<-guess1
        
        
        ##ROUND RESULTS
        ## Count up times played  
        playcount <- playcount + 1
        if(strat=='switch') switchcount <- switchcount + 1
        if(strat=='stay') staycount <- staycount + 1
        
        ##Count up wins
        if(guess2==prize)   {
          wincount<-wincount+1
          if(strat=='switch') switchwin <-switchwin +1
          if(strat=='stay') staywin <- staywin + 1
          outcome<-'You <b>win!</b> Congratulations!'
        } else {
          outcome<-'You <b>lose.</b> Better luck next time.' }
        
        if(input$print_games) {
       
          str0 <- paste('<b>Game Number ',i)
          str1 <- paste('</b>Doors you see: ',paste(doors, collapse=" "))
          str2 <- paste('You guess: Door',guess1)
          str3 <- paste('Host opens ',doorsremoved,'door(s):',paste(doorsopened,collapse=" "))
          str4 <- paste('Leaving you to choose from door(s): ',paste(remainingdoors,collapse=" "))
          str5 <- paste0('You decide to <i>',strat,'</i>.')
          str6 <- paste('Final Guess: Door',guess2)
          str7 <- paste('And the winner is door ',prize,'!',sep='')
          str8 <- paste(outcome,'<p><br />')
          
          #paste(str1,str2,str3,str4,str5, sep = '<br/>')
          result <- paste(str0,str1,str2,str3,str4,str5,str6,str7,str8, sep = '<br/>')
          resultoutput <- c(resultoutput, result)
          #print(paste(str0,str1,str2,str3,str4,str5,str6,str7,str8, sep = '<br/>'))
          
        }      }
      summ1 <- ifelse(playtype!='stay',paste0('<b>Switch games: <i>',round(switchwin/switchcount*100,1),'%</i> win rate</b>. ',switchcount,' switch games, with ', switchwin,' wins.'),paste0('<b>Switch games: <i>None</i></b>'))
      summ2 <- ifelse(playtype!='switch',paste0('<b>Stay games: <i>',round(staywin/staycount*100,1),'%</i> win rate.</b> ',staycount,' stays, with ', staywin,' wins.'),paste0('<b>Stay games: <i>None</i></b>'))
      summ3 <- paste('<br /><b>Gameplay:</b> First you picked your favorite out of',length(doors),'doors. Then the host opened', doorsremoved,'of them, leaving',length(remainingdoors),'doors for you to decide whether to switch or stay.<br />')
      summ4 <- paste0('<b>Your Score:</b> Using a <b><i>',playtype,'</b></i> guessing strategy, you won <b>',round(wincount/N*100,1),'% of the time.</b>')
      summ5 <- paste0('You won ',wincount,' out of ', playcount,' times.</h4>')
    summ <- paste(summ1,summ2,summ3,summ4,summ5, sep='<br />')

      HTML(paste('<h3>Your Results</h3><h4>',summ,if(input$print_games)'<h3>Detailed Gameplay Results</h3>',paste(resultoutput, collapse=" ")))
    
    ###########END
    })
})
