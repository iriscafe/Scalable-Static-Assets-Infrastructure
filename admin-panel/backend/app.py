from flask import Flask, request, send_from_directory, jsonify
from s3_client import upload_file
import os

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FRONTEND_DIR = os.path.join(BASE_DIR, "frontend")

@app.route("/")
def index():
    cloudfront_url = os.getenv("CLOUDFRONT_URL", "https://CDN_NOT_CONFIGURED")
    if cloudfront_url and not cloudfront_url.startswith("http"):
        cloudfront_url = f"https://{cloudfront_url}"  
    try:
        with open(os.path.join(FRONTEND_DIR, "index.html"), "r") as f:
            content = f.read()
            
        content = content.replace("{{ CLOUDFRONT_URL }}", cloudfront_url)
        return content
    except Exception as e:
        return f"Error loading frontend: {str(e)}", 500

@app.route("/upload", methods=["POST"])
def upload():
    bucket_name = os.getenv("S3_BUCKET_NAME", "bucket-static-assets-dev")
    uploaded_files = []
    errors = []
    
    # Processar múltiplos arquivos
    files = request.files.getlist("file")
    
    if not files or files[0].filename == "":
        return "Nenhum arquivo selecionado", 400
    
    for file in files:
        try:
            filename = file.filename
            s3_key = filename
            
            upload_file(file, bucket_name, s3_key)
            uploaded_files.append(filename)
        except Exception as e:
            errors.append(f"Erro ao fazer upload de {file.filename}: {str(e)}")
    
    if errors:
        return jsonify({
            "success": len(uploaded_files),
            "errors": errors,
            "uploaded": uploaded_files
        }), 207  # Multi-Status
    
    return jsonify({
        "success": True,
        "message": f"{len(uploaded_files)} arquivo(s) enviado(s) com sucesso!",
        "files": uploaded_files
    })

app.run(host="0.0.0.0", port=80)
