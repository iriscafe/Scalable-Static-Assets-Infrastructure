FROM python:3.14

WORKDIR /app

COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend ./backend
COPY frontend ./frontend

EXPOSE 80

ENV PYTHONPATH=/app

CMD ["python", "backend/app.py"]

