from flask import Flask
from flask_healthz import healthz

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix="/healthz")


# default route path
@app.route("/")
def hello_world():
    return "Hello, Docker!"


def liveness():
    pass


def readiness():
    pass
