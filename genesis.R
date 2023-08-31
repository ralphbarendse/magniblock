# Function to create a block
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

# List of names
names <- c("Andre", "Bob", "Diana", "Marc", "Ralph", "Stefan", "Jack", "Lisa")

# Function to create a random transaction
create_random_transaction <- function() {
  sender <- sample(names, 1)
  receiver <- sample(names[names != sender], 1)
  amount <- sample(1:100, 1)
  return(list(sender = sender, receiver = receiver, amount = amount))
}

# Initialize blockchain with the genesis block
genesis_block <- create_block(1, Sys.time(), "Genesis Block", "0", list())
initial_blockchain <- list(genesis_block)

# Generate 4 more blocks with 1-5 transactions each
for(i in 2:5) {
  num_transactions <- sample(1:5, 1)  # Randomly choose between 1 and 5 transactions
  transactions <- list()
  
  for(j in 1:num_transactions) {
    transactions <- c(transactions, list(create_random_transaction()))
  }
  
  last_block <- tail(initial_blockchain, 1)[[1]]
  new_block <- create_block(
    i,
    Sys.time(),
    paste("Block Data ", i),
    last_block$hash,
    transactions
  )
  
  initial_blockchain <- c(initial_blockchain, list(new_block))
}
