FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

WORKDIR /mechat

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN --mount=type=cache,target=/root/.cache \
    apt-get update -y \
    && apt-get install -y python3-pip \
    && pip3 install --upgrade pip

COPY . /mechat/

RUN --mount=type=cache,target=/root/.cache \
    pip3 install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113

COPY ./requirements.txt /mechat/

# Install requirements
RUN --mount=type=cache,target=/root/.cache \
    pip3 install -r requirements.txt 

EXPOSE 5050

# Run app
CMD [ "python3 app.py" ]