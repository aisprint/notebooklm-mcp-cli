FROM python:3.11-slim

# 必要なツールとNode.jsをインストール
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# ★修正：正しいパッケージ名「supergateway」をインストール
RUN npm install -g supergateway

# パスと環境変数の設定
ENV PATH="/root/.local/bin:${PATH}"
ENV HOST="0.0.0.0"

# シンプルかつ確実に起動させるコマンド
CMD sh -c "supergateway --stdio \"nlm mcp\" --port ${PORT:-3000}"
