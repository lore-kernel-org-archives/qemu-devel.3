Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515C6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmWb-0007FX-2s; Wed, 20 May 2026 15:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWW-0007Da-3r
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWT-0001jQ-1a
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso29571725e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305042; x=1779909842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E4CfQXJoQyoLDqw5WN9SuDrrk8uGV9nwZb+vJpsJUR0=;
 b=QsKp+JpO4NydDwH5lBO4Lj39vPuqy6nu1dnK4I7X3HC9oahyF+u52nEvP/uzKO5CyJ
 /cGnVm+nhyuHXOt2+4+0RQDG9FzCQ+z2/+AlxhvXPYCAlwt65ozXyLYji6Brj2P4hWCO
 SxBPGpvrZIgVuur0yOk9x+R2ykjnjff8kXcyGFh56pjVVikjL4ooph2e6KQJzH9yfluV
 i7e0lAodCb2uqN0D51qB3Up0r7PwrDUopBuk2REHjQ0YDhYCVFaXUiK6CUO2OmfczSFn
 TKYPXIn0MCIYmDCkI6flvDTNQuTT+sE0D86sSAPo/cDch9DAil8SciDd9W17XukEvjlG
 W/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305042; x=1779909842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E4CfQXJoQyoLDqw5WN9SuDrrk8uGV9nwZb+vJpsJUR0=;
 b=I7lwQ42n5RE4JOEEJQgl24MO33x0aLDlqJh2NLYZJyAcxamNMFOdUjHOjDqLJK34Mn
 qJFrbDfZUJl+cZQUB/VNcVd8TjLHN4u7hdPOIy55SBRz0etOMX4B4Utl0R4xbKm4Q6P8
 ZL2G86AtC8b75UpvWM0SVM1AftOAOJsRSMjxR6Y8gRWbn0OtYjkVmRIOkzTIBKdSlGR5
 rrGaVBa1wQJuftP1eHTAvcLiCrvji1i1fG17KyyLUeORryXP9UN/fGnrG1bg7WQQ+qwk
 HQ7waapVxiLBZ4tm3lm71qX3sGRNk5RUB/FjJbSrO7wJM4vt6SR7fSEMyG0tFM1XvQ5H
 W5eg==
X-Gm-Message-State: AOJu0Yznx6mowWfbCxmeRdp3hQqJBC3671nYEq4c/zr+kY0GD7njLg5T
 j8QEWlmL+CvDTdho1fLGmG+xyntTGkNgeEjNT4BtjeVe/Oi2rHVwbZQQyJVPsWYnPLR603Cc2Xj
 rrhabbmI=
X-Gm-Gg: Acq92OF4i95PGmKI6Gw/PR6gr9/OxYDJpmroYpdGRv5l0QZsdfzDURKLE1SyDIDsfup
 CDCDwfWRahRRVSvDDXsYDBYJVGsQEddFoKH4swWJVzcsSfZUUhtmFPjKh55Z6i2++iFn6ZKeBoc
 +Z8Cc+W/rYrwKw4S5FzSlCKh+cTNvIcf1OhnSgjAQ4hwpEIXNAHtOamyWF1m1E90JyyqGw7sppy
 8n1wh5r8z0OSM/jISwZZaX44xpocIhBV5fofYry6/LwcK5KDBTfdBNlQUxNRdp5imsVXR6vgURH
 8sVhPcNjvVY0xDoiSTh8uUrRfUOL4Mkh4CNhVX9NXAJdxQEl0iyrWYOmtPeEa2uQIyQFQohiH+p
 RsxR2odPHOQ4K/zUNROv7G7lPZrjtd5QQHSswIhFy3oNWRzDzsHXBnyh4abFpdUyWlc2467cC3f
 AQGlYVwoJ7f13FiRbLiSEHCxIGs/oAdYKBv5fuXJGcNLZ35j2Whq03klFx6KnlH6mvvjvAUoUO
X-Received: by 2002:a05:600c:4fc5:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48fe5fd4b5cmr383860295e9.4.1779305042026; 
 Wed, 20 May 2026 12:24:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7543asm138508445e9.28.2026.05.20.12.24.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] buildsys: Remove MIPS cross containers
Date: Wed, 20 May 2026 21:23:08 +0200
Message-ID: <20260520192338.40036-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As mentioned in commit 269ffaabc84 ("buildsys: Remove support
for 32-bit MIPS hosts"), Debian 13 "Trixie" removed support for
MIPS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260511135312.38705-2-philmd@linaro.org>
---
 configure                                     |   1 -
 tests/lcitool/refresh                         |  12 --
 .../dockerfiles/debian-mips64el-cross.docker  | 186 ------------------
 .../dockerfiles/debian-mipsel-cross.docker    | 186 ------------------
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/containers.yml                   |   1 -
 .gitlab-ci.d/crossbuilds.yml                  |  22 ---
 tests/docker/Makefile.include                 |   1 -
 8 files changed, 415 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/configure b/configure
index eea90306728..b6dd797de5b 100755
--- a/configure
+++ b/configure
@@ -1525,7 +1525,6 @@ probe_target_compiler() {
         aarch64_be:aarch64 | \
         armeb:arm | \
         i386:x86_64 | \
-        mips*:mips64 | \
         ppc*:ppc64 | \
         sparc:sparc64 | \
         "$cpu:$cpu")
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index a736f7f0ae6..365435b0d70 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -265,18 +265,6 @@ try:
                         trailer=cross_build("i686-linux-gnu-",
                                             "i386-softmmu,i386-linux-user"))
 
-    # mips no longer supported in debian-13
-    # https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed
-    generate_dockerfile("debian-mips64el-cross", "debian-12",
-                        cross="mips64el",
-                        trailer=cross_build("mips64el-linux-gnuabi64-",
-                                            "mips64el-softmmu,mips64el-linux-user"))
-
-    generate_dockerfile("debian-mipsel-cross", "debian-12",
-                        cross="mipsel",
-                        trailer=cross_build("mipsel-linux-gnu-",
-                                            "mipsel-softmmu,mipsel-linux-user"))
-
     generate_dockerfile("debian-ppc64el-cross", "debian-13",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
deleted file mode 100644
index fc83fc0c00b..00000000000
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ /dev/null
@@ -1,186 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:12-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bindgen \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      coreutils \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libclang-rt-dev \
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-web \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
-ENV LANG="en_US.UTF-8"
-ENV MAKE="/usr/bin/make"
-ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture mips64el && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-mips64el-linux-gnuabi64 \
-                      libaio-dev:mips64el \
-                      libasound2-dev:mips64el \
-                      libattr1-dev:mips64el \
-                      libbpf-dev:mips64el \
-                      libbrlapi-dev:mips64el \
-                      libbz2-dev:mips64el \
-                      libc6-dev:mips64el \
-                      libcacard-dev:mips64el \
-                      libcap-ng-dev:mips64el \
-                      libcapstone-dev:mips64el \
-                      libcbor-dev:mips64el \
-                      libcmocka-dev:mips64el \
-                      libcurl4-gnutls-dev:mips64el \
-                      libdaxctl-dev:mips64el \
-                      libdrm-dev:mips64el \
-                      libepoxy-dev:mips64el \
-                      libfdt-dev:mips64el \
-                      libffi-dev:mips64el \
-                      libfuse3-dev:mips64el \
-                      libgbm-dev:mips64el \
-                      libgcrypt20-dev:mips64el \
-                      libglib2.0-dev:mips64el \
-                      libgnutls28-dev:mips64el \
-                      libgtk-3-dev:mips64el \
-                      libgtk-vnc-2.0-dev:mips64el \
-                      libibverbs-dev:mips64el \
-                      libiscsi-dev:mips64el \
-                      libjemalloc-dev:mips64el \
-                      libjpeg62-turbo-dev:mips64el \
-                      libjson-c-dev:mips64el \
-                      liblttng-ust-dev:mips64el \
-                      liblzo2-dev:mips64el \
-                      libncursesw5-dev:mips64el \
-                      libnfs-dev:mips64el \
-                      libnuma-dev:mips64el \
-                      libpam0g-dev:mips64el \
-                      libpcre2-dev:mips64el \
-                      libpipewire-0.3-dev:mips64el \
-                      libpixman-1-dev:mips64el \
-                      libpng-dev:mips64el \
-                      libpulse-dev:mips64el \
-                      librbd-dev:mips64el \
-                      librdmacm-dev:mips64el \
-                      libsasl2-dev:mips64el \
-                      libsdl2-dev:mips64el \
-                      libsdl2-image-dev:mips64el \
-                      libseccomp-dev:mips64el \
-                      libselinux1-dev:mips64el \
-                      libslirp-dev:mips64el \
-                      libsnappy-dev:mips64el \
-                      libsndio-dev:mips64el \
-                      libspice-protocol-dev:mips64el \
-                      libspice-server-dev:mips64el \
-                      libssh-dev:mips64el \
-                      libstd-rust-dev:mips64el \
-                      libsystemd-dev:mips64el \
-                      libtasn1-6-dev:mips64el \
-                      libudev-dev:mips64el \
-                      liburing-dev:mips64el \
-                      libusb-1.0-0-dev:mips64el \
-                      libusbredirhost-dev:mips64el \
-                      libvdeplug-dev:mips64el \
-                      libvirglrenderer-dev:mips64el \
-                      libvte-2.91-dev:mips64el \
-                      libxdp-dev:mips64el \
-                      libzstd-dev:mips64el \
-                      nettle-dev:mips64el \
-                      systemtap-sdt-dev:mips64el \
-                      zlib1g-dev:mips64el && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/mips64el-linux-gnuabi64-gcc'\n\
-ar = '/usr/bin/mips64el-linux-gnuabi64-gcc-ar'\n\
-strip = '/usr/bin/mips64el-linux-gnuabi64-strip'\n\
-pkgconfig = '/usr/bin/mips64el-linux-gnuabi64-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'mips64'\n\
-cpu = 'mips64el'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-gcc
-
-ENV ABI="mips64el-linux-gnuabi64"
-ENV MESON_OPTS="--cross-file=mips64el-linux-gnuabi64"
-ENV RUST_TARGET="mips64el-unknown-linux-gnuabi64"
-ENV QEMU_CONFIGURE_OPTS=--cross-prefix=mips64el-linux-gnuabi64-
-ENV DEF_TARGET_LIST=mips64el-softmmu,mips64el-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-
-ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
deleted file mode 100644
index 5f105b1d687..00000000000
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ /dev/null
@@ -1,186 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-12 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:12-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bindgen \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      coreutils \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libclang-rt-dev \
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-web \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
-ENV LANG="en_US.UTF-8"
-ENV MAKE="/usr/bin/make"
-ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture mipsel && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-mipsel-linux-gnu \
-                      libaio-dev:mipsel \
-                      libasound2-dev:mipsel \
-                      libattr1-dev:mipsel \
-                      libbpf-dev:mipsel \
-                      libbrlapi-dev:mipsel \
-                      libbz2-dev:mipsel \
-                      libc6-dev:mipsel \
-                      libcacard-dev:mipsel \
-                      libcap-ng-dev:mipsel \
-                      libcapstone-dev:mipsel \
-                      libcbor-dev:mipsel \
-                      libcmocka-dev:mipsel \
-                      libcurl4-gnutls-dev:mipsel \
-                      libdaxctl-dev:mipsel \
-                      libdrm-dev:mipsel \
-                      libepoxy-dev:mipsel \
-                      libfdt-dev:mipsel \
-                      libffi-dev:mipsel \
-                      libfuse3-dev:mipsel \
-                      libgbm-dev:mipsel \
-                      libgcrypt20-dev:mipsel \
-                      libglib2.0-dev:mipsel \
-                      libgnutls28-dev:mipsel \
-                      libgtk-3-dev:mipsel \
-                      libgtk-vnc-2.0-dev:mipsel \
-                      libibverbs-dev:mipsel \
-                      libiscsi-dev:mipsel \
-                      libjemalloc-dev:mipsel \
-                      libjpeg62-turbo-dev:mipsel \
-                      libjson-c-dev:mipsel \
-                      liblttng-ust-dev:mipsel \
-                      liblzo2-dev:mipsel \
-                      libncursesw5-dev:mipsel \
-                      libnfs-dev:mipsel \
-                      libnuma-dev:mipsel \
-                      libpam0g-dev:mipsel \
-                      libpcre2-dev:mipsel \
-                      libpipewire-0.3-dev:mipsel \
-                      libpixman-1-dev:mipsel \
-                      libpng-dev:mipsel \
-                      libpulse-dev:mipsel \
-                      librbd-dev:mipsel \
-                      librdmacm-dev:mipsel \
-                      libsasl2-dev:mipsel \
-                      libsdl2-dev:mipsel \
-                      libsdl2-image-dev:mipsel \
-                      libseccomp-dev:mipsel \
-                      libselinux1-dev:mipsel \
-                      libslirp-dev:mipsel \
-                      libsnappy-dev:mipsel \
-                      libsndio-dev:mipsel \
-                      libspice-protocol-dev:mipsel \
-                      libspice-server-dev:mipsel \
-                      libssh-dev:mipsel \
-                      libstd-rust-dev:mipsel \
-                      libsystemd-dev:mipsel \
-                      libtasn1-6-dev:mipsel \
-                      libudev-dev:mipsel \
-                      liburing-dev:mipsel \
-                      libusb-1.0-0-dev:mipsel \
-                      libusbredirhost-dev:mipsel \
-                      libvdeplug-dev:mipsel \
-                      libvirglrenderer-dev:mipsel \
-                      libvte-2.91-dev:mipsel \
-                      libxdp-dev:mipsel \
-                      libzstd-dev:mipsel \
-                      nettle-dev:mipsel \
-                      systemtap-sdt-dev:mipsel \
-                      zlib1g-dev:mipsel && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/mipsel-linux-gnu-gcc'\n\
-ar = '/usr/bin/mipsel-linux-gnu-gcc-ar'\n\
-strip = '/usr/bin/mipsel-linux-gnu-strip'\n\
-pkgconfig = '/usr/bin/mipsel-linux-gnu-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'mips'\n\
-cpu = 'mipsel'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
-
-ENV ABI="mipsel-linux-gnu"
-ENV MESON_OPTS="--cross-file=mipsel-linux-gnu"
-ENV RUST_TARGET="mipsel-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS=--cross-prefix=mipsel-linux-gnu-
-ENV DEF_TARGET_LIST=mipsel-softmmu,mipsel-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-
-ENV ENABLE_RUST=1
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 92a7f1c1b47..ab06083d754 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -28,12 +28,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-mips64el-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips64el-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index c8b8e44ad86..515e7382f26 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -48,7 +48,6 @@ weekly-container-builds:
     - arm64-debian-cross-container
     - hexagon-cross-container
     - loongarch-debian-cross-container
-    - mips64el-debian-cross-container
     - ppc64el-debian-cross-container
     - riscv64-debian-cross-container
     - s390x-debian-cross-container
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index cf977dfefb1..eaeeb533cee 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -23,20 +23,6 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
-cross-mips64el-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-
-cross-mips64el-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-
 cross-ppc64el-system:
   extends: .cross_system_build_job
   needs:
@@ -95,14 +81,6 @@ cross-s390x-kvm-only:
     IMAGE: debian-s390x-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --enable-trace-backends=ftrace
 
-cross-mips64el-kvm-only:
-  extends: .cross_accel_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-    EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
-
 cross-win64-system:
   extends: .cross_system_build_job
   needs:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index df14538c0f5..4725c39807b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -94,7 +94,6 @@ endif
 
 # For non-x86 hosts not all cross-compilers have been packaged
 ifneq ($(HOST_ARCH),x86_64)
-DOCKER_PARTIAL_IMAGES += debian-mipsel-cross debian-mips64el-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 DOCKER_PARTIAL_IMAGES += debian-s390x-cross
 DOCKER_PARTIAL_IMAGES += fedora
-- 
2.53.0


