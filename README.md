# UnrealIRCd docker

## What is UnrealIRCd

[UnrealIRCd]( https://www.unrealircd.org ) is an Open Source IRC Server, serving thousands of networks since 1999. It
runs on Linux, OS X and Windows and is currently the most widely deployed IRCd with a market share of 42%. UnrealIRCd is
a highly advanced IRCd with a strong focus on modularity, an advanced and highly configurable configuration file. Key
features include SSL/TLS, cloaking, its advanced anti-flood and anti-spam systems, swear filtering and module support.

# Configuration

The UnrealIRCd reference config can be
found in the [official UnrealIRCd reference config]( https://raw.githubusercontent.com/unrealircd/unrealircd/unreal60_dev/doc/conf/examples/example.conf )
for version 6 and above.\
This file must be mounted at `/app/data/unrealircd.conf`.\
When adding additional custom configurations, please mount only new files,
as editing the default config files is not recommended by UnrealIRCd.\
For more information regarding the configuration options, please refer to the [official UnrealIRCd configuration documentation](https://www.unrealircd.org/docs/Configuration).


# Getting Started

## Docker

UnrealIRCd must have both a configuration and tls key-pair files.\
The is deployed via docker image like so:

```bash
docker run -d --name unreadlircd \
  -v /path/to/file/unrealircd.conf:/app/data/unrealircd.conf \
  -p 6667:6667 -p 6697:6697 \
  djlegolas/unrealircd:latest
```

### Available Mount Points
All the desired mounts are located under `/app`:
* `/app/config` configurations.
* `/app/data` all of the instance DB.
* `/app/tls` location to mount user-defined certs. Don't forget to add certs into `unrealircd.conf`.

or via docker-compose:

[Official Example](https://github.com/DjLegolas/unrealircd-docker/blob/main/docker-compose.yml)
