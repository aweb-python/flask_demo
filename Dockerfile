# 使用 Alpine 作为基础镜像
FROM python:3.10-alpine

ENV APP_NAME flask_demo

# 设置工作目录
WORKDIR /home/admin/$APP_NAME/

COPY . $WORKDIR
RUN mkdir -p ~/.pip/ && \
    echo -e "[global]\nextra-url=http://mirrors.cloud.aliyuncs.com/pypi/simple/\n[install]\ntrusted-host=mirrors.cloud.aliyuncs.com" > ~/.pip/pip.conf && \ 
    > /etc/apk/repositories && \
    echo -e "http://mirrors.cloud.aliyuncs.com/alpine/v3.15/main\nhttp://mirrors.cloud.aliyuncs.com/alpine/v3.15/community" >/etc/apk/repositories 
RUN    apk update && apk add curl busybox-extras && \
    pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# 暴露 Flask 默认端口
EXPOSE 5000

# 设置环境变量 FLASK_APP 和 FLASK_ENV
ENV FLASK_APP=app:app
ENV FLASK_ENV=development

# 运行 Flask 开发服务器
CMD ["flask", "run", "--host=0.0.0.0","--port=80"]
