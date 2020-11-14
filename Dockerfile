FROM python:3.8.6

RUN mkdir /home/jenkins
RUN groupadd -g 984 jenkins
RUN useradd -r -u 984 -g jenkins -d /home/jenkins jenkins
RUN chown jenkins:jenkins /home/jenkins
USER jenkins
WORKDIR /home/jenkins

CMD ["/bin/bash"]