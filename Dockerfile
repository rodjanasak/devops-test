FROM node:current-alpine

ARG NODE_ENV="production"
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN if [ $NODE_ENV = "production" ]; \
	then npm install --production;  \
	else npm install; \
	fi

COPY . .

CMD [ "node", "index.js" ]
