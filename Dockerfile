# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.4

# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# build ステージと最終イメージに必要な共通のベースイメージ
# ここにはランタイムに必要なものと、両ステージで共通して必要なビルドツールを含める
# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

RUN echo "DEBUG: (base stage)" > /tmp/docker_debug.log 2>&1
WORKDIR /rails_api
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libjemalloc2 \
    libpq-dev \
    libssl-dev \
    libvips \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    pkg-config \
    postgresql-client \
    ruby-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives
ENV BUNDLE_PATH="/rails_api/vendor/bundle" \
    PATH="/rails_api/bin:$PATH"

# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# build ステージ
# 主にGemのインストールのみを行う
# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
FROM base AS build

RUN echo "DEBUG: (build stage)"
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FORCE_RUBY_PLATFORM=true
RUN bundle install --jobs $(nproc) --no-prune --clean && \
    chown -R 1000:1000 "${BUNDLE_PATH}" && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git
COPY . .
RUN bundle exec bootsnap precompile app/ lib/

# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# 最終イメージ
# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
FROM base

RUN echo "DEBUG: (final stage)"
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    docker.io \
    sudo \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash
COPY --from=build /rails_api /rails_api
RUN chown -R 1000:1000 /rails_api && \
    chown -R 1000:1000 /home/rails
RUN usermod -a -G docker rails && \
    groups rails && \
    echo "rails ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/dockerd, /bin/chown, /bin/chmod" >> /etc/sudoers && \
    echo 'export DOCKER_GID=$(stat -c %g /var/run/docker.sock 2>/dev/null || echo 999)' >> /home/rails/.bashrc && \
    echo 'sudo chgrp $DOCKER_GID /var/run/docker.sock 2>/dev/null || true' >> /home/rails/.bashrc
# ENTRYPOINTをrootとして実行し、内部でrailsユーザーに切り替え
ENTRYPOINT ["/rails_api/bin/docker-entrypoint"]
CMD ["bin/startup.sh"]
EXPOSE 80
