# apache
curl -O http://apache.cyberuse.com/httpd/httpd-2.2.22.tar.gz
tar xvzf httpd-2.2.22.tar.gz
cd httpd-2.2.22
./configure --prefix=/app/apache --enable-rewrite
make
make install
cd ..

# php
curl -O -L http://uk3.php.net/get/php-5.3.10.tar.gz/from/this/mirror
mv mirror php-5.3.10.tar.gz
tar xzvf php-5.3.10.tar.gz
cd php-5.3.10/
echo "./configure --prefix=/app/php --with-apxs2=/app/apache/bin/apxs --with-mysql --enable-ftp --with-pdo-mysql --with-pgsql --with-pdo-pgsql --with-iconv --with-gd --with-curl=/usr/lib --with-config-file-path=/app/php --enable-soap=shared --with-openssl"
./configure --prefix=/app/php --with-mysql --enable-ftp --with-pdo-mysql --with-pgsql --with-pdo-pgsql --with-iconv --with-gd --with-curl=/usr/lib --with-config-file-path=/app/php --enable-soap=shared --with-openssl
make
make install
cd ..

# php extensions
mkdir /app/php/ext
cp /usr/lib/libmysqlclient.so.15 /app/php/ext/

# pear
apt-get install php5-dev php-pear
pear config-set php_dir /app/php
pecl install apc
mkdir /app/php/include/php/ext/apc
cp /usr/lib/php5/20060613/apc.so /app/php/ext/
cp /usr/include/php5/ext/apc/apc_serializer.h /app/php/include/php/ext/apc/


# package
cd /app
echo '2.2.22' > apache/VERSION
tar -zcvf apache.tar.gz apache
echo '5.3.10' > php/VERSION
tar -zcvf php.tar.gz php