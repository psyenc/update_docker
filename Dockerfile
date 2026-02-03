# Base Image
FROM fedora:latest

# Setup home directory
RUN mkdir -p /bot /tgenc
WORKDIR /bot

# Set non interactive shell and timezone
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Havana \
    TERM=xterm

# Define ARG for ffmpeg build
#ARG FFMPEG_BUILD="QuickFatHedgehog/FFmpeg-Builds-SVT-AV1-HDR"
ARG FFMPEG_BUILD="BtbN/FFmpeg-Builds"
#ARG FFMPEG_BUILD="Uranite/FFmpeg-Builds-SVT-AV1-PSY"
#ARG FFMPEG_BUILD="nekotrix/FFmpeg-Builds-SVT-AV1-Essential"

# Install Dependencies
RUN dnf -qq -y upgrade --refresh && \
    dnf -qq -y install aria2 bash curl gcc git jq mediainfo procps-ng psmisc pv python3-devel python3-pip qbittorrent-nox wget xz zstd && \
    dnf clean all

# Install latest ffmpeg
RUN wget -q "https://github.com/${FFMPEG_BUILD}/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz" && \
    tar -xvf ffmpeg-master-latest-linux64-gpl.tar.xz && \
    cp ffmpeg-master-latest-linux64-gpl/bin/* /usr/local/bin/ && \
    rm -rf ffmpeg-master-latest-linux64-gpl*

# Install ab-av1
RUN wget -q https://github.com/alexheretic/ab-av1/releases/download/v0.10.4/ab-av1-v0.10.4-x86_64-unknown-linux-musl.tar.zst && \
    tar -xvf ab-av1-v0.10.4-x86_64-unknown-linux-musl.tar.zst && \
    install ab-av1 /usr/local/bin/ && \
    rm -rf ab-av1*

# Copy files from repo to home directory
COPY . .

# Install python3 requirements
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Create new user and group with a specific UID and GID
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} botgroup && \
    useradd -u ${USER_ID} -g botgroup -ms /bin/bash bot

# Set permissions for the bot user to access /bot
RUN chown -R bot:botgroup /bot

# Add user to sudoers file without password
RUN echo "bot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user
USER bot

# Cleanup unnecessary files
RUN rm -rf .git* fonts scripts .env* Dockerfile License *.md requirements.txt srun.sh *.py
