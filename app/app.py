import time

from flask import Flask

app = Flask(__name__)


# default route
@app.route("/")
def hello_world():
    return "Hello, Docker!"


@app.route("/notif", methods=["POST"])
def hello_world():
    resp = request.get_json()
    return resp


# route test
@app.route("/test")
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
