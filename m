Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06961CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cSa-00017F-RJ; Tue, 30 Sep 2025 11:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRz-0000ik-1D
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRu-0004Ww-SL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8fQcUQRD0wO2frTCD4N3m7uQx7Ksq8MHEknC/jkPBI=;
 b=QhTmhG5dguKKGdEh/Ji5N86ftZWii6dWnDetb+Q9HrrhPyRefsrTzAdCYv/G6myW6LiymL
 2+LqPtFfc81p2boMesaxNPNTbhFwFwqcd1PVg9oZW5LGl2pQM73QyDhdV2msTPkAWIymV0
 S+HBsyjdzddm6mbhuH8GBa/G5c5CNlg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-eRKGQ0f1NuyQEmTazlkXSw-1; Tue,
 30 Sep 2025 11:39:22 -0400
X-MC-Unique: eRKGQ0f1NuyQEmTazlkXSw-1
X-Mimecast-MFC-AGG-ID: eRKGQ0f1NuyQEmTazlkXSw_1759246760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389F5180057F; Tue, 30 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9E5D1800577; Tue, 30 Sep 2025 15:39:18 +0000 (UTC)
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
Subject: [PULL 15/23] tests/lcitool: add missing rust-std dep
Date: Tue, 30 Sep 2025 19:37:36 +0400
Message-ID: <20250930153746.573875-16-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some distros/targets may pull it by default, but some don't.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250924120426.2158655-16-marcandre.lureau@redhat.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/docker/dockerfiles/centos9.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 17 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index f446217f2c..2ca4a5392f 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -81,6 +81,7 @@ packages:
   - libspice-protocol-dev
   - libspice-server-dev
   - libssh-dev
+  - libstd-rust-dev
   - libsystemd-dev
   - libtasn1-6-dev
   - libubsan1
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 25c3368c54..7198fbbcbb 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -80,6 +80,7 @@ packages:
   - libsndio-dev
   - libspice-protocol-dev
   - libssh-dev
+  - libstd-rust-dev
   - libsystemd-dev
   - libtasn1-6-dev
   - libubsan1
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 33c62033ce..e7fc688ee9 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -105,6 +105,7 @@ RUN dnf distro-sync -y && \
         python3-tomli \
         rdma-core-devel \
         rust \
+        rust-std-static \
         sed \
         snappy-devel \
         socat \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index d4d3cebfdc..f3ad2205a7 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -141,6 +141,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:amd64 \
                       libspice-server-dev:amd64 \
                       libssh-dev:amd64 \
+                      libstd-rust-dev:amd64 \
                       libsystemd-dev:amd64 \
                       libtasn1-6-dev:amd64 \
                       libubsan1:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index cd9c9a0def..7d42227fa1 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -140,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:arm64 \
                       libspice-server-dev:arm64 \
                       libssh-dev:arm64 \
+                      libstd-rust-dev:arm64 \
                       libsystemd-dev:arm64 \
                       libtasn1-6-dev:arm64 \
                       libubsan1:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 21a5bbc81d..8ad4d2bebf 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -140,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:armhf \
                       libspice-server-dev:armhf \
                       libssh-dev:armhf \
+                      libstd-rust-dev:armhf \
                       libsystemd-dev:armhf \
                       libtasn1-6-dev:armhf \
                       libubsan1:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index c41a4805fe..e7e8d8e0f1 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -140,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:i386 \
                       libspice-server-dev:i386 \
                       libssh-dev:i386 \
+                      libstd-rust-dev:i386 \
                       libsystemd-dev:i386 \
                       libtasn1-6-dev:i386 \
                       libubsan1:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 77d5d43f4b..cca04a4594 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -139,6 +139,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:mips64el \
                       libspice-server-dev:mips64el \
                       libssh-dev:mips64el \
+                      libstd-rust-dev:mips64el \
                       libsystemd-dev:mips64el \
                       libtasn1-6-dev:mips64el \
                       libudev-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 9e60fe0eb4..59c6f92248 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -139,6 +139,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:mipsel \
                       libspice-server-dev:mipsel \
                       libssh-dev:mipsel \
+                      libstd-rust-dev:mipsel \
                       libsystemd-dev:mipsel \
                       libtasn1-6-dev:mipsel \
                       libudev-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index dc683bd498..97ef64d934 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -140,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev:ppc64el \
                       libspice-server-dev:ppc64el \
                       libssh-dev:ppc64el \
+                      libstd-rust-dev:ppc64el \
                       libsystemd-dev:ppc64el \
                       libtasn1-6-dev:ppc64el \
                       libubsan1:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index ef6e961460..3afe91494d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -139,6 +139,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsndio-dev:s390x \
                       libspice-protocol-dev:s390x \
                       libssh-dev:s390x \
+                      libstd-rust-dev:s390x \
                       libsystemd-dev:s390x \
                       libtasn1-6-dev:s390x \
                       libubsan1:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index ef9ba62f2a..f68fcc83a9 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -89,6 +89,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev \
                       libspice-server-dev \
                       libssh-dev \
+                      libstd-rust-dev \
                       libsystemd-dev \
                       libtasn1-6-dev \
                       libubsan1 \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index bdbcebda8d..167246f0f5 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -117,6 +117,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-wheel \
                rdma-core-devel \
                rust \
+               rust-std-static \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 3c54486d2f..c76a70c368 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -100,7 +100,8 @@ RUN nosync dnf install -y \
                mingw64-libtasn1 \
                mingw64-nettle \
                mingw64-pixman \
-               mingw64-pkg-config && \
+               mingw64-pkg-config \
+               rust-std-static-x86_64-pc-windows-gnu && \
     nosync dnf clean all -y && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index f758efd2b7..56a1ad8a18 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -117,6 +117,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-wheel \
                rdma-core-devel \
                rust \
+               rust-std-static \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 146ad7fce2..b393db55a8 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -88,6 +88,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libspice-protocol-dev \
                       libspice-server-dev \
                       libssh-dev \
+                      libstd-rust-dev \
                       libsystemd-dev \
                       libtasn1-6-dev \
                       libubsan1 \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 301d0e1ea0..82812e7736 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -104,6 +104,7 @@ packages:
  - python3-venv
  - rpm2cpio
  - rust
+ - rust-std
  - sdl2
  - sdl2-image
  - sed
-- 
2.51.0


