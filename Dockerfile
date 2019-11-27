# Shiny server with some packages installed
FROM rocker/shiny
MAINTAINER JEFF ZHONG
RUN sudo apt-get update && apt-get install -y \
    libssl-dev \
    ## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
    googleAuthR \
    dplyr \
    lubridate \
    shiny \
    shinydashboard \
    remotes \
    && Rscript -e "remotes::install_github(c('jeffwzhong1994/R-shiny-web'))" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## assume shiny app is in build folder /shiny
COPY ./PK/ /srv/shiny-server/myapp/

