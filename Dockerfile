FROM python:3.9

WORKDIR /app
COPY . .

# Install requirements from a file

RUN pip install -r requirements.txt

# Expose the port

EXPOSE 8000

# Run gunicorn by binding port 8000. Calling will be done by wsgi.py file

CMD ["gunicorn", "--chdir", "PyEditorial", "--bind", ":8000", "PyEditorial.wsgi:application"]

