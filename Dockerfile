FROM node:12-buster as builder
WORKDIR /app/
RUN git clone https://github.com/crowi/crowi.git
WORKDIR /app/crowi/
RUN git checkout 1c9324a4b1649f0534a75118c375f38cfdbc002d
RUN npm install
RUN npm run build
# files should not be public
RUN rm /app/crowi/public/nginx.conf
RUN rm /app/crowi/public/nginx-mime.types

FROM node:12-buster-slim
LABEL org.opencontainers.image.source https://github.com/ebiiim/crowi-docker
COPY --from=builder /app/crowi/ /app/crowi/
COPY run.sh /app/crowi/
WORKDIR /app/crowi/
ENTRYPOINT [ "./run.sh", "serve" ]
