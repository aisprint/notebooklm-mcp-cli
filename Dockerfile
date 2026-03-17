FROM python:3.11-slim

# 必要なツールとNode.jsをインストール
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# MCPをSSE化するブリッジツールを公式パッケージ名で確実にインストール
RUN npm install -g @smithery/supergateway

# パスと環境変数の設定
ENV PATH="/root/.local/bin:${PATH}"
ENV HOST="0.0.0.0"
ENV PORT=3000

# ★ 一切の細工なし。シンプルにコマンドを実行
CMD ["sh", "-c", "supergateway --stdio --port $PORT -- nlm mcp"]
