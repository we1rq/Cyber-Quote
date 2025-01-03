#!/bin/sh

# Define the cache file location
CACHE_FILE="$HOME/.quote_cache"

# Fetch a random quote from the Quotable API and update the cache
fetch_and_cache_quote() {
  API_URL="https://techquote.replit.app/quote"

  # Use curl to fetch data and jq to parse the JSON response
  response=$(curl -s $API_URL)

  # Exit early if the fetch fails
  if [[ $? -ne 0 ]]; then
    echo "Error: Unable to fetch a new quote. Using cached quote instead."
    return
  fi

  # Extract quote and author using jq
  quote=$(echo "$response" | jq -r '.content')
  author=$(echo "$response" | jq -r '.author')

  # Check if jq parsing was successful
  if [[ -z "$quote" || -z "$author" ]]; then
    echo "Error: Failed to parse the quote data."
    return
  fi

  # Write the new quote to the cache file
  echo "\"$quote\" - $author" > "$CACHE_FILE"
}

# Display the cached quote
display_cached_quote() {
  if [[ -f "$CACHE_FILE" ]]; then
    cat "$CACHE_FILE"
  else
    echo "Welcome! A quote will be ready next time."
  fi
}

# Display the cached quote instantly
display_cached_quote

# Fetch a new quote in the background for next time
fetch_and_cache_quote &
