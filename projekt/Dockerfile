# Remember to port forward 80:8080 when creating the container
FROM ubuntu 
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
RUN apt update; apt dist-upgrade -y
RUN apt install -y apache2 python3 git nano nmap iproute2 python3-pip
RUN pip3 install Flask 
RUN pip3 install python-kasa --pre
RUN git clone https://github.com/Aritj/linux-project.git /docker_github/
WORKDIR "/docker_github/projekt/python"
CMD [ "python3", "app.py" ]
