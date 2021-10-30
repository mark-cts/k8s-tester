import time

from flask import Flask

app = Flask(__name__)


# default route path
@app.route("/")
def hello_world():
    return "Hello, Docker!"


@app.route("/healthz/live")
def liveness():
    return "OK"


@app.route("/healthz/ready")
def readiness():
    time.sleep(1)
    return "OK"
