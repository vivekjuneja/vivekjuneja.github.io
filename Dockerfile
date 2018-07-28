FROM jekyll/jekyll:latest

RUN gem install jekyll-gist jekyll-last-modified-at jekyll-paginate && mkdir /workdir

WORKDIR /workdir
ADD . /workdir 

ENTRYPOINT ["jekyll", "serve"]

