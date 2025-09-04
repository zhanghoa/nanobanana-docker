# Dockerfile
FROM denoland/deno:2.4.5


# 先预缓存依赖（避免运行时下载）
# 这里列出你 main.ts 中用到的所有远程依赖
RUN deno cache \
  --unstable \
  https://deno.land/std@0.224.0/http/server.ts \
  https://deno.land/std@0.224.0/http/file_server.ts \
  https://deno.land/std@0.177.0/node/buffer.ts

# 复制源码
COPY main.ts ./
COPY static ./static

EXPOSE 8088

# 使用 --cached-only 确保不联网
CMD ["run", "--allow-net", "--allow-read", "--cached-only", "main.ts"]
