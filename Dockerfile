FROM python:3.7
MAINTAINER Mani <maninagaraj@gmail.com>

# Install build utilities
RUN apt-get update && \
    apt-get install -y protobuf-compiler python3-pil python3-lxml python3-pip python3-dev git && \
    apt-get -y upgrade

#Install Sentiment anlysis dependencies
RUN python3 -m pip install Flask==1.1.1 WTForms==2.2.1 Flask_WTF==0.14.2 Werkzeug==0.16.0 tensorflow==2.2.0

RUN pip3 install pillow
# Install Sentiment-Analysis API library
RUN cd /opt && \
    git clone https://github.com/tensorflow/models && \
    cd models/research && \
    protoc object_detection/protos/*.proto --python_out=.
RUN cd $HOME && \
    git clone https://github.com/dataninja01/Sentiment-Analysis-ML-Flask-App && \
    cp -a Sentiment-Analysis-ML-Flask-App/opt/ && \
    chmod u+x /opt/app.py
    
RUN python3 /opt/app.py
# expose ports
EXPOSE 8000

#Command
CMD ["python3", "/opt/Sentiment-Analysis-ML-Flask-App/app.py", "serve"]
