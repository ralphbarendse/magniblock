validate_blockchain <- function(chain) {
  for (i in 2:length(chain)) {
    current_block <- chain[[i]]
    previous_block <- chain[[i - 1]]
    
    # Check index
    if (current_block$index != previous_block$index + 1) {
      return(FALSE)
    }
    
    # Check previous hash
    if (current_block$previous_hash != previous_block$hash) {
      return(FALSE)
    }
    
    # Check hash
    recomputed_hash <- digest(paste0(
      current_block$index,
      current_block$timestamp,
      current_block$data,
      current_block$previous_hash
    ), algo="sha256")
    
    if (recomputed_hash != current_block$hash) {
      return(FALSE)
    }
  }
  
  return(TRUE)
}
