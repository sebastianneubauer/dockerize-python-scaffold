FROM python:3.7.4-buster

RUN pip install virtualenv

# Set up the current timezone, s.t. synchonization with external services is properly working
RUN echo "Europe/Berlin" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/`cat /etc/timezone` /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# register the user variables
ARG USER
ARG UID
ARG GID

# set the proper user. this is especially helpful for debugging. (the user isn't admin but you may use sudo)
ENV HOME /home/${USER}
RUN groupadd --gid ${GID} --non-unique ${USER}
RUN useradd --home-dir $HOME --create-home --shell /bin/bash --uid $UID $USER -g ${GID} && \
        adduser $USER sudo && \
        passwd -d $USER

RUN   mkdir -p $HOME/.cache/pip
RUN   chown -R $UID:$GID $HOME/.cache

USER $UID

WORKDIR $HOME

RUN virtualenv /tmp/venv

COPY requirements.txt /tmp/

RUN . /tmp/venv/bin/activate && pip install -r /tmp/requirements.txt
