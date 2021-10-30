import time

from flask import Flask

app = Flask(__name__)


# default route path
@app.route("/")
def hello_world():
    return "Hello, Docker!"


# route 2
@app.route("/test")
def hello_test():
    return "Hello, test!"


@app.route("/healthz/live")
def liveness():
    return "OK"


@app.route("/healthz/ready")
def readiness():
    time.sleep(1)
    return "OK"
