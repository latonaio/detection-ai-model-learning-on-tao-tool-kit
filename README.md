# detection-ai-model-initial-learning-on-tao-tool-kit
このレポジトリは、NVIDIA TAO Tool Kit が デプロイされた一定能力を有する NVIDIA GPU サーバー 上 において、2D画像検出系のAIモデルを初期学習するときの手順等を示したものです。

## 手順
1. AWS EC2 instance 作成
    - distribution : NVIDIA Deep Learning AMI
    - インスタンスタイプ：AWS の場合、p3系統以上 で GPUを使用可能
    - storage : 200GB 以上

1. インスタンスの初期設定
    - apt update が機能しないので下記を実行
    ```sh
    sudo su -
    apt-key del 7fa2af80
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb .

    sudo rm /etc/apt/sources.list.d/cuda.list
    sudo rm /etc/apt/sources.list.d/nvidia-ml.list
    ```
    - aws cli の設定
        - `aws configure` の実行
    - s3 等から学習データのダウンロード

1. jupyter-note 起動
    - [nvidia公式](https://docs.nvidia.com/tao/tao-toolkit/text/running_in_cloud/running_tao_toolkit_on_aws.html) を参考に jupyter-notebook 環境を構築する。
    - jupyter-note 起動コマンド

    ```sh
    nohup jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root --NotebookApp.token='' &
    ```

    - 同梱の `detectnet_v2.ipynb` を jupyter-notebook で開き、参考に学習を進める。    

1. mount position の選定
    - ec2とcontainerでmountするので、よく考える必要がある。
    - training, prune などの tao command は container内で実行される。
    - そのときに参照する dir, file の path は、container内の構造で指定する必要がある。
    - container内では作業dir として `/workspace` が用意されている

1. 学習の設定ファイルの用意
    - specs directory に用意されたサンプルを参考に、学習の際に使用するパラメータを設定する。
    - 設定値は学習させる対象や、画像の大きさ、枚数等によって異なる。

1. トレーニング
    - jupyter-notebook 上でコマンドを実行するが、処理は docker container内で走る
    - 成果物はcontainer内で作成される。mountしている場所を出力directoryにする
    - 成果物は `tlt file` です

1. etlt作成
    - トレーニングで作成できた tlt ファイルを変換する。

1. engine作成
    - jetson内で生成する
    - etlt file を、推論を実行するデバイスにコピーする。
    - [peoplenet-on-tao-toolkit](https://bitbucket.org/latonaio/peoplenet-on-tao-toolkit/src/master/) などを参考にする
    - key は jupyter-note の一番上に指定する部分がある。
1. 動作確認
    - jetsonの上でdeepstream実行
    - [peoplenet-on-deepstream](https://bitbucket.org/latonaio/peoplenet-on-deepstream/src/master/) などを参考にする


## 参照

- [https://docs.nvidia.com/tao/tao-toolkit/text/running_in_cloud/running_tao_toolkit_on_aws.html](https://docs.nvidia.com/tao/tao-toolkit/text/running_in_cloud/running_tao_toolkit_on_aws.html)
