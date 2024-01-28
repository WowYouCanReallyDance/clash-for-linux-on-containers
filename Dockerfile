FROM debian:bullseye-slim AS debian-base
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list \
        && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
        && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
        && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
        && apt update \
        && apt upgrade -y \
        && apt install -y curl procps git \
        && apt autoremove -y

FROM debian-base AS clash-hup
RUN mkdir /root/vpn/ \
    && cd /root/vpn/ \
    && git clone https://mirror.ghproxy.com/https://github.com/wnlen/clash-for-linux.git \
    && cd clash-for-linux \
    && chmod +x ./start.sh ./shutdown.sh ./restart.sh \
    && cp ./start.sh ./start-on-container.sh \
    && sed -i -r 's#nohup \$Server_Dir/bin/clash-linux-(.*) -d \$Conf_Dir \&> \$Log_Dir/clash\.log \&#exec \$Server_Dir/bin/clash-linux-\1 -d \$Conf_Dir \&> \$Log_Dir/clash\.log#g' ./start-on-container.sh
WORKDIR /root/vpn/clash-for-linux/
COPY .env .env
## clash-for-linux web dashboard
EXPOSE 9090
## clash proxy port
EXPOSE 7890
ENTRYPOINT ["./start-on-container.sh"]
LABEL clash-for-linux="local"
