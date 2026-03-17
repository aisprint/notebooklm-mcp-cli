FROM python:3.11-slim

# Node.js (supergateway用) と curl をインストール
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# Railwayが動的に割り当てるPORT環境変数を使用してsupergatewayを起動
CMD sh -c "npx -y supergateway --sse --port ${PORT:-3000} -- nlm mcp"
