# orphans/hugo

This is a minimal Docker image for generating static sites with [Hugo](https://gohugo.io/). 

It has two purposes:

## 1. Site development

To run a local server during development add the following `docker-compose.yml` file to the root of your Hugo project.

**Note: Hugo will serve draft content when run in this manner.**

```yml
version: "3.1"
services:
  hugo:
    image: orphans/hugo
    ports: 
      - "1313:1313"
    volumes: 
      - ".:/hugo"
```

Then run `docker-compose up` as usual.

## 2. Continuous Integration

The image can be used with CI to build the static website files and Rsync them to a remote server. 

*(Detail to follow)*
