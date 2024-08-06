# #!/bin/bash
# DOCUMENT_ID="1z_fD3UKgWQyOTZIBbYSaQ-hz4AzUrLC1"
# FINAL_DOWNLOADED_FILENAME="testset.zip"

# curl -c /tmp/cookies "https://drive.google.com/uc?export=download&id=$DOCUMENT_ID" > /tmp/intermezzo.html
# curl -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/intermezzo.html | grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" > $FINAL_DOWNLOADED_FILENAME
# unzip testset.zip
# rm testset.zip


#!/bin/bash

# Define variables
DOCUMENT_ID="1z_fD3UKgWQyOTZIBbYSaQ-hz4AzUrLC1"
FINAL_DOWNLOADED_FILENAME="testset.zip"
TEMP_DIR=$(mktemp -d)

# Fetch the initial page and extract the download link
curl -c "$TEMP_DIR/cookies" -s -L "https://drive.google.com/uc?export=download&id=$DOCUMENT_ID" > "$TEMP_DIR/intermezzo.html"
CONFIRMATION_CODE=$(grep -Po '(?<=confirm=)[^&]+' "$TEMP_DIR/intermezzo.html")
DOWNLOAD_LINK="https://drive.google.com/uc?export=download&confirm=$CONFIRMATION_CODE&id=$DOCUMENT_ID"

# Download the file
curl -Lb "$TEMP_DIR/cookies" "$DOWNLOAD_LINK" -o "$FINAL_DOWNLOADED_FILENAME"

# Clean up temporary files
rm -r "$TEMP_DIR"

# Verify if the downloaded file is a valid zip archive
if file "$FINAL_DOWNLOADED_FILENAME" | grep -q "Zip archive data"; then
    echo "File downloaded successfully and is a valid zip archive."
    unzip "$FINAL_DOWNLOADED_FILENAME"
    rm "$FINAL_DOWNLOADED_FILENAME"
else
    echo "Downloaded file is not a valid zip archive. Please check the Google Drive link or try downloading manually."
    rm "$FINAL_DOWNLOADED_FILENAME"
    exit 1
fi
