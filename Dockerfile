#Phase 1 -- build
FROM node:alpine

#next two linesneeded in VM for some reason
USER node
RUN mkdir /home/node/app


WORKDIR '/home/node/app'

COPY --chown=node:node package.json .

RUN npm install

COPY --chown=node:node . .

CMD ["npm","run","build"]


#Phase 2 -- run
FROM nginx

#copy build from first phase
COPY --from=0 /home/node/app/build /usr/share/nginx/html
