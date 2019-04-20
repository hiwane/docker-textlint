FROM node:8.9.4-alpine
RUN apk add --update alpine-sdk 
RUN npm install -g textlint &&\
    npm install -g textlint-plugin-latex textlint-plugin-latex2e &&\
    npm install -g textlint-rule-max-ten textlint-rule-spellcheck-tech-word textlint-rule-no-mix-dearu-desumasu &&\
    npm install -g textlint-rule-preset-ja-engineering-paper \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-preset-japanese
CMD ["/bin/bash"]
