ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  
  # Footer
  tags$div(class = "footer",
           "Copyright © 2023 MagniBlock | ",
           tags$a(id = "donateLink", href = "#", "Donate Bitcoin"), # Your new donation link with an id
           " | ",
           tags$a(href = "https://github.com/ralphbarendse/magniblock", target = "_blank", "GitHub"),
           tags$img(src = "logo.png", alt = "MagniBlock Logo")
  ),
  
  # Include custom CSS
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "matrix_style.css"),
    tags$script(src = "matrix_rain.js")  # Include the external JavaScript file
  ),
  
  tags$script(HTML("
  function showBlockDetails(blockId) {
    var blockIndex = blockId.replace('block_', '');
    // Trigger some Shiny event to show details of the block
    // You can use Shiny.setInputValue or some other way to communicate back to the Shiny server
    Shiny.setInputValue('selected_block', blockIndex);
  }
")),
  
  tags$script(HTML(
    "
  $(document).on('click', '#donateLink', function(event) {
    Shiny.setInputValue('donateClicked', Math.random());
  });
  "
  )),
  
  tags$canvas(id = "matrixCanvas"),
  
  # Starting Page
  div(id = "startPage",
      div(class = "center-content",
          div(class = "ascii-art",
              HTML("<pre>
8888ba.88ba                             oo  888888ba  dP                   dP       
88  `8b  `8b                                88    `8b 88                   88       
88   88   88 .d8888b. .d8888b. 88d888b. dP a88aaaa8P' 88 .d8888b. .d8888b. 88  .dP  
88   88   88 88'  `88 88'  `88 88'  `88 88  88   `8b. 88 88'  `88 88'  `\"\" 88888\"   
88   88   88 88.  .88 88.  .88 88    88 88  88    .88 88 88.  .88 88.  ... 88  `8b. 
dP   dP   dP `88888P8 `8888P88 dP    dP dP  88888888P dP `88888P' `88888P' dP   `YP 
ooooooooooooooooooooooo~~~~.88~ooooooooooooooooooooooooooooooooooooooooooooooooooooo
                       d8888P                                                       
                 </pre>")
          ),
          div(class = "subtitle",
              "An Explorative Tool to Learn About Blockchain Technologies"
          ),
          fluidRow(
            column(6, actionButton("startButton", "Start")),
            column(6, actionButton("infoButton", "Blockchains?"))
          )
      )
  ),
  
  # Hidden Main Content
  hidden(
    div(id = "mainContent",
        titlePanel("MagniBlock"),
        forceNetworkOutput("network"),
        h4("You're In Control!"),
        p("Welcome to your own blockchain universe. Here, you are the architect. Manage your transactions, generate blocks, and maintain the integrity of your chain."),
        # Top Bar Panel
        tabsetPanel(
          # First Tab
          tabPanel("Transactions & Blocks",
                   fluidRow(
                     # Column 1: 33% of screen width
                     column(4,
                            h4("Educational Guide"),
                            p("This tab allows you to interact with a simulated blockchain. Follow the guide below:"),
                            
                            hr(),
                            
                            h4("Step 1: Add Transactions", id = "step1"),
                            p("Fill in the sender, receiver, and amount, then click 'Add Transaction'. This simulates a transaction between two parties."),
                            textInput("sender", "Sender:"),
                            bsTooltip(id = "sender", title = "This is the sender of the transaction.", placement = "right"),
                            textInput("receiver", "Receiver:"),
                            bsTooltip(id = "receiver", title = "This is the receiver of the transaction.", placement = "right"),
                            numericInput("amount", "Amount:", value = 0),
                            bsTooltip(id = "amount", title = "This is the amount to be transferred.", placement = "right"),
                            actionButton("add_transaction", "Add Transaction"),
                            bsTooltip(id = "add_transaction", title = "Click to add the transaction to the pool.", placement = "right"),
                          
                            hr(),
                            
                            h4("Step 2: Generate a Block", id = "step2"),
                            p("Type some block data and click 'Add Block'. This will package all pending transactions into a block and add it to the blockchain."),
                            textInput("data", "Block Data:"),
                            actionButton("add_block", "Add Block"),
                            
                            hr(),
                            
                            h4("Step 3: View Pool & Blockchain", id = "step3"),
                            p("Observe the transaction pool and blockchain table on the right. The transaction pool shows pending transactions, while the blockchain table shows added blocks."),
                            tableOutput("transaction_pool")
                     ),
                     
                     # Column 2: 67% of screen width
                     column(8,
                            h4("Blockchain Table"),
                            p("Below is the blockchain table, where each row represents a block in the blockchain. 
                              You can click on a row to view its transactions."),
                            DT::dataTableOutput("interactive_blockchain_table"),
                            h4("Block Contents"),
                            p("The table below shows the transactions in the block you've selected from the blockchain table."),
                            uiOutput("blockchain_explorer")
                     )
                   )
          ),
          
          # Second Tab
          tabPanel("Consensus",
                   fluidRow(h4("Content for Consensus tab will go here."),
                            column(4,
                                   h4("Introduction"),
                                   p("Consensus algorithms..."),
                                   selectInput("algorithm", "Choose a Consensus Algorithm:", choices = c("Proof of Work", "Proof of Stake")),
                                   actionButton("run_simulation", "Run Simulation")
                            ),
                            column(8,
                                   h4("Interactive Simulation"),
                                   plotOutput("consensus_plot"),
                                   tableOutput("consensus_table")
                            ))
          )
        )
    )
  ),
  # Hidden Info Page
  hidden(
    div(id = "infoPage",
        fluidRow(
          column(12,
                 htmlOutput("blockchain_essay")
          )
        )
    )
  )
)
