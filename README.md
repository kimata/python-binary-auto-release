# python-binary-auto-release

Nuitka を使って Python スクリプトを実行ファイルに変換する GitHub Actions のサンプルです．


## ファイルの場所

Github Action の記述は下記にあります．

[.github/workflows/release.yml](.github/workflows/release.yml)


## 前提・想定

上のファイルの記述の前提は以下の通りです．

### プロジェクトの構成・運用

下記の想定で記載しています．

- Poetry でパッケージを管理
- Python スクリプトだけでなく，設定ファイルも同梱
- Windows と Linux (Ubunti) 向けのバイナリを生成
- 「v0.1.0」のようなタグを打った時にバイナリファイルを生成

## 変換対象のスクリプトの動作

実行ファイルに変換するスクリプトは，YAML ファイルを読み込んで，
その中で定義された message を出力するものになっています．


```
% cat config.example.yaml
message: Hellow World!
% poetry run ./test.py -c config.example.yaml
Hellow World!
```

このため，実行ファイルのリリース時は，変化後のバイナリだけでなく，
設定ファイルを同梱しています．


## 生成される実行ファイル

Linux の向けの場合，Github からダウンロードした後，下記のようにして実行できるようになっています．

```
% unzip test-ubuntu_x64-binary-*.zip
% cd test-ubuntu-latest-binary-*
% ./test.bin -c config.example.yaml
Hellow World!
```


