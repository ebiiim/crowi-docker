# Crowi Docker image

- Using the latest [Crowi](https://github.com/crowi/crowi) that supports MongoDB Atlas
- With custom favicon loader
- With K8s manifests

## Usage

### Docker

Listen on port 3000:

```sh
# make sure you have MongoDB running
docker run -p3000:3000 -eMONGO_URI="mongodb://<mongodb_host>:27017/crowi" ghcr.io/ebiiim/crowi-docker:latest serve
```

Show help:

```sh
docker run ghcr.io/ebiiim/crowi-docker:latest --help
```

### Kubernetes

See [crowi.yml](k8s/crowi.yml)

## Changelog

### 1.4.1 - 2023-01-09

- minor fixes

### 1.4.0 - 2023-01-09

- Crowi: [49bd606e492faca79efe5750a3c83daa378e77c0](https://github.com/crowi/crowi/tree/49bd606e492faca79efe5750a3c83daa378e77c0) 2022-11-04
  - image optimizations

### 1.3.2 - 2022-10-19

- fix Android icon loading

### 1.3.1 - 2022-10-19

- K8s now use default entrypoint in Dockerfile
- fix missing ca-certificates

### 1.3.0 - 2022-10-19

- upgrade base images buster->bullseye
- change assets environment variables name

### 1.2.0 - 2022-10-18

- Crowi: [1c9324a4b1649f0534a75118c375f38cfdbc002d](https://github.com/crowi/crowi/tree/1c9324a4b1649f0534a75118c375f38cfdbc002d) 2022-10-16
- load icons with run.sh instead of pushing them into the image

### 1.1.1 - 2022-05-10

- white background for app icons

### 1.1.0 - 2022-05-05

- Crowi: [745881d7cf6b93cdb850143eb05b6299c0f31fe2](https://github.com/crowi/crowi/tree/745881d7cf6b93cdb850143eb05b6299c0f31fe2) 2021-09-11

### 1.0.0 - 2022-05-05

- add favicon
- add K8s examples

### 0.1.0 - 2021-05-27

- initial release
- Crowi: [eecf2bc821098d2516b58104fe88fae81497d3ea](https://github.com/crowi/crowi/tree/eecf2bc821098d2516b58104fe88fae81497d3ea) 2020-11-06
