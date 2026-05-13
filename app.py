##############################################################################
# app.py
# WHY THIS FILE EXISTS:
#   This is the entire web application. Flask is a lightweight Python web
#   framework that lets us create a running web server in under 10 lines.
#   The application is intentionally minimal — the goal of this project
#   is containerizing and automating it, not the app itself.
##############################################################################

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "<h1>Hello World</h1><p>Served from a Docker container.</p>"


@app.route("/health")
def health():
    return {"status": "healthy"}, 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)