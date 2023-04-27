FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    nano \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt install -y python3.10 python3.10-dev python3-pip\
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY requirements.txt requirements.txt
# ADD deps/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /tmp/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl
ADD https://download.pytorch.org/whl/cu118/torch-2.0.0%2Bcu118-cp310-cp310-linux_x86_64.whl /tmp/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 \
    && python3.10 -m pip install -r requirements.txt 
RUN pip3 install numpy torch torchvision torchaudio /tmp/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl
COPY files/ .
RUN rm -rf /tmp/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl
CMD [ "bash" ]
# ENTRYPOINT ["python3.10"]
