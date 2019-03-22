FROM node:8.9.4-alpine
RUN apk add --update alpine-sdk 
RUN npm install -g textlint textlint-plugin-latex
CMD ["/bin/bash"]
