# Dockerfile
FROM denoland/deno:1.46.3

WORKDIR /app

# 复制源码
COPY main.ts ./
COPY static ./static

# 暴露端口
EXPOSE 8088

# 运行命令（Deno 标准做法）
CMD ["run", "--allow-net", "--allow-read", "main.ts"]
