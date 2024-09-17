Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037EECAC594
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcfm-000196-8O; Tue, 17 Sep 2024 14:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcfb-0008Jr-Jw; Tue, 17 Sep 2024 14:11:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcfZ-0002kE-8t; Tue, 17 Sep 2024 14:11:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 230938FBE1;
 Tue, 17 Sep 2024 21:10:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7B8EC13E757;
 Tue, 17 Sep 2024 21:11:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 60/65] tests/docker: remove debian-armel-cross
Date: Tue, 17 Sep 2024 21:10:49 +0300
Message-Id: <20240917181054.633974-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.7-20240917211019@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240917211019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

As debian-11 transitions to LTS we are starting to have problems
building the image. While we could update to a later Debian building a
32 bit QEMU without modern floating point is niche host amongst the
few remaining 32 bit hosts we regularly build for. For now we still
have armhf-debian-cross-container which is currently built from the
more recent debian-12.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-2-alex.bennee@linaro.org>
(cherry picked from commit d0068b746a0a8cd4bb148527a0d199b130cd5288)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: force-remove tests/docker/dockerfiles/debian-armel-cross.docker)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d235cbea0..a0a213c324 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armel-cross
-
 armhf-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index d19d98cde0..619b4a5fa6 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armel-user:
-  extends: .cross_user_build_job
-  needs:
-    job: armel-debian-cross-container
-  variables:
-    IMAGE: debian-armel-cross
-
 cross-armhf-user:
   extends: .cross_user_build_job
   needs:
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
deleted file mode 100644
index 75342c09b0..0000000000
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ /dev/null
@@ -1,182 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch armv6l debian-11 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:11-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
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
-                      libglib2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
-                      llvm \
-                      locales \
-                      make \
-                      meson \
-                      mtools \
-                      ncat \
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
-                      sed \
-                      socat \
-                      sparse \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
-
-RUN /usr/bin/pip3 install tomli
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture armel && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      g++-arm-linux-gnueabi \
-                      gcc-arm-linux-gnueabi \
-                      libaio-dev:armel \
-                      libasan6:armel \
-                      libasound2-dev:armel \
-                      libattr1-dev:armel \
-                      libbpf-dev:armel \
-                      libbrlapi-dev:armel \
-                      libbz2-dev:armel \
-                      libc6-dev:armel \
-                      libcacard-dev:armel \
-                      libcap-ng-dev:armel \
-                      libcapstone-dev:armel \
-                      libcmocka-dev:armel \
-                      libcurl4-gnutls-dev:armel \
-                      libdaxctl-dev:armel \
-                      libdrm-dev:armel \
-                      libepoxy-dev:armel \
-                      libfdt-dev:armel \
-                      libffi-dev:armel \
-                      libfuse3-dev:armel \
-                      libgbm-dev:armel \
-                      libgcrypt20-dev:armel \
-                      libglib2.0-dev:armel \
-                      libglusterfs-dev:armel \
-                      libgnutls28-dev:armel \
-                      libgtk-3-dev:armel \
-                      libibumad-dev:armel \
-                      libibverbs-dev:armel \
-                      libiscsi-dev:armel \
-                      libjemalloc-dev:armel \
-                      libjpeg62-turbo-dev:armel \
-                      libjson-c-dev:armel \
-                      liblttng-ust-dev:armel \
-                      liblzo2-dev:armel \
-                      libncursesw5-dev:armel \
-                      libnfs-dev:armel \
-                      libnuma-dev:armel \
-                      libpam0g-dev:armel \
-                      libpipewire-0.3-dev:armel \
-                      libpixman-1-dev:armel \
-                      libpng-dev:armel \
-                      libpulse-dev:armel \
-                      librbd-dev:armel \
-                      librdmacm-dev:armel \
-                      libsasl2-dev:armel \
-                      libsdl2-dev:armel \
-                      libsdl2-image-dev:armel \
-                      libseccomp-dev:armel \
-                      libselinux1-dev:armel \
-                      libslirp-dev:armel \
-                      libsnappy-dev:armel \
-                      libspice-server-dev:armel \
-                      libssh-gcrypt-dev:armel \
-                      libsystemd-dev:armel \
-                      libtasn1-6-dev:armel \
-                      libubsan1:armel \
-                      libudev-dev:armel \
-                      liburing-dev:armel \
-                      libusb-1.0-0-dev:armel \
-                      libusbredirhost-dev:armel \
-                      libvdeplug-dev:armel \
-                      libvirglrenderer-dev:armel \
-                      libvte-2.91-dev:armel \
-                      libzstd-dev:armel \
-                      nettle-dev:armel \
-                      systemtap-sdt-dev:armel \
-                      xfslibs-dev:armel \
-                      zlib1g-dev:armel && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/arm-linux-gnueabi-gcc'\n\
-ar = '/usr/bin/arm-linux-gnueabi-gcc-ar'\n\
-strip = '/usr/bin/arm-linux-gnueabi-strip'\n\
-pkgconfig = '/usr/bin/arm-linux-gnueabi-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'arm'\n\
-cpu = 'arm'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-c++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-gcc
-
-ENV ABI "arm-linux-gnueabi"
-ENV MESON_OPTS "--cross-file=arm-linux-gnueabi"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
-ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 767fa312de..4e7c32e429 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -148,12 +148,6 @@ try:
                         trailer=cross_build("aarch64-linux-gnu-",
                                             "aarch64-softmmu,aarch64-linux-user"))
 
-    # migration to bookworm stalled: https://lists.debian.org/debian-arm/2023/09/msg00006.html
-    generate_dockerfile("debian-armel-cross", "debian-11",
-                        cross="armv6l",
-                        trailer=cross_build("arm-linux-gnueabi-",
-                                            "arm-softmmu,arm-linux-user,armeb-linux-user"))
-
     generate_dockerfile("debian-armhf-cross", "debian-12",
                         cross="armv7l",
                         trailer=cross_build("arm-linux-gnueabihf-",
-- 
2.39.5


