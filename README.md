# UnrealIRCd Docker
[![Docker Pulls](https://img.shields.io/docker/pulls/djlegolas/unrealircd)](https://hub.docker.com/r/djlegolas/unrealircd)
[![Docker Image Size](https://img.shields.io/docker/image-size/djlegolas/unrealircd)](https://hub.docker.com/r/djlegolas/unrealircd)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/DjLegolas/unrealircd-docker/build.yaml)](https://github.com/DjLegolas/unrealircd-docker)

Unofficial Docker image for running [UnrealIRCd](https://www.unrealircd.org).

## Configuration

Use the UnrealIRCd v6 example config as a starting point:
[example.conf](https://raw.githubusercontent.com/unrealircd/unrealircd/unreal60_dev/doc/conf/examples/example.conf)

In this image, the UnrealIRCd config directory is `/app/conf`, so the main config must be mounted as:
`/app/conf/unrealircd.conf`

For UnrealIRCd config syntax and modules, see the official docs:
[UnrealIRCd Configuration](https://www.unrealircd.org/docs/Configuration)

## Quick Start

### Docker

```bash
docker run -d --name unrealircd \
  -v /path/to/unrealircd.conf:/app/conf/unrealircd.conf:ro \
  -v /path/to/data:/app/data \
  -v /path/to/logs:/app/logs \
  -p 6667:6667 \
  -p 6697:6697 \
  djlegolas/unrealircd:latest
```

### Docker Compose

```yaml
services:
  unrealircd:
    image: djlegolas/unrealircd:latest
    ports:
      - "6667:6667"
      - "6697:6697"
    volumes:
      - "/path/to/unrealircd.conf:/app/conf/unrealircd.conf:ro"
      - "/path/to/data:/app/data"
      - "/path/to/logs:/app/logs"
      # Optional: custom TLS certs/keys
      - "/path/to/tls:/app/conf/tls"
```

## Mount Points

Useful container paths under `/app`:

- `/app/conf` UnrealIRCd config files (`unrealircd.conf` lives here).
- `/app/conf/tls` TLS certificate/key directory used by default config.
- `/app/data` runtime data files.
- `/app/logs` log files.

## TLS Notes

- If no TLS files exist in `/app/conf/tls`, the container entrypoint auto-generates a self-signed certificate.
- For production, mount your own certs into `/app/conf/tls` and reference them in `unrealircd.conf`.

## Image Tags

Published tags include:

- `djlegolas/unrealircd:latest`
- `djlegolas/unrealircd:<unrealircd-version>`
