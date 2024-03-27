# コード署名用の Certificate を作成します．
# 使うのは，${NAME}.pfx.txt．

NAME=local

openssl genrsa -out ${NAME}.key
openssl req -new -subj "/C=JP/ST=Tokyo/L=Shibuya/O=Rabbit Note/OU=None/CN=rabbit-note.com" -key ${NAME}.key -out ${NAME}.csr
openssl x509 -req -days 36500 -signkey ${NAME}.key -in ${NAME}.csr -out ${NAME}.cer
openssl pkcs12 -export -inkey ${NAME}.key -in ${NAME}.cer -out ${NAME}.pfx
base64 ${NAME}.pfx > ${NAME}.pfx.txt
