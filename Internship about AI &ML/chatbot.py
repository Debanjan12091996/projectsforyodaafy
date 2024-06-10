# Chatbot Code Block
import random
import string
import warnings
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import warnings
warnings.filterwarnings('ignore')

import nltk
from nltk.stem import WordNetLemmatizer
nltk.download('popular', quiet=True)

# Read example content from chatbot.txt
with open('chatbot.txt', 'r', encoding='utf8', errors='ignore') as fin:
    raw = fin.read().lower()

# Tokenization
sent_tokens = nltk.sent_tokenize(raw)
word_tokens = nltk.word_tokenize(raw)

# Preprocessing
lemmer = WordNetLemmatizer()
def LemTokens(tokens):
    return [lemmer.lemmatize(token) for token in tokens]

remove_punct_dict = dict((ord(punct), None) for punct in string.punctuation)
def LemNormalize(text):
    return LemTokens(nltk.word_tokenize(text.lower().translate(remove_punct_dict)))

# Compute TF-IDF matrix for the entire corpus
TfidfVec = TfidfVectorizer(tokenizer=LemNormalize, stop_words='english')
tfidf = TfidfVec.fit_transform(sent_tokens)

# Keyword Matching
GREETING_INPUTS = ("hello", "hi", "greetings", "sup", "what's up", "hey",)
GREETING_RESPONSES = ["hi", "hey", "*nods*", "hi there", "hello", "I am glad! You are talking to me"]

def greeting(sentence):
    for word in sentence.split():
        if word.lower() in GREETING_INPUTS:
            return random.choice(GREETING_RESPONSES)

# Generating response
def response(user_response):
    robo_response = ''
    sent_tokens.append(user_response)
    vals = cosine_similarity(TfidfVec.transform([user_response]), tfidf)
    idx = vals.argsort()[0][-2]
    flat = vals.flatten()
    flat.sort()
    req_tfidf = flat[-2]
    if req_tfidf == 0:
        robo_response = "I am sorry! I don't understand you"
    else:
        robo_response = sent_tokens[idx]
    sent_tokens.remove(user_response)
    return robo_response

# Training Code Block
import nltk
import string

nltk.download('punkt')
nltk.download('stopwords')

example_text = """
Chatbots are conversational agents.
They are used to simulate conversations with users.
Chatbots can be used in customer service, as virtual assistants, and more.
Some popular chatbot platforms include Dialogflow, Microsoft Bot Framework, and IBM Watson.
Machine learning and natural language processing are key technologies behind chatbots.
Movies:
- "The Shawshank Redemption" is a highly acclaimed film directed by Frank Darabont.
- "The Godfather" is a classic crime film directed by Francis Ford Coppola.
- "Inception" is a mind-bending science fiction film directed by Christopher Nolan.
- "Pulp Fiction" is a cult classic directed by Quentin Tarantino.

Sports:
- Football is a popular sport played around the world. It's known for its excitement and passionate fans.
- Basketball is another widely followed sport, particularly in the United States and many other countries.
- Tennis is a racket sport that can be played individually against a single opponent or between two teams of two players each.
- Cricket is a bat-and-ball game played between two teams of eleven players on a field at the center of which is a 22-yard pitch.

Technology:
- Artificial Intelligence (AI) is the simulation of human intelligence processes by machines, especially computer systems.
- Blockchain is a decentralized, distributed ledger technology that records the provenance of a digital asset.
- Virtual Reality (VR) is a simulated experience that can be similar to or completely different from the real world.

Science:
- Astronomy is the study of celestial objects such as stars, planets, comets, and galaxies.
- Biology is the science of life and living organisms, including their structure, function, growth, evolution, distribution, and taxonomy.
"""
# Main loop
flag = True
print("ROBO: My name is Robo. I will answer your queries about Chatbots. If you want to exit, type Bye!")
while flag:
    user_response = input()
    user_response = user_response.lower()
    if user_response != 'bye':
        if user_response in ('thanks', 'thank you'):
            flag = False
            print("You are welcome..")
        else:
            if greeting(user_response) is not None:
                print(greeting(user_response))
            elif 'movie' in user_response:
                print("Here are some movies: 'The Shawshank Redemption', 'The Godfather', 'Inception', 'Pulp Fiction'.")
            elif 'the shawshank redemption' in user_response:
                print("'The Shawshank Redemption' is a highly acclaimed film directed by Frank Darabont.")
            elif 'the godfather' in user_response:
                print("'The Godfather' is a classic crime film directed by Francis Ford Coppola.")
            elif 'inception' in user_response:
                print("'Inception' is a mind-bending science fiction film directed by Christopher Nolan.")
            elif 'pulp fiction' in user_response:
                print("'Pulp Fiction' is a cult classic directed by Quentin Tarantino.")
            elif 'sports' in user_response:
                print("Here are some sports: ")
                print("- Basketball is another widely followed sport, particularly in the United States and many other countries.")
                print("- Football is a popular sport played around the world. It's known for its excitement and passionate fans.")
                print("- Tennis is a racket sport that can be played individually or between two teams of two players each.")
                print("- Cricket is a bat-and-ball game played between two teams of eleven players on a field.")
            elif 'technology' in user_response:
                print("Here are some technologies: ")
                print("- Artificial Intelligence (AI) is the simulation of human intelligence processes by machines, especially computer systems.")
                print("- Blockchain is a decentralized, distributed ledger technology that records the provenance of a digital asset.")
                print("- Virtual Reality (VR) is a simulated experience that can be similar to or completely different from the real world.")
            elif 'science' in user_response:
                print("Here are some branches of science: ")
                print("- Astronomy is the study of celestial objects such as stars, planets, comets, and galaxies.")
                print("- Biology is the science of life and living organisms, including their structure, function, growth, evolution, distribution, and taxonomy.")
                print("- Chemistry is the branch of science that deals with the composition, structure, properties, and reactions of matter.")
                print("- Physics is the natural science that studies matter, its motion and behavior through space and time, and the related entities of energy and force.")
            elif 'history' in user_response:
                print("Here are some historical events: ")
                print("- The Renaissance was a period in European history marking the transition from the Middle Ages to modernity.")
                print("- The Industrial Revolution was the transition to new manufacturing processes in Europe and the United States.")
                print("- World War II was a global war that lasted from 1939 to 1945, involving most of the world's nations.")
            else:
                print("I am sorry! I don't understand you")
    else:
        flag = False
        print("Bye! take care..")