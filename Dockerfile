FROM python:3.7
MAINTAINER Mani <maninagaraj@gmail.com>

# Install build utilities
RUN apt-get update && \
    apt-get install -y protobuf-compiler python3-pil python3-lxml python3-pip python3-dev git && \
    apt-get -y upgrade

#Install Sentiment anlysis dependencies
RUN python3 -m pip install click==6.7 Flask==1.0.2 Flask-WTF==0.14.2 gunicorn==19.9.0 itsdangerous==0.24 Jinja2==2.10 MarkupSafe==1.0 vaderSentiment==3.2.1 six==1.12.0 Werkzeug==0.14.1 WTForms==2.2.1 nltk>=3.4.5 scikit-learn>=0.18 requests

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
    
RUN python3 /opt/Sentiment-Analysis-ML-Flask-App/app.py
# expose ports
EXPOSE 8000

#Command
CMD ["python3", "/opt/Sentiment-Analysis-ML-Flask-App/app.py", "serve"]
