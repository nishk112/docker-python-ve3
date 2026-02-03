# ---------- STAGE 1: Builder ----------
FROM python:3.11-slim AS builder

WORKDIR /app

COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---------- STAGE 2: Runtime ----------
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /usr/local /usr/local
COPY backend backend
COPY frontend frontend

EXPOSE 8000

CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
