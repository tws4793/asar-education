FROM rocker/shiny

WORKDIR /srv/shiny-server/

RUN apt-get update && apt-get upgrade
RUN chmod o+w /usr/local/lib/R/site-library

COPY requirements.txt /srv/shiny-server/
COPY install.sh /srv/shiny-server/

RUN bash install.sh

# RUN R -e 'file = "packages.txt" \ 
#     conn = file(file, open = "r") \ 
#     lines = readLines(conn) \ 
#     for i in 1:length(lines) install.packages(lines[i], dependencies = TRUE, repos = "http://cran.rstudio.com")'

# COPY install.R /srv/shiny-server/
# RUN ls -la /srv/shiny-server/
# RUN Rscript /srv/shiny-server/install.R

CMD [ "/usr/bin/shiny-server.sh" ]