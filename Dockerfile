# "Dockerfile" for use by OCI compatible container frameworks (podman)
FROM python:3.12-slim

WORKDIR /opt

RUN apt-get update && apt-get install -y build-essential git

RUN git clone https://github.com/ResearchIT/cell_counter.git .

RUN apt-get install -y < packages.txt

RUN pip3 install -r requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
