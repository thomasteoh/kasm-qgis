# Use the ubuntu base image from kasmweb
FROM kasmweb/core-ubuntu-bionic:1.9.0 as base

# Run as root
USER root

# Set environment variables
ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install

# Set working directory
WORKDIR $HOME


# -----
# Labels
# -----

LABEL maintainer="Thomas Teoh <me@tteoh.com>"

# Install dependencies - to work with repository signing keys
RUN apt-get install -y gnupg software-properties-common

# Retrieve the QGIS signing key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 46B5721DBBD2996A

# Add the QGIS repo for the latest stable QGIS (3.14.x Pi).
RUN add-apt-repository "deb     https://qgis.org/ubuntu `lsb_release -c -s` main"

# Update repositories
RUN apt-get update

# Install QGIS
# Note: add ‘qgis-server’ to this line if you also want to install QGIS Server:
#   add `yes` to answer a prompt for disk usage.  Worth reading the docs on this simple tool:  `man yes`
RUN yes | apt-get install -y qgis qgis-plugin-grass

# Install other programs
# - firefox for accessing web gui for filesharing services, from which files can accessed from and saved to
# - git for accessing source controlled repositories with geospatial information
RUN apt-get install -y firefox git

# If test, check whether qgis has installed correctly
FROM base as test

# Run qgis --help to check whether QGIS was installed correctly
RUN qgis --help

# If production, complete the build of the kasm image
FROM base as production

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
