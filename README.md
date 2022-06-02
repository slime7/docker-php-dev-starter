# docker php development environment

- 使用 php-fpm 搭建的开发环境，集成了 xdebug 及其他一些插件。nginx 和 mysql 跟 php 不在一个容器内，可以自由切换。

## 使用方式

1. 使用 `npx degit slime7/docker-php-dev-starter` 或者从[这里](https://github.com/slime7/docker-php-dev-starter/archive/refs/heads/master.zip)下载将模板下载到本地。

2. 进入项目目录，使用`docker-compose up -d` 启动服务。第一次使用会构建 php-fpm 容器。

3. 在浏览器中访问 `http://localhost:8080/` 即可看到 phpinfo 信息。

- (可选，windows) 使用 `./composer` 可使用 docker 内 composer 代替本地安装执行 composer 命令。

## 设置

### php-fpm

- php 配置文件 `./php/conf.d/custom.ini`
- docker-compose.yml 环境变量
  - xdebug 连接地址: XDEBUG_CLIENT_HOST=host.docker.internal
  - xdebug 端口: XDEBUG_CLIENT_PORT=9003
  - xdebug ide key: XDEBUG_IDE_KEY=docker

### nginx

- 配置文件 `./nginx/conf/nginx.conf` 和 `./nginx/conf.d` 目录
- 可使用 `./reload_nginx` 命令重载 nginx 设置


### mysql

- 配置文件 `./mysql/conf.d` 目录
- 在项目内使用 `db` 连接数据库
