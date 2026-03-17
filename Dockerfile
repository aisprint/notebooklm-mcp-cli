FROM python:3.11-slim

# Node.js と必要なツールをインストール
RUN apt-get update && apt-get install -y curl bash
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# uv と notebooklm-mcp-cli をインストール
RUN pip install uv
RUN uv tool install notebooklm-mcp-cli

# パスを通す
ENV PATH="/root/.local/bin:${PATH}"

# 起動用のシェルスクリプトを作成
RUN echo '#!/bin/bash\nnpx -y supergateway --sse --port ${PORT:-3000} -- nlm mcp' > /start.sh
RUN chmod +x /start.sh

# 作成したスクリプトを実行
CMD ["/start.sh"]
