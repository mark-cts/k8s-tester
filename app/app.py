import time

from flask import Flask

app = Flask(__name__)


# default route
@app.route("/")
def hello_world():
    return "Hello, Docker!"


# route test
@app.route("/tests")
def hello_test():
    return "Hello, test!"


# healthcheck live
@app.route("/healthz/live")
def liveness():
    return "OK"


@app.route("/healthz/ready")
def readiness():
    time.sleep(1)
    return "OK"
