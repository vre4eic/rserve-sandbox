# our R base image
FROM r-base

# install packages
# these are ones I like
RUN echo 'install.packages(c("ggplot2"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

RUN apt-get update && apt-get install -y \
	libcurl4-openssl-dev \
	libssl-dev \
	libcairo-dev

RUN echo 'install.packages("Rserve",,"http://rforge.net/",type="source")' > /tmp/packages2.R \
    && Rscript /tmp/packages2.R

# create an R user
ENV HOME /home/ruser
RUN useradd --create-home --home-dir $HOME ruser \
    && chown -R ruser:ruser $HOME

WORKDIR $HOME
USER ruser

# set the command
ADD Rserv.conf Rserv.conf

EXPOSE 6311
CMD /usr/bin/R CMD Rserve --no-save --RS-conf Rserv.conf
