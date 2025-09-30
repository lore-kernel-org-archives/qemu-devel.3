Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84D1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cSc-0001TN-VW; Tue, 30 Sep 2025 11:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cS4-0000kx-AW
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRy-0004ZV-I4
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CaX57cEeF2SyhquHRg8jSrPCEqHxtUyDV28mRUQtGU=;
 b=bOgrAuYBw0/8rCdpl2cwi52IkjZNbi+5hdkXSxy2QztBiUd0BkDsNNEVeqdNX5bpBdrfhL
 Zxfq0vCw138UM51M+m7DJTYm/lvr+WwjTzCn3gu5yAMTY6f4+WPZ4NUvVstSAAE8SAN2Vt
 Mi5lSXo1PKL6DihLF141G41BCS5zXPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-xcTJztiCO1W8EiVX2TpxaA-1; Tue,
 30 Sep 2025 11:39:28 -0400
X-MC-Unique: xcTJztiCO1W8EiVX2TpxaA-1
X-Mimecast-MFC-AGG-ID: xcTJztiCO1W8EiVX2TpxaA_1759246766
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 196C71800294; Tue, 30 Sep 2025 15:39:26 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDEAA30003BA; Tue, 30 Sep 2025 15:39:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 16/23] tests/lcitool: update to debian13
Date: Tue, 30 Sep 2025 19:37:37 +0400
Message-ID: <20250930153746.573875-17-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

riscv64 is now a supported architecture.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250924120426.2158655-17-marcandre.lureau@redhat.com>
---
 .../dockerfiles/debian-amd64-cross.docker     |   9 +-
 .../dockerfiles/debian-arm64-cross.docker     |   9 +-
 .../dockerfiles/debian-armhf-cross.docker     |  12 +-
 .../dockerfiles/debian-i686-cross.docker      |  11 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   9 +-
 .../dockerfiles/debian-riscv64-cross.docker   | 106 +++++++++++++++++-
 .../dockerfiles/debian-s390x-cross.docker     |   9 +-
 tests/docker/dockerfiles/debian.docker        |   9 +-
 tests/lcitool/refresh                         |  21 ++--
 9 files changed, 149 insertions(+), 46 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index f3ad2205a7..08621879dd 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-x86-64-linux-gnu \
                       libaio-dev:amd64 \
-                      libasan6:amd64 \
+                      libasan8:amd64 \
                       libasound2-dev:amd64 \
                       libattr1-dev:amd64 \
                       libbpf-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 7d42227fa1..725cccbee1 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-aarch64-linux-gnu \
                       libaio-dev:arm64 \
-                      libasan6:arm64 \
+                      libasan8:arm64 \
                       libasound2-dev:arm64 \
                       libattr1-dev:arm64 \
                       libbpf-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 8ad4d2bebf..50f7e0e986 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-arm-linux-gnueabihf \
                       libaio-dev:armhf \
-                      libasan6:armhf \
+                      libasan8:armhf \
                       libasound2-dev:armhf \
                       libattr1-dev:armhf \
                       libbpf-dev:armhf \
@@ -107,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libgbm-dev:armhf \
                       libgcrypt20-dev:armhf \
                       libglib2.0-dev:armhf \
-                      libglusterfs-dev:armhf \
                       libgnutls28-dev:armhf \
                       libgtk-3-dev:armhf \
                       libgtk-vnc-2.0-dev:armhf \
@@ -127,7 +127,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpixman-1-dev:armhf \
                       libpng-dev:armhf \
                       libpulse-dev:armhf \
-                      librbd-dev:armhf \
                       librdmacm-dev:armhf \
                       libsasl2-dev:armhf \
                       libsdl2-dev:armhf \
@@ -152,7 +151,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvirglrenderer-dev:armhf \
                       libvte-2.91-dev:armhf \
                       libxdp-dev:armhf \
-                      libxen-dev:armhf \
                       libzstd-dev:armhf \
                       nettle-dev:armhf \
                       systemtap-sdt-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index e7e8d8e0f1..f53b77cb62 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch i686 debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch i686 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-i686-linux-gnu \
                       libaio-dev:i386 \
-                      libasan6:i386 \
+                      libasan8:i386 \
                       libasound2-dev:i386 \
                       libattr1-dev:i386 \
                       libbpf-dev:i386 \
@@ -107,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libgbm-dev:i386 \
                       libgcrypt20-dev:i386 \
                       libglib2.0-dev:i386 \
-                      libglusterfs-dev:i386 \
                       libgnutls28-dev:i386 \
                       libgtk-3-dev:i386 \
                       libgtk-vnc-2.0-dev:i386 \
@@ -127,7 +127,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpixman-1-dev:i386 \
                       libpng-dev:i386 \
                       libpulse-dev:i386 \
-                      librbd-dev:i386 \
                       librdmacm-dev:i386 \
                       libsasl2-dev:i386 \
                       libsdl2-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 97ef64d934..09de265c26 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-powerpc64le-linux-gnu \
                       libaio-dev:ppc64el \
-                      libasan6:ppc64el \
+                      libasan8:ppc64el \
                       libasound2-dev:ppc64el \
                       libattr1-dev:ppc64el \
                       libbpf-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 79ec37616d..e6c463eff7 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-13 qemu-minimal
+#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
@@ -13,25 +13,57 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
+                      bsdextrautils \
+                      bzip2 \
                       ca-certificates \
                       ccache \
+                      dbus \
+                      debianutils \
+                      diffutils \
+                      exuberant-ctags \
                       findutils \
                       flex \
                       gcc \
+                      gcovr \
+                      gettext \
                       git \
+                      hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
+                      llvm \
                       locales \
                       make \
+                      mtools \
+                      ncat \
                       ninja-build \
+                      openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
+                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
+                      python3-sphinx \
+                      python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
+                      python3-yaml \
+                      rpm2cpio \
+                      rustc \
                       sed \
-                      tar && \
+                      socat \
+                      sparse \
+                      swtpm \
+                      tar \
+                      tesseract-ocr \
+                      tesseract-ocr-eng \
+                      vulkan-tools \
+                      xorriso \
+                      zstd && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
@@ -56,11 +88,78 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-riscv64-linux-gnu \
+                      libaio-dev:riscv64 \
+                      libasan8:riscv64 \
+                      libasound2-dev:riscv64 \
+                      libattr1-dev:riscv64 \
+                      libbpf-dev:riscv64 \
+                      libbrlapi-dev:riscv64 \
+                      libbz2-dev:riscv64 \
                       libc6-dev:riscv64 \
+                      libcacard-dev:riscv64 \
+                      libcap-ng-dev:riscv64 \
+                      libcapstone-dev:riscv64 \
+                      libcbor-dev:riscv64 \
+                      libcmocka-dev:riscv64 \
+                      libcurl4-gnutls-dev:riscv64 \
+                      libdaxctl-dev:riscv64 \
+                      libdrm-dev:riscv64 \
+                      libepoxy-dev:riscv64 \
                       libfdt-dev:riscv64 \
                       libffi-dev:riscv64 \
+                      libfuse3-dev:riscv64 \
+                      libgbm-dev:riscv64 \
+                      libgcrypt20-dev:riscv64 \
                       libglib2.0-dev:riscv64 \
-                      libpixman-1-dev:riscv64 && \
+                      libglusterfs-dev:riscv64 \
+                      libgnutls28-dev:riscv64 \
+                      libgtk-3-dev:riscv64 \
+                      libgtk-vnc-2.0-dev:riscv64 \
+                      libibverbs-dev:riscv64 \
+                      libiscsi-dev:riscv64 \
+                      libjemalloc-dev:riscv64 \
+                      libjpeg62-turbo-dev:riscv64 \
+                      libjson-c-dev:riscv64 \
+                      liblttng-ust-dev:riscv64 \
+                      liblzo2-dev:riscv64 \
+                      libncursesw5-dev:riscv64 \
+                      libnfs-dev:riscv64 \
+                      libnuma-dev:riscv64 \
+                      libpam0g-dev:riscv64 \
+                      libpcre2-dev:riscv64 \
+                      libpipewire-0.3-dev:riscv64 \
+                      libpixman-1-dev:riscv64 \
+                      libpng-dev:riscv64 \
+                      libpulse-dev:riscv64 \
+                      librbd-dev:riscv64 \
+                      librdmacm-dev:riscv64 \
+                      libsasl2-dev:riscv64 \
+                      libsdl2-dev:riscv64 \
+                      libsdl2-image-dev:riscv64 \
+                      libseccomp-dev:riscv64 \
+                      libselinux1-dev:riscv64 \
+                      libslirp-dev:riscv64 \
+                      libsnappy-dev:riscv64 \
+                      libsndio-dev:riscv64 \
+                      libspice-protocol-dev:riscv64 \
+                      libspice-server-dev:riscv64 \
+                      libssh-dev:riscv64 \
+                      libstd-rust-dev:riscv64 \
+                      libsystemd-dev:riscv64 \
+                      libtasn1-6-dev:riscv64 \
+                      libubsan1:riscv64 \
+                      libudev-dev:riscv64 \
+                      liburing-dev:riscv64 \
+                      libusb-1.0-0-dev:riscv64 \
+                      libusbredirhost-dev:riscv64 \
+                      libvdeplug-dev:riscv64 \
+                      libvirglrenderer-dev:riscv64 \
+                      libvte-2.91-dev:riscv64 \
+                      libxdp-dev:riscv64 \
+                      libzstd-dev:riscv64 \
+                      nettle-dev:riscv64 \
+                      systemtap-sdt-dev:riscv64 \
+                      zlib1g-dev:riscv64 && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     mkdir -p /usr/local/share/meson/cross && \
@@ -82,6 +181,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
 
 ENV ABI "riscv64-linux-gnu"
 ENV MESON_OPTS "--cross-file=riscv64-linux-gnu"
+ENV RUST_TARGET "riscv64gc-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
 ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 3afe91494d..d7b2ca99ce 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch s390x debian-12 qemu
+#  $ lcitool dockerfile --layers all --cross-arch s390x debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       gcc-s390x-linux-gnu \
                       libaio-dev:s390x \
-                      libasan6:s390x \
+                      libasan8:s390x \
                       libasound2-dev:s390x \
                       libattr1-dev:s390x \
                       libbpf-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index f68fcc83a9..2696cf2167 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all debian-12 qemu
+#  $ lcitool dockerfile --layers all debian-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan6 \
+                      libasan8 \
                       libasound2-dev \
                       libattr1-dev \
                       libbpf-dev \
@@ -121,11 +121,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
+                      python3-tomli \
                       python3-venv \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-web \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6f98a91277..5c62cdde4a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -105,7 +105,7 @@ alpine_extras = [
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
-debian12_extras = [
+debian13_extras = [
     "# netmap/cscope/global\n",
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
     "  apt install -y --no-install-recommends \\\n",
@@ -175,8 +175,8 @@ try:
     generate_dockerfile("alpine", "alpine-321",
                         trailer="".join(alpine_extras))
     generate_dockerfile("centos9", "centos-stream-9")
-    generate_dockerfile("debian", "debian-12",
-                        trailer="".join(debian12_extras))
+    generate_dockerfile("debian", "debian-13",
+                        trailer="".join(debian13_extras))
     generate_dockerfile("fedora", "fedora-41")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
@@ -191,30 +191,32 @@ try:
     #
     # Cross compiling builds
     #
-    generate_dockerfile("debian-amd64-cross", "debian-12",
+    generate_dockerfile("debian-amd64-cross", "debian-13",
                         cross="x86_64",
                         trailer=cross_build("x86_64-linux-gnu-",
                                             "x86_64-softmmu,"
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-arm64-cross", "debian-12",
+    generate_dockerfile("debian-arm64-cross", "debian-13",
                         cross="aarch64",
                         trailer=cross_build("aarch64-linux-gnu-",
                                             "aarch64-softmmu,aarch64-linux-user"))
 
-    generate_dockerfile("debian-armhf-cross", "debian-12",
+    generate_dockerfile("debian-armhf-cross", "debian-13",
                         cross="armv7l",
                         trailer=cross_build("arm-linux-gnueabihf-",
                                             "arm-softmmu,arm-linux-user"))
 
-    generate_dockerfile("debian-i686-cross", "debian-12",
+    generate_dockerfile("debian-i686-cross", "debian-13",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
                                             "x86_64-softmmu,"
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
+    # mips no longer supported in debian-13
+    # https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed
     generate_dockerfile("debian-mips64el-cross", "debian-12",
                         cross="mips64el",
                         trailer=cross_build("mips64el-linux-gnuabi64-",
@@ -225,7 +227,7 @@ try:
                         trailer=cross_build("mipsel-linux-gnu-",
                                             "mipsel-softmmu,mipsel-linux-user"))
 
-    generate_dockerfile("debian-ppc64el-cross", "debian-12",
+    generate_dockerfile("debian-ppc64el-cross", "debian-13",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
                                             "ppc64-softmmu,ppc64-linux-user"))
@@ -233,12 +235,11 @@ try:
     # while not yet a release architecture the packages are still
     # build while part of testing
     generate_dockerfile("debian-riscv64-cross", "debian-13",
-                        project="qemu-minimal",
                         cross="riscv64",
                         trailer=cross_build("riscv64-linux-gnu-",
                                             "riscv64-softmmu,riscv64-linux-user"))
 
-    generate_dockerfile("debian-s390x-cross", "debian-12",
+    generate_dockerfile("debian-s390x-cross", "debian-13",
                         cross="s390x",
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
-- 
2.51.0


