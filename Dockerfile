FROM python:3.9

WORKDIR /app
COPY . .

# install requirements
RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["gunicorn", "--chdir", "PyEditorial", "--bind", ":8000", "PyEditorial.wsgi:application"]

