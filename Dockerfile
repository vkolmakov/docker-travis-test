FROM node:alpine AS builder
# everything below will be related to the `builder` section
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# the output of the `builder` section will be the
# /app/build folder which we will need to copy over during
# our run phase

FROM nginx
# notice no AS or any other special syntax - the last FROM is used as the run
# phase

# note that we specify what phase to copy from
# and that we copy into the directory where nginx
# expects the static files to be (refer to nginx
# image docs)
COPY --from=builder /app/build /usr/share/nginx/html

# note that we have no RUN here, the default command
# will be good enough for us
