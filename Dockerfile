FROM k1low/alpine-pandoc-ja
RUN apk add --update alpine-sdk nodejs nodejs-npm git
RUN npm install -g textlint regx &&\
    npm install -g textlint-plugin-latex \
                   textlint-plugin-latex2e &&\
    npm install -g textlint-rule-max-ten \
                   textlint-rule-spellcheck-tech-word \
                   textlint-rule-no-mix-dearu-desumasu &&\
    npm install -g textlint-rule-preset-ja-engineering-paper \
                   textlint-rule-preset-ja-technical-writing \
                   textlint-rule-preset-japanese
    npm install -g npm-install-missing
CMD ["/bin/bash"]
