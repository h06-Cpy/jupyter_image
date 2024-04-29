# Custom Jupyter Docker image with CUDA
The base image is nvidia/cuda:11.8.0-devel-ubuntu22.04

You can modify the base in the Dockerfile.base2

## how to build
1. Clone this and go to the cloned jupyter_image folder
```bash
git clone https://github.com/h06-Cpy/jupyter_image.git
cd jupyter_image
```

2. Build the foundation image
```bash
docker build -t <image-name>:<tag> -f Dockerfile.foundation2 .
```
3. Build the base image
```bash
docker build -t <image-name>:<tag> -f Dockerfile.base2 .
```
4. Let's run!
```bash
docker run -it --rm -p 127.0.0.1:8888:8888 -v <volume-name>:<mount-path> <image-name>:<tag> /bin/bash -c "jupyter lab --allow-root"
```


> P.S.   
 In the _old_ fodler, you can use the jupyter with non-privileged user named Hopper.   
but you may have permission troubles when you want to mount volumes.