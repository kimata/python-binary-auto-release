# python-binary-auto-release

Nuitka を使って Python スクリプトを実行ファイルに変換する GitHub Actions のサンプルです．


## ファイルの場所

Github Action の記述は下記にあります．

[.github/workflows/release.yml](.github/workflows/release.yml)

## GitHub の設定

上記の Github Action を使う場合，レポジトリの [Settings] - [Actions] - [General] - [Workflow permissions]]
で，「Read and write permissions」を選択しておく必要があります．

この設定がされていないと，「Resource not accessible by integration」というエラーが発生して，
実行が途中で止まります．


## 前提・想定

上のファイルの記述の前提は以下の通りです．

### プロジェクトの構成・運用

下記の想定で記載しています．

- Poetry でパッケージを管理
- Python スクリプトだけでなく，設定ファイルも同梱
- Windows と Linux (Ubunti) 向けのバイナリを生成
- 「v0.1.0」のようなタグを打った時にバイナリファイルを生成

### 変換対象のスクリプトの動作

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


### 生成される実行ファイル

Linux の向けの場合，Github からダウンロードした後，下記のようにして実行できるようになっています．

```
% unzip test-ubuntu_x64-binary-*.zip
% cd test-ubuntu-latest-binary-*
% ./test.bin -c config.example.yaml
Hellow World!
```

## コード署名

[lando/code-sign-action](https://github.com/lando/code-sign-action) を使って，
自動的に Windows 用の実行ファイル(\*.exe)に署名できるようになっています．

### Certificate の準備

ちゃんと署名する場合は，然るべき手続きをして Cetificate (*.pfx) [^1]を用意します．
そうではなく，オレオレ証明書でとりあえず署名したい場合，[gen_certificate.sh](gen_certificate.sh) を実行すると，
必要なファイルが生成されます．パスワードはなんでも良いですが，覚えおきます．

使うのは，Cetificate (\*.pfx) を Base64 でエンコードしたテキストファイル (\*.pfx.txt) です．

[^1]: コード署名の技術に明るくないので，「Certificate」等の用語の使い方が正しくない可能性があります．すみません．

### GitHub Secrets の設定

GitHub リポジトリの，[Settings] - [Secrets and variables] - [Actions] - [Repository secrets] の
「New repository secrets」をクリックして下記の 2 つの変数を定義します．

<dl>
  <dt>CERTIFICATE</dt>
  <dd>Cetificate (\*.pfx) を Base64 でエンコードしたテキストファイル (\*.pfx.txt) の中身</dd>
  <dt>PASSWORD</dt>
  <dd>Certificate を生成した時に使ったパスワード</dd>
</dl>

ここまで設定すれば，tag を push すると，実行ファイル作成後にコード署名処理が行われるようになります．

