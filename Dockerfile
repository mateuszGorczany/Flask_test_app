FROM python:3.8-slim

# tool to kill a proces
RUN apt-get install procps

# set working directory
WORKDIR /app

# install required libraries
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy source code into working directory
COPY . /app

# tell which port will be exposed to dind docker
EXPOSE 1337

# This is the runtime command for the container
CMD ["/bin/bash"]