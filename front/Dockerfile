FROM node:7

LABEL maintainer="Marcelo G Silva <mgswolf@gmail.com>"
# RUN mkdir /app
WORKDIR /app
RUN mkdir -p /npm-packages \
    npm config set prefix '/npm-packages'
# ENTRYPOINT ["/docker-entrypoint.sh"]
# RUN npm install
# RUN touch package.json
RUN npm install -g @angular/cli
#     ng new projeto-teste
COPY ./app /app
# CMD node index.js
EXPOSE 8081
