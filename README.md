# jobcan-checker-script

This script outputs how much overtime work this month.

## Usage

```sh
# docker is required.
$ docker build -t my-app .
$ docker run --env-file .env -it --rm my-app
// e.g. 9 時間 2 分
```

If you want to mount your updates.

```sh
# Please build image using docker build command.
$ docker run -v $PWD:/usr/src/app --env-file .env -it --rm my-app
```
