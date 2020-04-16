# Rails Tutorial

## このアプリを作った背景・目的
入社前研修のRailsアプリケーションの課題
- RailsでのCRUD処理を行う
- JSを使ったDOMの動的な操作を行う

### 開発
```
devise を用いて管理者を作成
action cableを用いてリアルタイムチャットの実装
vue を使用しての開発
slim テンプレートを使用
```

### 参考
[chamo-chat](https://chamo-chat.com/)

## このアプリの使い方
管理者サイド, 顧客サイドの2つあります。

### 実行手順
```sh
yarn start
rails s
```

### 管理者
`http://localhost:3000/admins/rooms`にアクセスする。

チャットルーム一覧が表示される。
![管理者](https://user-images.githubusercontent.com/45251394/77324847-b6d33280-6d5a-11ea-99bd-eb5dd4363ce8.png)

### 顧客
`http://localhost:3000/rooms/enter`にアクセスする。

右下にチャットウィンドウが表示されるため、messageと書かれた部分をクリックするとチャット画面が表示されます。
![顧客](https://user-images.githubusercontent.com/45251394/77324867-bc307d00-6d5a-11ea-9b94-6db52064ada8.png)

## どこまで実装が完了して、何が終わっていないか

### 実装済
- 顧客との一対一リアルタイムチャットができる。
- 新着メッセージ受信時の通知

### 未実装
- 新着メッセージ受信時のpush通知
- 定型分入力
- script埋め込み　切り出し
- デザイン
