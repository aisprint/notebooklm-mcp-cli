FROM python:3.11-slim

# Node.js と必要なツールをインストール
RUN apt-get update && apt-get install -y curl bash
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# supergatewayをインストール
RUN npm install -g supergateway

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# ★ポイント1: クラウド環境向けに受付窓口を「外線(0.0.0.0)」に固定
ENV HOST="0.0.0.0"

# ★ポイント2: "nlm mcp" をコマンドと引数として正しく分離（-- nlm mcp）
RUN printf '#!/bin/bash\nsupergateway --port "${PORT:-3000}" --stdio -- nlm mcp\n' > /start.sh
RUN chmod +x /start.sh

# 作成したスクリプトを実行
CMD ["/start.sh"]
