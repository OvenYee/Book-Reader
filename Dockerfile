FROM ubuntu:22.04

ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV FLUTTER_SDK_ROOT=/usr/lib/flutter
ENV FLUTTER_SDK_VERSION=stable

RUN apt update && \
    apt install -y curl git unzip xz-utils zip wget openjdk-17-jdk libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev mesa-utils android-tools-adb && \
    rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b ${FLUTTER_SDK_VERSION} /usr/lib/flutter
ENV PATH="${FLUTTER_SDK_ROOT}/bin:${PATH}"

# Install Android SDK
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -O commandlinetools.zip "https://dl.google.com/android/repository/commandlinetools-linux-12266719_latest.zip" && \
    unzip commandlinetools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm commandlinetools.zip
ENV PATH="${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${PATH}/platform-tools:${PATH}"

RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-36" "build-tools;35.0.0"

RUN flutter config --android-sdk ${ANDROID_SDK_ROOT} && \
    flutter precache --android $$ \
    flutter --disable-analytics

WORKDIR /workspace