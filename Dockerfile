FROM python:3.8-slim

# tool to kill a proces
RUN apt-get update
RUN apt-get --yes install procps

# set working directory
WORKDIR /app

# copy source code into working directory
COPY . /app

# install required libraries
RUN pip install -r requirements.txt

# tell which port will be exposed to dind docker
EXPOSE 1337

CMD ["python", "app.py"]
