
from flask import Flask
app = Flask(__name__)

@app.route("/")
@app.route("/greet/")
def greet():
    return "Witaj\n"

@app.route("/greet/<username>") 
def greet_user(username): 
    return f"Witaj {username}\n"

if __name__ == "__main__": 
    app.run(host="0.0.0.0",
            port=1337)