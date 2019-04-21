FROM paperist/alpine-texlive-ja
RUN apk add --update alpine-sdk
RUN apk add nodejs nodejs-npm git
RUN npm install -g textlint regx kuromojin structured-source sentence-splitter \
 && npm install -g textlint-plugin-latex \
                   textlint-plugin-latex2e \
 && npm install -g textlint-rule-max-ten \
                   textlint-rule-spellcheck-tech-word spellcheck-technical-word \
                   textlint-rule-no-mix-dearu-desumasu analyze-desumasu-dearu \
 && npm install -g textlint-rule-preset-ja-engineering-paper \
                   textlint-rule-preset-ja-technical-writing \
                   textlint-rule-preset-japanese

# INSTALL PANDOC 
# https://github.com/portown/alpine-pandoc/blob/master/LICENSE
ENV PANDOC_VERSION 2.7
ENV PANDOC_DOWNLOAD_URL https://github.com/jgm/pandoc/archive/$PANDOC_VERSION.tar.gz
ENV PANDOC_DOWNLOAD_SHA512 5830e0d8670a0bf80d9e8a84412d9f3782d5a6d9cf384fc7a853ad7f4e41a94ed51322ca73b86ad93528a7ec82eaf343704db811ece3455e68f1049761544a88
ENV PANDOC_ROOT /usr/local/pandoc

RUN apk add --no-cache \
    gmp \
    libffi \
 && apk add --no-cache --virtual build-dependencies \
    --repository "http://nl.alpinelinux.org/alpine/edge/community" \
    ghc \
    cabal \
    linux-headers \
    musl-dev \
    zlib-dev \
    curl \
 && mkdir -p /pandoc-build && cd /pandoc-build \
 && curl -fsSL "$PANDOC_DOWNLOAD_URL" -o pandoc.tar.gz \
 && tar -xzf pandoc.tar.gz && rm -f pandoc.tar.gz \
 && ( cd pandoc-$PANDOC_VERSION && cabal update && cabal install --only-dependencies \
    && cabal configure --prefix=$PANDOC_ROOT \
    && cabal build \
    && cabal copy \
    && cd .. ) \
 && rm -Rf pandoc-$PANDOC_VERSION/ \
 && apk del --purge build-dependencies \
 && rm -Rf /root/.cabal/ /root/.ghc/ \
 && cd / && rm -Rf /pandoc-build
# && echo "$PANDOC_DOWNLOAD_SHA512  pandoc.tar.gz" | sha512sum -c - \


CMD ["/bin/bash"]
