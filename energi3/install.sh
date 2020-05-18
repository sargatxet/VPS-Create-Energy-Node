apt-get autoremove -y docker docker-engine docker.io containerd runc

apt-get update

apt-get install -y git wget

curl -fsSL https://get.docker.com | sh -

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

wget https://raw.githubusercontent.com/sargatxet/VPS-Create-Energy-Node/blob/master/energi3/Dockerfile

wget https://raw.githubusercontent.com/sargatxet/VPS-Create-Energy-Node/blob/master/energi3/docker-compose.yaml

docker-compose up -d
