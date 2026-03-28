# ---------- Base Image ----------
FROM python:latest

# ---------- Environment ----------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ---------- Work Directory ----------
WORKDIR /app

# ---------- System Dependencies ----------
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Python Dependencies ----------
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# ---------- Copy Project ----------
COPY . .

# ---------- Collect Static ----------
RUN python manage.py collectstatic --noinput

# ---------- Expose Port ----------
EXPOSE 8000

# ---------- Start Server ----------
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]