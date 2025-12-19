from flask import Flask, request, send_from_directory
from s3_client import upload_file
import os

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FRONTEND_DIR = os.path.join(BASE_DIR, "frontend")

@app.route("/")
def index():
    return send_from_directory(FRONTEND_DIR, "index.html")

@app.route("/upload", methods=["POST"])
def upload():
    file = request.files["file"]
    upload_file(file, "meu-bucket", f"uploads/{file.filename}")
    return "Upload feito"

app.run(host="0.0.0.0", port=80)
