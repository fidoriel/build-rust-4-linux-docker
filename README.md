# build-rust-4-linux-docker
A Docker Container to build linux with Rust4Linux

## How it Works
cd into dir kernel folder on host.

Build the Docker file. You may need to match the folder name in the volume
``docker buildx build --platform linux/amd64 -t buildlinux . && docker run --platform linux/amd64 -it -v $(pwd)/linux:/r4l/workdir buildlinux bash``

or pull from docker hub
``docker run --platform linux/amd64 -it -v $(pwd)/linux:/r4l/workdir fidoriel/build-rust-4-linux-docker bash``

install all dependencies for THIS kernel version. This needs to be done once
``../commands.sh``
configure and build kernel
``../buildcmds.sh``

as one cms:
``cd /r4l/workdir && bash /r4l/commands.sh && bash /r4l/buildcmds.sh``

PLEASE NOTE: rust ARM64 Support is implemented since 01/2023 and therefor may not merged into torvalds/linux. At time of writing this, this is only in rust-for-linux/linux working
check your kernel version with: cat .config | grep "RUST"
