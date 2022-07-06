# jobcan-checker-script

This script no longer works due to changes in the jobcan UI.
Please refer to the newly created https://github.com/daido1976/jobcan-overtime.

---

This script outputs how much overtime work this month for jobcan.

## Usage

Please set environment variables.

```sh
# rename file from .env.skeleton to .env
MY_EMAIL=hoge@fuga.jp
MY_PASSWORD=hogefuga
MY_NAME=勤労 太郎
```

[Docker](https://www.docker.com/) is required.

```sh
$ bin/build

# 出勤日当日の朝や休日などに確認する用
$ bin/check
// e.g. 9 時間 2 分

# 出勤日当日の午後以降に確認する用
$ bin/check cd
// e.g. 1 時間 2 分
```

If you want to run this script directly in `bash`.

```sh
$ docker run --env-file .env -it --rm jobcan-checker /bin/bash

# 出勤日当日の朝や休日などに確認する用
root@hogehoge:/usr/src/app# bundle exec ruby jobcan_checker_script.rb
// e.g. 9 時間 2 分

# 出勤日当日の午後以降に確認する用
root@hogehoge:/usr/src/app# bundle exec ruby jobcan_checker_script.rb cd
// e.g. 1 時間 2 分
```

If you want to mount your updates.

```sh
# Please build image using docker build command.
$ docker run -v $PWD:/usr/src/app --env-file .env -it --rm jobcan-checker
```
