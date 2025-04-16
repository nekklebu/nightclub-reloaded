#!/bin/bash
python manage.py migrate
gunicorn thenightclub.wsgi:application \
    --bind 0.0.0.0:${PORT:-8080} \
    --workers 3
