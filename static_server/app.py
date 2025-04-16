from flask import Flask, send_from_directory
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins":"http://localhost:8080"}})
STATIC_DIR = os.path.abspath(os.environ.get("STATIC_DIR", "staticfiles"))

@app.route("/", defaults={"path": "index.html"})
@app.route("/<path:path>")
def serve_static(path):
    return send_from_directory(STATIC_DIR, path)

@app.errorhandler(404)
def not_found(e):
    return "File not found", 404
