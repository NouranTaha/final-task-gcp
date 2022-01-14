FROM python:3.7.4-alpine3.10

RUN mkdir -p /home/app
ENV ENVIRONMENT=DEV
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_DB=0
COPY . /home/app
RUN pip install -r /home/app/requirements.txt

CMD [ "python", "/home/app/hello.py" ]





          
            
