Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E7BC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVht-0002v4-Aj; Mon, 27 May 2024 04:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVfa-0005c6-Kl; Mon, 27 May 2024 04:25:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVfW-0001Fj-6H; Mon, 27 May 2024 04:25:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79B766A586;
 Mon, 27 May 2024 11:22:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A3C67D8523;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66477 invoked by uid 1000);
 Mon, 27 May 2024 08:21:39 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 41/44] dockerfiles: add 'MAKE' env variable to
 remaining containers
Date: Mon, 27 May 2024 11:21:32 +0300
Message-Id: <20240527082138.66217-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

All the lcitool generated containers define a "MAKE" env. It will be
convenient for later patches if all containers do this.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240513111551.488088-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit bad7a2759c69417a5558f0f19d4ede58c08705e8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 2cc7a24d4d..6cc38a3633 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -68,6 +68,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
+ENV MAKE /usr/bin/make
 ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 60bd8faa20..f2d40f2dee 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -45,6 +45,7 @@ ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
 RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
+ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index 8cc68bc912..d75e0b85e2 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -42,6 +42,7 @@ RUN /usr/bin/pip3 install tomli
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
+ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index b25e779a2c..6a9197528b 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -44,6 +44,7 @@ ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-li
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+ENV MAKE /usr/bin/make
 
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index c597f8e16b..16276aa21d 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -44,6 +44,7 @@ RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/trico
 # This image can only build a very minimal QEMU as well as the tests
 ENV DEF_TARGET_LIST tricore-softmmu
 ENV QEMU_CONFIGURE_OPTS --disable-user --disable-tools --disable-fdt
+ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index 72c25d63d9..413881899b 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -27,6 +27,7 @@ RUN for cpu in $CPU_LIST; do \
     done
 
 ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
index f2899af410..97c9d37ede 100644
--- a/tests/docker/dockerfiles/fedora-cris-cross.docker
+++ b/tests/docker/dockerfiles/fedora-cris-cross.docker
@@ -4,6 +4,7 @@
 
 FROM registry.fedoraproject.org/fedora:33
 ENV PACKAGES gcc-cris-linux-gnu
+ENV MAKE /usr/bin/make
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
 # As a final step configure the user (if env is defined)
-- 
2.39.2


