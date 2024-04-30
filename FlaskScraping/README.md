# TextAnalysisTool README

## Setup

- Install Python 3, Flask, NLTK, TextBlob (if needed), matplotlib, and wordcloud.

## Running the Application

1. Clone the repo and navigate to the project directory.
2. Install dependencies: `pip install flask nltk matplotlib wordcloud`.
3. Download NLTK data by running `python3 -m nltk.downloader all`.
4. Run the Flask app: `python3 app.py`.
5. Visit `http://localhost:5000` in your browser.
6. Enter text data in the form and submit to see text analysis results.

## Features

- Performs sentiment analysis on input text data.
- Extracts key phrases and entities from the text.
- Displays sentiment, key phrases, entities, and a word cloud visualization of the most frequent words.
