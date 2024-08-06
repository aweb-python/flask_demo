# 使用 Alpine 作为基础镜像
FROM python:3.10-alpine

ENV APP_NAME flask_demo

# 设置工作目录
WORKDIR /home/admin/$APP_NAME/

COPY pip.conf /root/.pip/pip.conf

COPY . $WORKDIR

RUN pip3 install -r requirements.txt 

# 暴露 Flask 默认端口
EXPOSE 5000

# 设置环境变量 FLASK_APP 和 FLASK_ENV
ENV FLASK_APP=app:app
ENV FLASK_ENV=development

# 运行 Flask 开发服务器
CMD ["flask", "run", "--host=0.0.0.0"]
