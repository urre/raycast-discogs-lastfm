#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Discogs Now Playing
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon icon.png
# @raycast.iconDark icon.png
#
# Documentation:
# @raycast.description Open Discogs and explore the currently playing album
# @raycast.author Urban Sanden
# @raycast.authorURL https://urre.me

# Read secrets from the .env file
source "./.env"

# Specify LastFM API and specify JSON as the format
URL="http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=${DISCOGS_USER}&api_key=${DISCOGS_API_KEY}&format=json"

# Query the LastFM API with cURL
result=`curl -s ${URL}`

# Get currently playing track using jq, Artist and Album name, flatten and remove whitespace
nowplaying=`echo ${result} | jq -r '[.recenttracks.track[0].artist["#text"], .recenttracks.track[0].album["#text"]] | flatten[]' | xargs`

# Now open Discogs in the browser
open "https://discogs.com/search?q=${nowplaying}"
