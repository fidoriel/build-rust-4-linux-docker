FROM debian:bookworm

RUN mkdir /r4l
WORKDIR /r4l
RUN mkdir workdir/
RUN apt-get update
RUN apt-get install curl flex bison lld libssl-dev libelf-dev wget bash xz-utils libncurses5 -y
# RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.3/clang+llvm-16.0.3-aarch64-linux-gnu.tar.xz
# RUN tar -xf clang+llvm-16.0.3-aarch64-linux-gnu.tar.xz
# WORKDIR /r4l/clang+llvm-16.0.3-aarch64-linux-gnu
# RUN cp -r bin/* /usr/bin/ && \
#     cp -r include/* /usr/include/ && \
#     cp -r share/ /usr/bin/
# WORKDIR /r4l
# RUN rm -rf clang+llvm-16.0.3-aarch64-linux-gnu
RUN apt-get install -y make cmake git libncurses-dev gawk openssl dkms libudev-dev libpci-dev libiberty-dev autoconf llvm clang
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN echo 'rustup component add rust-src \n \
    rustup override set $(scripts/min-tool-version.sh rustc) \n \
    cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen \n \
    rustup component add rust-src \n \
    make LLVM=1 rustavailable' > /r4l/commands.sh
RUN chmod +x /r4l/commands.sh
RUN echo 'make LLVM=1 menuconfig \n \
    make LLVM=1 -j8' > /r4l/buildcmds.sh
RUN chmod +x /r4l/buildcmds.sh
