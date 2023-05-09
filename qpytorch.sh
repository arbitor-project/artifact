python -m venv pytorch-cifar/venv
source pytorch-cifar/venv/bin/activate
pip install qtorch torch==1.8.1 torchvision==0.9.1 --quiet
python pytorch-cifar/main.py