FROM python:3.11-slim

WORKDIR /app

COPY static_server/ /app/
COPY static/ /app/staticfiles/

RUN ls -la /app/staticfiles

ENV PORT=9090
ENV FLASK_APP=app.py

# Install Flask
RUN pip install --upgrade pip && pip install -r requirements.txt
RUN apt-get update && apt-get install -y bash

CMD ["bash", "-c", "python -m flask run --host=0.0.0.0 --port=${PORT:-9090} --no-debugger --no-reload"]
