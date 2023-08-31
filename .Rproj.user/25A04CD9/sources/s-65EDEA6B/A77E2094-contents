# Source the library-loading script
source("libraries.R")

# Source Additional R Scripts
source("genesis.R")
source("validation_logic.R")

# Source the UI definition
source("gui.R")

server <- function(input, output, session) {
  
  output$bitcoinAddress <- renderText({
    "1BitcoinEaterAddressDontSendf59kuE" # Replace with your real Bitcoin address
  })
  
  observeEvent(input$donateClicked, {
    qrcode::qrcode_gen(output$bitcoinAddress, filename = "bitcoin_qr.png")
    showModal(modalDialog(
      title = "Donate Bitcoin",
      "Your contributions keep us going! Please send Bitcoin to the following address:",
      verbatimTextOutput("bitcoinAddress"),
      tags$img(src = "bitcoin_qr.png")  # Include QR code image
    ))
  })
  
  blockchain <- reactiveVal(initial_blockchain)
  
  
  # Initialize transaction pool as a reactiveVal
  transaction_pool <- reactiveVal(list())
  
  # Create a new block
  create_block <- function(index, timestamp, data, previous_hash, transactions) {
    block <- list(
      index = index,
      timestamp = timestamp,
      data = data,
      previous_hash = previous_hash,
      transactions = transactions
    )
    block$hash <- digest(paste0(index, timestamp, data, previous_hash), algo="sha256")
    return(block)
  }
  
  observeEvent(input$startButton, {
    hide("startPage")
    hide("infoPage")
    show("mainContent")
  })
  
  observeEvent(input$infoButton, {
    hide("startPage")
    hide("mainContent")
    show("infoPage")
  })
  

  # Add a transaction to the transaction pool
  add_transaction <- function(sender, receiver, amount) {
    transaction <- list(
      sender = sender,
      receiver = receiver,
      amount = amount
    )
    current_pool <- transaction_pool()
    transaction_pool(c(current_pool, list(transaction)))
  }
  
  observeEvent(input$add_transaction, {
    add_transaction(input$sender, input$receiver, input$amount)
  })
  
  observeEvent(input$add_test_transaction, {
    test_transaction <- list(sender = "Alice", receiver = "Bob", amount = 50)
    add_transaction(test_transaction$sender, test_transaction$receiver, test_transaction$amount)
  })
  
  # Add a block to the blockchain
  add_block <- function(data) {
    last_block <- tail(blockchain(), 1)[[1]]
    new_block <- create_block(
      last_block$index + 1,
      Sys.time(),
      data,
      last_block$hash,
      transaction_pool()  # Use the transaction pool here
    )
    
    
    blockchain(c(blockchain(), list(new_block)))
    transaction_pool(list())  # Clear the transaction pool
  }
  
  
  # Add new block
  observeEvent(input$add_block, {
    add_block(input$data)
  })
  
  # Display blockchain as an interactive table
  output$interactive_blockchain_table <- DT::renderDataTable({
    block_data <- do.call(rbind, lapply(blockchain(), function(x) {
      data.frame(
        index = x$index,
        timestamp = x$timestamp,
        data = x$data,
        previous_hash = x$previous_hash,
        hash = x$hash,
        total_transactions = length(x$transactions),
        stringsAsFactors = FALSE
      )
    }))
    return(block_data)
  })
  
  
  # Blockchain explorer: Show details of the selected block as one HTML table
  output$blockchain_explorer <- renderUI({
    selected_row <- input$interactive_blockchain_table_rows_selected
    if (length(selected_row) == 0) return(NULL)
    
    selected_block <- blockchain()[[selected_row]]
    
    transactions <- selected_block$transactions
    if (length(transactions) == 0) return("No transactions in this block.")
    
    transaction_df <- do.call(rbind, lapply(transactions, function(x) data.frame(t(unlist(x)))))
    names(transaction_df) <- c("Sender", "Receiver", "Amount")
    
    renderTable(transaction_df, rownames=FALSE)
  })
  
  # Display introduction and guide text
  output$intro_text <- renderText({
    "This is an educational tool to help you understand the basics of blockchain technology."
  })
  
  output$guide_text <- renderText({
    paste(
      "1. Enter some data and click 'Add Block' to add a block to the chain.",
      "2. Click 'Validate Blockchain' to validate the entire chain.",
      sep = "<br/>"
    )
  })
  
  # Display current transaction pool as a table
  output$transaction_pool <- renderTable({
    pool_data <- transaction_pool()
    if (length(pool_data) == 0) return("No transactions in the pool.")
    
    transaction_pool_df <- do.call(rbind, lapply(pool_data, function(x) data.frame(t(unlist(x)))))
    names(transaction_pool_df) <- c("Sender", "Receiver", "Amount")
    
    return(transaction_pool_df)
  }, rownames = FALSE)
  
  # Read the essay from the text file
  blockchain_essay_content <- reactive({
    readChar("blockchain_essay.txt", file.info("blockchain_essay.txt")$size)
  })
  
  output$blockchain_essay <- renderUI({
    HTML(markdown::markdownToHTML(text = blockchain_essay_content(), fragment.only = TRUE))
  })
  
  observe({
    # Generate the nodes (blocks)
    nodes <- data.frame(name = sapply(blockchain(), function(x) x$hash))
    
    # Generate the links between nodes
    links <- data.frame(source = 0:(nrow(nodes) - 2), 
                        target = 1:(nrow(nodes) - 1))
    
    # Create the network object
    network <- list(nodes = nodes, links = links)
    
    output$network <- renderForceNetwork({
      forceNetwork(Links = network$links, Nodes = network$nodes, 
                   Source = "source", Target = "target",
                   NodeID = "name", Group = "name", 
                   opacity = 0.9,
                   zoom = TRUE, 
                   linkWidth = JS("function(d) { return Math.sqrt(d.value); }"),
                   linkDistance = 100,
                   charge = -400)
    })
  })
  
  observeEvent(input$run_simulation, {
    algorithm <- input$algorithm
    if (algorithm == "Proof of Work") {
      # Run Proof of Work simulation and update consensus_plot and consensus_table
    } else if (algorithm == "Proof of Stake") {
      # Run Proof of Stake simulation and update consensus_plot and consensus_table
    }
  })
  


}




shinyApp(ui, server)
