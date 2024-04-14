# https://github.com/Sunwood-ai-labs/ChatVRM_Docker/blob/main/README.md

# 最新安定バージョンのNode.jsが含まれているベースイメージを指定します。
FROM node:21-bullseye

# コンテナ内での作業ディレクトリを設定します。アプリケーションファイルはここに配置されます。
WORKDIR /home

# システムパッケージを更新し、必要な依存関係をインストールします。
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# GitHubからプロジェクトをクローンします。
RUN git clone https://github.com/pixiv/ChatVRM

# プロジェクトのディレクトリに作業ディレクトリを変更します。
WORKDIR /home/ChatVRM

# browserslistデータベースを最新のバージョンに更新します。
RUN npx -y update-browserslist-db@latest

# アプリケーションに必要なNode.jsモジュールをインストールします。
RUN npm install

# コンテナがポート3000をリッスンすることを示します。これは文書の目的であり、実際にポートを公開するわけではありません。
EXPOSE 3000

# サーバーを起動
RUN npm run build
CMD ["npm",  "start"]