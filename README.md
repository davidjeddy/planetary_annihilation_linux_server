# Planetary Annihilation Dedicated Server

## Sources

- [https://dev.exodusesports.com/guides/planetary-annihilation-dedicated-server-setup/](https://dev.exodusesports.com/guides/planetary-annihilation-dedicated-server-setup/)
- [https://www.hiroom2.com/2018/07/01/ubuntu-1804-vbox-guest-additions-en/](https://www.hiroom2.com/2018/07/01/ubuntu-1804-vbox-guest-additions-en/)

## Setup

### Localhost

```sh
docker pull ubuntu:18.04
docker run -d -v $(pwd):/server -p 20545:20545 --rm --name u18_04 ubuntu:18.04 tail -f /dev/null
docker ps
docker exec -it u18_04 bash
cd /server
./install.sh
# enter PA username and password when prompted
```

Finally, ensure inbound port `20545` is accessible via remote clients.

Enjoy.
