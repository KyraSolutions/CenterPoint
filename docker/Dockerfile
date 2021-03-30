FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

ARG PYTHON_VERSION=3.6
ARG WITH_TORCHVISION=1
ARG DEBIAN_FRONTEND="noninteractive"

# Add user
ARG USERNAME=user
ARG USER_ID
ARG GROUP_ID
RUN groupadd $USERNAME -g ${GROUP_ID}
RUN useradd -g $GROUP_ID -m $USERNAME 

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         git \
         curl \
         wget \
         nano \ 
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         libssl-dev \
         python3-opencv \
         software-properties-common && \
     rm -rf /var/lib/apt/lists/*

# Install cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.17.3/cmake-3.17.3.tar.gz
RUN tar -zxvf cmake-3.17.3.tar.gz
RUN cd cmake-3.17.3 && ./bootstrap
RUN cd cmake-3.17.3 && make 
RUN cd cmake-3.17.3 && make install 

# Install python and pytorch
RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda install -y python=$PYTHON_VERSION \
    && /opt/conda/bin/conda install -y -c pytorch magma-cuda100 \
    && /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

RUN conda install -c pytorch\
    pytorch==1.1.0 \
    torchvision==0.3.0 \
    cudatoolkit=10.0 \
    && conda clean -ya

RUN mkdir -p /Workspace/projects/CenterPoint
WORKDIR /Workspace/projects/CenterPoint

# Install nuscenes-devkit
RUN git clone https://github.com/tianweiy/nuscenes-devkit
ENV PYTHONPATH="${PYTHONPATH}:/Workspace/projects/CenterPoint/nuscenes-devkit/python-sdk"

# set the cuda path(change the path to your own cuda location) 
ENV PATH=/usr/local/cuda-10.0/bin:$PATH
ENV CUDA_PATH=/usr/local/cuda-10.0
ENV CUDA_HOME=/usr/local/cuda-10.0
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH

# Install APEX
# cd only applies for a single RUN statement, so the next one you'll have to cd again.
RUN git clone https://github.com/NVIDIA/apex
RUN cd apex && git checkout 5633f6
RUN cd apex && pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

# Install spconv
RUN apt-get update && apt-get install -y libboost-all-dev
RUN git clone https://github.com/traveller59/spconv.git --recursive
WORKDIR /Workspace/projects/CenterPoint/spconv
RUN git checkout 7342772
RUN python setup.py bdist_wheel
RUN cd ./dist && pip install *

# Set python path for loading of modules defined in folders with __init__.py
# ENV PYTHONPATH="${PYTHONPATH}:/Workspace/projects/CenterPoint"

# Install required files for the program
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# Clean image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* 

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh
CMD [ "/setup.sh" ]
USER $USERNAME

