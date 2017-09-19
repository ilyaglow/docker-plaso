[![](https://images.microbadger.com/badges/image/ilyaglow/plaso.svg)](https://microbadger.com/images/ilyaglow/plaso)

# log2timeline/plaso docker

## Usage

This Dockerfile has `log2timeline.py` entrypoint by default, so you can use it as a binary:
```
docker run -it --rm -v path-to-objects:/data:ro -v path-to-export:/export:rw ilyaglow/plaso --parsers winreg /export/registry.plaso /data
```

To override it use `--entrypoint` flag
