#!/usr/bin/env bash

set -o errexit

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs
npm install -g yarn

bundle install

yarn install --frozen-lockfile
yarn build:css

bin/rails assets:precompile
bin/rails assets:clean

bin/rails db:migrate