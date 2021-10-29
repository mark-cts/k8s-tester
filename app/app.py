from flask import Flask

app = Flask(__name__)


# default route
@app.route("/")
def hello_world():
    return "Hello, Docker!"
