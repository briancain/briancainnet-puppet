# briancainnet

A puppet module to set up briancain.net

## How to use

```shell
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb

sudo apt-get update
sudo apt-get install puppet-agent

sudo r10k puppetfile install -v
sudo /opt/puppetlabs/bin/puppet apply -e 'include briancainnet'
sudo /opt/puppetlabs/bin/puppet apply -e 'include briancainnet::website'
```
