DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing ruby 1.9.3"
sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev curl git-core python-software-properties

cd /tmp &&
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz &&
tar -xvzf ruby-1.9.3-p194.tar.gz &&
cd ruby-1.9.3-p194/ &&
./configure &&
make &&
sudo make install &&
sudo gem update --system

echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
sudo gem install bundler
sudo gem install soloist

cd $DIR && cd ../

rake cookbooks
soloist