FROM rocker/shiny

# Guided by Shiny tutorials and https://github.com/flaviobarros/shiny-wordcloud/blob/master/Dockerfile


MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN \
apt-get update && \
apt-get -y dist-upgrade && \
apt-get install -y apt-utils

RUN \
# apt-get install -y r-api-3.5 && \
apt-get install -y software-properties-common && \
apt-get install -y libssl-dev  && \
apt-get install -y libxml2-dev && \
apt-get install -y lib32z1-dev && \
apt-get install -y libblas-dev && \
apt-get install -y liblapack-dev && \
apt-get install -y libprotobuf-dev && \
apt-get install -y protobuf-compiler && \
apt-get install -y php libapache2-mod-php php-cli && \
apt-get install -y git-core && \
apt-get install -y curl && \
apt-get install -y wget && \
apt-get install -y libmagick++-dev libmagickcore-dev libmagickwand-dev

RUN apt-get install -y libgdal-dev

# git lfs, from https://github.com/git-lfs/git-lfs/wiki/Installation and debugging the libssh2-1-dev install first.
RUN apt install -y libssh-4 libssh-dev libssh2-1 libssh2-1-dev

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*

RUN apt-get install -y libssh2-1-dev

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

# RUN Rscript -e "install.packages(rownames(installed.packages()))"

RUN Rscript -e "update.packages(ask=FALSE)"

RUN Rscript -e "install.packages('devtools')"

# RUN Rscript -e "install.packages('igraph', type='source')"

# RUN Rscript -e "install.packages('ade4', type='source')"

RUN Rscript -e "install.packages('shinycssloaders')"

RUN Rscript -e "install.packages('strap')"
RUN Rscript -e "install.packages('jsonlite')"

RUN apt-get update

RUN Rscript -e "install.packages('stringr')"

RUN Rscript -e "remotes::install_github('LunaSare/gplatesr')"

RUN Rscript -e "remotes::install_github('bomeara/paleotree', ref='developmentBranch')"

RUN Rscript -e "remotes::install_github('jwiggi18/HistoryOfEarth')"


# following https://github.com/openanalytics/shinyproxy-demo

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "HistoryOfEarth::runSite()"]
