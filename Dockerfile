FROM node:dubnium

#Update container
#RUN apt-get update && apt-get install -y \
#  curl

#Create app directory
ENV APP_DIR=/src/app

RUN mkdir -p $APP_DIR && cd $APP_DIR
WORKDIR $APP_DIR


# Install app dependencies
# a wilcard is used to ensure both package.json And pakcage-lock.json are copied

COPY package.json $APP_DIR/
#COPY yarn.lock $APP_DIR/
RUN yarn install

# Bundle app source
COPY . $APP_DIR/


## THE LIFE SAVER
#ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.0/wait /wait
#RUN chmod +x /wait

## Launch the wait tool and then your application
# Produccion
CMD ["yarn", "run", "start:prod"]
#Desarrollo
#CMD ["/wait", "yarn", "run", "start:dev"]
#CMD /wait && yarn run start:prodi
#CMD ["/bin/bash"]
