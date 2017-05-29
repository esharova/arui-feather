#!/usr/bin/env sh

STYLEGUIDE_NAME="styleguide"

ROOT="$(dirname $0)"
REPORTS_ROOT="$ROOT/reports"
SOURCE_SHOWCASE_DIR="$ROOT/arui-demo/$STYLEGUIDE_NAME"
PUBLISH_SHOWCASE_DIR="$REPORTS_ROOT/$STYLEGUIDE_NAME"

npm run styleguide-build

git clone -q --branch gh-pages "https://$GH_TOKEN@github.com/teryaew/arui-feather-reports.git" "$REPORTS_ROOT"
mkdir -p ${PUBLISH_SHOWCASE_DIR}
cp -r ${SOURCE_SHOWCASE_DIR}/* ${PUBLISH_SHOWCASE_DIR}

cd "$REPORTS_ROOT"
git config user.name "Travis CI"
git config user.email "travis@travis-ci.org"
git add -A -f
git commit -q -m "chore(*): update styleguide by travis build $TRAVIS_BUILD_NUMBER"
git pull -q --rebase origin gh-pages
git push -q origin gh-pages
cd -
