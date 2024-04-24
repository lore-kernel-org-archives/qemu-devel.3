Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWE-0004jC-0y; Wed, 24 Apr 2024 03:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWB-0004iI-K7
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXW9-000328-J2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bBBASsSTlfKriKNBK3BVHUtqP/w3USkuV9LG2z9XUg=;
 b=aKAKuFxSWsM42MnCQg/w5zulPAFowrmooaygekeCOLvV0AlAbB+8PlKJqLs16V2lP//ywv
 k+9lt2QJos7VrkOBG+TL77bxwJjggQU53goz3ZeX9XtBi7ASjPLmZ4EG4NuKEax0SPqgx0
 5kPxbM6rYIkSFGuVXQWJLxIQuDJ9W98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-feiO6QFdNHSwNVahJvhz9Q-1; Wed, 24 Apr 2024 03:58:08 -0400
X-MC-Unique: feiO6QFdNHSwNVahJvhz9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4184280021A;
 Wed, 24 Apr 2024 07:58:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C04944049;
 Wed, 24 Apr 2024 07:58:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/17] tests: Remove Ubuntu 20.04 container
Date: Wed, 24 Apr 2024 09:57:27 +0200
Message-ID: <20240424075735.248041-10-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since Ubuntu 22.04 has now been available for more than two years, we
can stop actively supporting the previous LTS version of Ubuntu now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240418101056.302103-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/ubuntu2004.docker | 157 ---------------------
 tests/lcitool/refresh                      |   1 -
 2 files changed, 158 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker

diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
deleted file mode 100644
index d3e212060c..0000000000
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ /dev/null
@@ -1,157 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all ubuntu-2004 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/ubuntu:20.04
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bison \
-                      bsdmainutils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      clang \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      g++ \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libaio-dev \
-                      libasan6 \
-                      libasound2-dev \
-                      libattr1-dev \
-                      libbrlapi-dev \
-                      libbz2-dev \
-                      libc6-dev \
-                      libcacard-dev \
-                      libcap-ng-dev \
-                      libcapstone-dev \
-                      libcmocka-dev \
-                      libcurl4-gnutls-dev \
-                      libdaxctl-dev \
-                      libdrm-dev \
-                      libepoxy-dev \
-                      libfdt-dev \
-                      libffi-dev \
-                      libfuse3-dev \
-                      libgbm-dev \
-                      libgcrypt20-dev \
-                      libglib2.0-dev \
-                      libglusterfs-dev \
-                      libgnutls28-dev \
-                      libgtk-3-dev \
-                      libibumad-dev \
-                      libibverbs-dev \
-                      libiscsi-dev \
-                      libjemalloc-dev \
-                      libjpeg-turbo8-dev \
-                      libjson-c-dev \
-                      liblttng-ust-dev \
-                      liblzo2-dev \
-                      libncursesw5-dev \
-                      libnfs-dev \
-                      libnuma-dev \
-                      libpam0g-dev \
-                      libpcre2-dev \
-                      libpixman-1-dev \
-                      libpmem-dev \
-                      libpng-dev \
-                      libpulse-dev \
-                      librbd-dev \
-                      librdmacm-dev \
-                      libsasl2-dev \
-                      libsdl2-dev \
-                      libsdl2-image-dev \
-                      libseccomp-dev \
-                      libselinux1-dev \
-                      libslirp-dev \
-                      libsnappy-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
-                      libspice-server-dev \
-                      libssh-dev \
-                      libsystemd-dev \
-                      libtasn1-6-dev \
-                      libubsan1 \
-                      libudev-dev \
-                      libusb-1.0-0-dev \
-                      libusbredirhost-dev \
-                      libvdeplug-dev \
-                      libvirglrenderer-dev \
-                      libvte-2.91-dev \
-                      libxen-dev \
-                      libzstd-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      multipath-tools \
-                      ncat \
-                      nettle-dev \
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
-                      systemtap-sdt-dev \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      xfslibs-dev \
-                      xorriso \
-                      zlib1g-dev \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
-
-RUN /usr/bin/pip3 install \
-                            meson==0.63.2 \
-                            tomli
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fe7692c500..692752a3df 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -130,7 +130,6 @@ try:
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
-    generate_dockerfile("ubuntu2004", "ubuntu-2004")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
     #
-- 
2.44.0


