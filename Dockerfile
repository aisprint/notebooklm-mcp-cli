FROM python:3.11-slim

# Node.js と必要なツールをインストール
RUN apt-get update && apt-get install -y curl bash
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# ★ここがポイント：npxのバグを避けるため、supergatewayを直接インストール
RUN npm install -g supergateway

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# printfコマンドを使って、文字化けや改行エラーが起きないよう確実にスクリプトを作成
RUN printf '#!/bin/bash\nsupergateway --sse --port "${PORT:-3000}" -- nlm mcp\n' > /start.sh
RUN chmod +x /start.sh

# 作成したスクリプトを実行
CMD ["/start.sh"]
