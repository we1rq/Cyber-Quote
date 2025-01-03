#!/bin/sh

# Fetch a random quote from the Quotable API
fetch_quote() {
  API_URL="https://techquote.replit.app/quote"

  # Use curl to fetch data and jq to parse the JSON response
  response=$(curl -s $API_URL)

  if [[ $? -ne 0 ]]; then
    echo "Error: Unable to fetch the quote. Check your internet connection."
    exit 1
  fi

  # Extract quote and author using jq
  quote=$(echo "$response" | jq -r '.content')
  author=$(echo "$response" | jq -r '.author')

  # Check if jq parsing was successful
  if [[ -z "$quote" || -z "$author" ]]; then
    echo "Error: Failed to parse the quote data."
    exit 1
  fi

  echo "\"$quote\" - $author"
}

# Call the function
fetch_quote
