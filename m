Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861F2C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbNN-0001Sn-VC; Fri, 23 Feb 2024 14:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawG-0005nD-Pa
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawA-0005E2-2Q
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgAxyS6IW8O7GbuGWIGuj6wMTsF+Z7lreojznlOTU8E=;
 b=MR3bFY0U296iY51Ey/nHYzXd0nloNqUXOYTxwDeZhfzhNbhczFP3RR65g3+DU+CiQZbKaE
 ufIO56XXJ3XFpsVpBKupTgM8kCQy1n0BdL/kyl6DUuFYHjv7GzKG6BpOFXybJb2cACOV59
 i/1zt5wRO7k4e+gvb70QXcPVeKR+O3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Afn-iO_3P6yO_6_NztL7Yw-1; Fri, 23 Feb 2024 14:10:18 -0500
X-MC-Unique: Afn-iO_3P6yO_6_NztL7Yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D072800074;
 Fri, 23 Feb 2024 19:10:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEF7D8CED;
 Fri, 23 Feb 2024 19:10:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/11] .gitlab-ci.d: Drop cross-win32-system job
Date: Fri, 23 Feb 2024 20:10:01 +0100
Message-ID: <20240223191003.6268-10-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

We don't support 32-bit Windows any more, so we don't need to defend it
with this CI job.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20240222130920.362517-3-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/container-cross.yml              |   5 -
 .gitlab-ci.d/crossbuilds.yml                  |  14 ---
 .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
 tests/lcitool/refresh                         |   5 -
 4 files changed, 135 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d235cbea0..e3103940a0 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -101,11 +101,6 @@ cris-fedora-cross-container:
   variables:
     NAME: fedora-cris-cross
 
-win32-fedora-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: fedora-win32-cross
-
 win64-fedora-cross-container:
   extends: .container_job_template
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index d19d98cde0..987ba9694b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
     IMAGE: debian-mips64el-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
 
-cross-win32-system:
-  extends: .cross_system_build_job
-  needs:
-    job: win32-fedora-cross-container
-  variables:
-    IMAGE: fedora-win32-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
-    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
-                        microblazeel-softmmu mips64el-softmmu nios2-softmmu
-  artifacts:
-    when: on_success
-    paths:
-      - build/qemu-setup*.exe
-
 cross-win64-system:
   extends: .cross_system_build_job
   needs:
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
deleted file mode 100644
index 08799219f9..0000000000
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ /dev/null
@@ -1,111 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mingw32 fedora-38 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM registry.fedoraproject.org/fedora:38
-
-RUN dnf install -y nosync && \
-    printf '#!/bin/sh\n\
-if test -d /usr/lib64\n\
-then\n\
-    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
-else\n\
-    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
-fi\n\
-exec "$@"\n' > /usr/bin/nosync && \
-    chmod +x /usr/bin/nosync && \
-    nosync dnf update -y && \
-    nosync dnf install -y \
-               bash \
-               bc \
-               bison \
-               bzip2 \
-               ca-certificates \
-               ccache \
-               ctags \
-               dbus-daemon \
-               diffutils \
-               findutils \
-               flex \
-               gcc \
-               gcovr \
-               git \
-               glib2-devel \
-               glibc-langpack-en \
-               hostname \
-               llvm \
-               make \
-               meson \
-               mtools \
-               ninja-build \
-               nmap-ncat \
-               openssh-clients \
-               pcre-static \
-               python3 \
-               python3-PyYAML \
-               python3-numpy \
-               python3-opencv \
-               python3-pillow \
-               python3-pip \
-               python3-sphinx \
-               python3-sphinx_rtd_theme \
-               sed \
-               socat \
-               sparse \
-               spice-protocol \
-               swtpm \
-               tar \
-               tesseract \
-               tesseract-langpack-eng \
-               util-linux \
-               which \
-               xorriso \
-               zstd && \
-    nosync dnf autoremove -y && \
-    nosync dnf clean all -y
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN nosync dnf install -y \
-               mingw32-SDL2 \
-               mingw32-SDL2_image \
-               mingw32-bzip2 \
-               mingw32-curl \
-               mingw32-gcc \
-               mingw32-gcc-c++ \
-               mingw32-gettext \
-               mingw32-glib2 \
-               mingw32-gnutls \
-               mingw32-gtk3 \
-               mingw32-libepoxy \
-               mingw32-libgcrypt \
-               mingw32-libjpeg-turbo \
-               mingw32-libpng \
-               mingw32-libtasn1 \
-               mingw32-nettle \
-               mingw32-nsis \
-               mingw32-pixman \
-               mingw32-pkg-config && \
-    nosync dnf clean all -y && \
-    rpm -qa | sort > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-c++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-gcc
-
-ENV ABI "i686-w64-mingw32"
-ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw32.meson"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-w64-mingw32-
-ENV DEF_TARGET_LIST i386-softmmu
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0c93557ad6..fe7692c500 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -192,11 +192,6 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win32-cross", "fedora-38",
-                        cross="mingw32",
-                        trailer=cross_build("i686-w64-mingw32-",
-                                            "i386-softmmu"))
-
     generate_dockerfile("fedora-win64-cross", "fedora-38",
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-- 
2.43.2


