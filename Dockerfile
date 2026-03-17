FROM python:3.11-slim

# Node.js と必要なツールをインストール
RUN apt-get update && apt-get install -y curl bash
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# npmのアップデート（念のためエラーログに出ていた警告を解消）
RUN npm install -g npm@latest

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# ★ ここがポイント：起動用のシェルスクリプトを直接作成する
# これにより、Railway側でどのような形でコマンドが呼ばれても引数がズレません
RUN echo '#!/bin/bash\nnpx -y supergateway --sse --port ${PORT:-3000} -- nlm mcp' > /start.sh
RUN chmod +x /start.sh

# 作成したスクリプトを実行
CMD ["/start.sh"]
