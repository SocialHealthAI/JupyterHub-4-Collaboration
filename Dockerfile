#  Debian based miniconda foundation.  
#  See https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile
#  and https://hub.docker.com/r/continuumio/miniconda3

FROM continuumio/miniconda3:latest

Label Jeff Gunderson <jeff@bidiscover.com>

# Install all OS dependencies for notebook server

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    git \
    texlive \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-xetex \
    unzip \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# Install Conda, JupyterHUb and JupyterLab
# Node.js is required to rebuild JupyterLab (which might be necessary depending on your collection of extensions)
# With JupyterLab 3+.0+ you should not need to install extensions with jupyter labextension install; instead 
# installation with pip install or conda install is now the recommended. 

RUN conda update -y conda
RUN conda install -c conda-forge jupyter_nbextensions_configurator \
    jupyterhub \
    nodejs \
    jupyterlab \
#   ipympl - Jupyterlab matplotlib widget
    ipympl \
    numpy \
    matplotlib \
    pandas \
    r-essentials \
#   rise - Reveal.js - Jupyter/IPython Slideshow Extension
    rise \
    scipy \
    sympy \
    seaborn \
    && conda clean -ay

# Install JupyterLab extensions

RUN conda install -c conda-forge jupyterlab \
    jupyterlab-git \
    jupytext \
    jupyterlab-drawio 

# Add our configuration file and create new user script.  By default, the Hub looks for the
# configuration file in the current directory.  You can change the password using:
#   docker exec -it joertestcontainer bash
#   passwd admin
# To add new users, File > Hub Control Panel > Admin > Add User

COPY jupyterhub_config.py /
COPY create-new-user.py /

# Create admin user with password "default"
# Set all user's PATH to root's PATH using .bash_profile
RUN useradd admin \
    && echo admin:default | chpasswd \
    && mkdir /home/admin \
    && chown admin:admin /home/admin \
    && echo """export PATH=\"\$PATH:/opt/conda/bin\"""" > /home/admin/.bash_profile \
    && chmod u+x /home/admin/.bash_profile

RUN echo "PATH="${PATH}":/opt/conda/bin" >> /etc/environment

# Setup application
EXPOSE 8000
CMD ["jupyterhub", "--ip='*'", "--port=8000", "--no-browser", "--allow-root"]

