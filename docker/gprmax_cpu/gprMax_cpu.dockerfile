FROM continuumio/miniconda3:4.12.0

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Recife

# Install the python development environment
ARG USE_PYTHON_3=True
ARG _PY_SUFFIX=${USE_PYTHON_3:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    ${PYTHON}-dev \
    ${PYTHON}-pip \
    git

RUN ${PIP} install --no-cache-dir --upgrade \
    pip \
    setuptools

RUN ln -s -f $(which ${PYTHON}) /usr/local/bin/python
RUN ${PYTHON} --version

LABEL maintainer="lucasomaggi@gmail.com"

# Installing basic dependencies to build gprMax
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  git

WORKDIR /app
# Copy the requirements.txt first to leverage the Docker cache
COPY requirements.txt .
RUN pip install -r requirements.txt

# We build gprMax from source because the simulation optimised for
# different architectures.
RUN git clone https://github.com/gprMax/gprMax.git
WORKDIR /app/gprMax
# We should fix this to a specific version as its the dev branch!
RUN git checkout devel
RUN python setup.py build
RUN python setup.py install

WORKDIR /app

# Copy app files last to prevent cache busting
COPY . .

CMD [ "model.in" ]
ENTRYPOINT [ "python", "-m", "gprMax"]
