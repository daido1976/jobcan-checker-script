# jobcan-checker-script

This script checks the jobcan for me.

## Usage

```sh
# docker is required.
$ docker build -t my-app .
$ docker run --env-file .env -it --rm my-app
```

If you want to mount your updates.

```sh
# Please build image using docker build command.
$ docker run -v $PWD:/usr/src/app --env-file .env -it --rm my-app
```
