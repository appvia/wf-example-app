FROM nginxinc/nginx-unprivileged:stable-alpine as production

LABEL Name=wf-example-app \
      Release=https://github.com/appvia/wf-example-app \
      Maintainer=wayfinder@appvia.io \
      Url=https://github.com/appvia/wf-example-app

COPY ./index.html /usr/share/nginx/html/index.html
