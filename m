Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA353C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wf5-00050A-9y; Fri, 17 May 2024 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wf1-0004uh-Rr
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wey-0006Gq-Qw
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrjtfDPTV+udm0MSvX0p79l1zRrUeds4SAd05a5Opsk=;
 b=DF6Ogy6PfoG8foOFx8uu7EhZ3fNM4OthT5mn947tSGTNGf1nmIyYjzKUrXZZNWFC1zJhV6
 JgOel29tl+pYjhnzw3RZta69PcKz+DrQtTxxcVZiyHJI+nFoOlM9f8HCiNrYWKSAy4f7lV
 ag6eY321CaF2gP7E2icwuweKX1cXc2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-0asH8GBNPUOUlw80hITA0g-1; Fri, 17 May 2024 08:26:01 -0400
X-MC-Unique: 0asH8GBNPUOUlw80hITA0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA4B812296;
 Fri, 17 May 2024 12:26:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34FA01050174;
 Fri, 17 May 2024 12:25:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/6] tests/docker/dockerfiles: Update container files with
 "lcitool-refresh"
Date: Fri, 17 May 2024 14:25:51 +0200
Message-ID: <20240517122552.584215-6-thuth@redhat.com>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
References: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

Run "make lcitool-refresh" after the previous changes to the
lcitool files. This removes the g++ and xfslibs-dev packages
from the dockerfiles (except for the fedora-win64-cross dockerfile
where we keep the C++ compiler).

Message-ID: <20240516084059.511463-6-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker                | 4 ----
 tests/docker/dockerfiles/centos9.docker               | 4 ----
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ----
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ----
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ----
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ---
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian.docker                | 4 ----
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 +-
 tests/docker/dockerfiles/fedora.docker                | 4 ----
 tests/docker/dockerfiles/opensuse-leap.docker         | 4 ----
 tests/docker/dockerfiles/ubuntu2204.docker            | 4 ----
 17 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index cd9d7af1ce..554464f31e 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -32,7 +32,6 @@ RUN apk update && \
         findutils \
         flex \
         fuse3-dev \
-        g++ \
         gcc \
         gcovr \
         gettext \
@@ -110,7 +109,6 @@ RUN apk update && \
         vte3-dev \
         which \
         xen-dev \
-        xfsprogs-dev \
         xorriso \
         zlib-dev \
         zlib-static \
@@ -119,10 +117,8 @@ RUN apk update && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     apk list --installed | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 6cf47ce786..0256865b9e 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -34,7 +34,6 @@ RUN dnf distro-sync -y && \
         flex \
         fuse3-devel \
         gcc \
-        gcc-c++ \
         gettext \
         git \
         glib2-devel \
@@ -115,7 +114,6 @@ RUN dnf distro-sync -y && \
         util-linux \
         vte291-devel \
         which \
-        xfsprogs-devel \
         xorriso \
         zlib-devel \
         zlib-static \
@@ -125,10 +123,8 @@ RUN dnf distro-sync -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index d0b0e9778e..f8c61d1191 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -79,7 +79,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-x86-64-linux-gnu \
                       gcc-x86-64-linux-gnu \
                       libaio-dev:amd64 \
                       libasan6:amd64 \
@@ -149,7 +148,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:amd64 \
                       nettle-dev:amd64 \
                       systemtap-sdt-dev:amd64 \
-                      xfslibs-dev:amd64 \
                       zlib1g-dev:amd64 && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -167,9 +165,7 @@ cpu = 'x86_64'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-gcc
 
 ENV ABI "x86_64-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 8cb225740e..6510872279 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -79,7 +79,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-aarch64-linux-gnu \
                       gcc-aarch64-linux-gnu \
                       libaio-dev:arm64 \
                       libasan6:arm64 \
@@ -148,7 +147,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:arm64 \
                       nettle-dev:arm64 \
                       systemtap-sdt-dev:arm64 \
-                      xfslibs-dev:arm64 \
                       zlib1g-dev:arm64 && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -166,9 +164,7 @@ cpu = 'aarch64'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-gcc
 
 ENV ABI "aarch64-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index e6f37418ed..f227d42987 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -82,7 +82,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-arm-linux-gnueabi \
                       gcc-arm-linux-gnueabi \
                       libaio-dev:armel \
                       libasan6:armel \
@@ -149,7 +148,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:armel \
                       nettle-dev:armel \
                       systemtap-sdt-dev:armel \
-                      xfslibs-dev:armel \
                       zlib1g-dev:armel && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -167,9 +165,7 @@ cpu = 'arm'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-gcc
 
 ENV ABI "arm-linux-gnueabi"
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 407a014f57..58bdf07223 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -79,7 +79,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-arm-linux-gnueabihf \
                       gcc-arm-linux-gnueabihf \
                       libaio-dev:armhf \
                       libasan6:armhf \
@@ -148,7 +147,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:armhf \
                       nettle-dev:armhf \
                       systemtap-sdt-dev:armhf \
-                      xfslibs-dev:armhf \
                       zlib1g-dev:armhf && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -166,9 +164,7 @@ cpu = 'armhf'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-gcc
 
 ENV ABI "arm-linux-gnueabihf"
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index bdc9566b67..9f4102be8f 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -82,7 +82,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-i686-linux-gnu \
                       gcc-i686-linux-gnu \
                       libaio-dev:i386 \
                       libasan6:i386 \
@@ -149,7 +148,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:i386 \
                       nettle-dev:i386 \
                       systemtap-sdt-dev:i386 \
-                      xfslibs-dev:i386 \
                       zlib1g-dev:i386 && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -167,9 +165,7 @@ cpu = 'i686'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-gcc
 
 ENV ABI "i686-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 4d995d0b12..c861c3bd5b 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -82,7 +82,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-mips64el-linux-gnuabi64 \
                       gcc-mips64el-linux-gnuabi64 \
                       libaio-dev:mips64el \
                       libasound2-dev:mips64el \
@@ -147,7 +146,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:mips64el \
                       nettle-dev:mips64el \
                       systemtap-sdt-dev:mips64el \
-                      xfslibs-dev:mips64el \
                       zlib1g-dev:mips64el && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -165,9 +163,7 @@ cpu = 'mips64el'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-gcc
 
 ENV ABI "mips64el-linux-gnuabi64"
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 0cf803bda5..fe9415395e 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -82,7 +82,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-mipsel-linux-gnu \
                       gcc-mipsel-linux-gnu \
                       libaio-dev:mipsel \
                       libasound2-dev:mipsel \
@@ -147,7 +146,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:mipsel \
                       nettle-dev:mipsel \
                       systemtap-sdt-dev:mipsel \
-                      xfslibs-dev:mipsel \
                       zlib1g-dev:mipsel && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -165,9 +163,7 @@ cpu = 'mipsel'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
 
 ENV ABI "mipsel-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 6180ec08c3..35c8ff0864 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -79,7 +79,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-powerpc64le-linux-gnu \
                       gcc-powerpc64le-linux-gnu \
                       libaio-dev:ppc64el \
                       libasan6:ppc64el \
@@ -147,7 +146,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:ppc64el \
                       nettle-dev:ppc64el \
                       systemtap-sdt-dev:ppc64el \
-                      xfslibs-dev:ppc64el \
                       zlib1g-dev:ppc64el && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -165,9 +163,7 @@ cpu = 'powerpc64le'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-gcc
 
 ENV ABI "powerpc64le-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 591572ae94..4d8ca83cb3 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -51,7 +51,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-riscv64-linux-gnu \
                       gcc-riscv64-linux-gnu \
                       libc6-dev:riscv64 \
                       libfdt-dev:riscv64 \
@@ -74,9 +73,7 @@ cpu = 'riscv64'\n\
 endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-gcc
 
 ENV ABI "riscv64-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 90c8d3c7b8..bef9dff17a 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -79,7 +79,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
     eatmydata apt-get install --no-install-recommends -y \
-                      g++-s390x-linux-gnu \
                       gcc-s390x-linux-gnu \
                       libaio-dev:s390x \
                       libasan6:s390x \
@@ -146,7 +145,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libzstd-dev:s390x \
                       nettle-dev:s390x \
                       systemtap-sdt-dev:s390x \
-                      xfslibs-dev:s390x \
                       zlib1g-dev:s390x && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
@@ -164,9 +162,7 @@ cpu = 's390x'\n\
 endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-gcc
 
 ENV ABI "s390x-linux-gnu"
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 5722482e4c..63d7aac616 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -25,7 +25,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
-                      g++ \
                       gcc \
                       gcovr \
                       gettext \
@@ -129,7 +128,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
-                      xfslibs-dev \
                       xorriso \
                       zlib1g-dev \
                       zstd && \
@@ -140,10 +138,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index d1a480fa71..0f78711876 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-38 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-38 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 7e6ab0308a..098c894d10 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -41,7 +41,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                flex \
                fuse3-devel \
                gcc \
-               gcc-c++ \
                gcovr \
                gettext \
                git \
@@ -130,7 +129,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                vte291-devel \
                which \
                xen-devel \
-               xfsprogs-devel \
                xorriso \
                zlib-devel \
                zlib-static \
@@ -140,10 +138,8 @@ exec "$@"\n' > /usr/bin/nosync && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index c4055bdd10..836f531ac1 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -26,7 +26,6 @@ RUN zypper update -y && \
            flex \
            fuse3-devel \
            gcc \
-           gcc-c++ \
            gcovr \
            gettext-runtime \
            git \
@@ -113,7 +112,6 @@ RUN zypper update -y && \
            vte-devel \
            which \
            xen-devel \
-           xfsprogs-devel \
            xorriso \
            zlib-devel \
            zlib-devel-static \
@@ -122,10 +120,8 @@ RUN zypper update -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 RUN /usr/bin/pip3.11 install \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index b8e78331db..febd25b320 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -25,7 +25,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
-                      g++ \
                       gcc \
                       gcovr \
                       gettext \
@@ -129,7 +128,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
-                      xfslibs-dev \
                       xorriso \
                       zlib1g-dev \
                       zstd && \
@@ -140,10 +138,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-- 
2.45.0


