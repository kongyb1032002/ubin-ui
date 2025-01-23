FROM node:12-alpine

# Thiết lập thư mục làm việc bên trong container
WORKDIR /usr/src/app

# Cài đặt các công cụ hệ thống cần thiết
RUN apk add --no-cache bash git

RUN npm install -g bower grunt
COPY package.json bower.json ./
RUN yarn && bower install --allow-root

COPY . .
RUN grunt build:ubin --env=corda
RUN npm install -g http-server
EXPOSE 7001
CMD ["http-server", "dist", "-p", "7001"]