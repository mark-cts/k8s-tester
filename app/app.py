import sys
import time

from flask import Flask, request

app = Flask(__name__)


# default route
@app.route("/")
def hello_world():
    return "Hello, world!!!!"


# notification route
@app.route("/notif", methods=["POST"])
def hello_notif():
    resp = request.get_json()
    print(resp, file=sys.stderr)
    return resp


# healthcheck live
@app.route("/healthz/live")
def liveness():
    return "OK"


@app.route("/healthz/ready")
def readiness():
    time.sleep(3)
    return "OK"
