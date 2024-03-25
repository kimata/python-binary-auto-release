#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
テスト用ダミーアプリです．

Usage:
  test.py [-c CONFIG]

Options:
  -c CONFIG     : CONFIG を設定ファイルとして読み込んで実行します．[default: config.yaml]
"""


def say(config):
    print(config["message"])


if __name__ == "__main__":
    from docopt import docopt
    import yaml

    args = docopt(__doc__)

    with open(args["-c"], "r") as file:
        config = yaml.load(file, Loader=yaml.SafeLoader)
        say(config)
