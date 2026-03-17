FROM python:3.11-slim

# uv と notebooklm-mcp-cli だけをインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# ★ドキュメント通り、環境変数でSSEモードをONにする
ENV NOTEBOOKLM_MCP_TRANSPORT="sse"
ENV HOST="0.0.0.0"

# ポートを指定して、公式のMCPサーバーを直接起動
CMD sh -c "nlm mcp --port ${PORT:-8000}"
