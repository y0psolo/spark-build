#/bin/sh

set -o errexit

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


VERSION24=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/spark 'v[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "2\.4\.[0-9]+$")
VERSION30=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/spark 'v[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "3\.0\.[0-9]+$")
VERSION31=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/spark 'v[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "3\.1\.[0-9]+$")
VERSION32=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/spark 'v[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "3\.2\.[0-9]+$")
VERSION33=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/spark 'v[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "3\.3\.[0-9]+$")

HADOOP2=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/hadoop 'rel/release-[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "2\.[0-9]+\.[0-9]+$")
HADOOP3=$(git -c versionsort.suffix=- ls-remote -t --exit-code --refs --sort=-v:refname https://github.com/apache/hadoop 'rel/release-[0-9]*.[0-9]*.[0-9]*' | grep -o -m 1 -E "3\.[0-9]+\.[0-9]+$")

# Update Hadoop version
sed -i -E "s/(hadoop: )2\.[0-9]+\.[0-9]+/\1$HADOOP2/g" .github/workflows/build_spark2.yml
sed -i -E "s/(hadoop: )3\.[0-9]+\.[0-9]+/\1$HADOOP3/g" .github/workflows/build_spark3.yml

# Update Spark version
sed -i -E "s/(spark: )2\.[0-9]+\.[0-9]+/\1$VERSION24/g" .github/workflows/build_spark2.yml
sed -i -E "s/(spark: )\[3\.[0-9]+\.[0-9]+, 3\.[0-9]+\.[0-9]+, 3\.[0-9]+\.[0-9]+, 3\.[0-9]+\.[0-9]+\]/\1[$VERSION30, $VERSION31, $VERSION32, $VERSION33]/g" .github/workflows/build_spark3.yml