FROM python:3.8-slim

# for flask web server
EXPOSE 1337

# set working directory
WORKDIR /app

# install required libraries
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy source code into working directory
COPY . /app

# This is the runtime command for the container
CMD ["/bin/bash"]