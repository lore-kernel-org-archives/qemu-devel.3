Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA80C25B7B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdD-0005DG-JX; Tue, 14 May 2024 08:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd3-0005AX-8Q
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd0-0005EO-GS
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/WhLX/kEh+IzBqgpufTuWT7PY5qdV7NJzxrD19lyZY=;
 b=JcI3W9O5cL5d/S8kGJNRj+8wMP9BTpabfkh/SJhcue0++xenAvav8UMqBNxogXaVgbWTZ7
 XwlJ9EjPXk1JfHohpE+EoueP/KNTVYvk354oK6uSE1e+TMZ9HeiNINKjZPUTVG1miOQfeJ
 ggahdlNgjN04blyCojIcE0wesMZNHWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-REOM8Z3QMK-ip7RjJOwJeQ-1; Tue, 14 May 2024 08:51:24 -0400
X-MC-Unique: REOM8Z3QMK-ip7RjJOwJeQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A59908025FC;
 Tue, 14 May 2024 12:51:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D0DF400057;
 Tue, 14 May 2024 12:51:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/11] dockerfiles: add 'MAKE' env variable to remaining
 containers
Date: Tue, 14 May 2024 14:51:10 +0200
Message-ID: <20240514125119.284638-3-thuth@redhat.com>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

From: Daniel P. Berrangé <berrange@redhat.com>

All the lcitool generated containers define a "MAKE" env. It will be
convenient for later patches if all containers do this.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240513111551.488088-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-hexagon-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-legacy-test-cross.docker | 1 +
 tests/docker/dockerfiles/debian-loongarch-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-tricore-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-xtensa-cross.docker      | 1 +
 tests/docker/dockerfiles/fedora-cris-cross.docker        | 1 +
 7 files changed, 7 insertions(+)

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
2.45.0


