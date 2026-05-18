Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C4CD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv8H-0003z2-Hr; Mon, 18 May 2026 06:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7x-0003MP-47
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7u-0004jI-Tb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso1039954f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099789; x=1779704589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaAQdXaV61Vlrt/7OZQP7J6GeluQJWzfA/1+hGviE0U=;
 b=r/rnS/LhjJRaM9FdXDIjuPTQLOBMJBMhRjf/SWKAlR0UTWdeakHXIzkjYyMFcANsKS
 H16kpH57BsMFSWL9DP9DelMUAlVVlzdpjG5rUh3Jh0BOW90xXvrO7WVaBnCEV6z4H+5F
 i7jHOn3CEB1bB0WZFVqiB/ES9ATy1TN7oEd5mf4oY/QNL4oXk6OZ4of5l/1WbxEV47qP
 TMAPTnMTOxi4doc6VqQ/SzJQoJPq+J20dwmC47EUJuvlu9sDRyp65epos/BWS0eHsDU/
 CIPxXfeeiXePXgT0lu21JWpGuO7cogTdhHZx1aBDahL5KmZiMo5l0+djmFRxmFTjNfI5
 a2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099789; x=1779704589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JaAQdXaV61Vlrt/7OZQP7J6GeluQJWzfA/1+hGviE0U=;
 b=ngNgev8iXSWaqFjj/QAawqi5LYexbdm/dB8aGDwUU/+jJyTm4sAcdD0O4cwPJBNGwd
 hosu8Gkd3WXDnsfmlIa/tsIs5PF1AU4dMJFYaKTjKdkmCJh/RojGfAWqt0icZiJaVMZM
 OjzzwwWNrVwc9qeItD3vovqjS0gIGoNEU0G+FSBLKjowPjLotoR47zGBen2jznsYAgN0
 d/DI+l5r70IxnM7HVGoxsi1ukN92ru58opTnOQZ3dDaNq7K4/sx9IW8GBHWo9xNokGVE
 kUfMqAbOTkwp6JtUaX11bqRAvIXGWlUruT2dox1+oqN/WfPp29exxHsBMod2kPvZmfEG
 xGCw==
X-Gm-Message-State: AOJu0YzgSIwO9ED5mfCZ/D2KPrB213FGGajxwcQDj6/GRVAOWjcB+NOF
 o0D3XJjp8qiHfPxWYtQw+hroYqqTYMhJ6k7GcS+761EPCp1KPzixlcov5jv5pDa7RE6cgGQEfPV
 pKf0Ljfg=
X-Gm-Gg: Acq92OE/S8fPrJuftEIxIxb9ckJ44c0D4aRMNHwpUj9/Bo7ZgcEY/vixjU7bmXeTudZ
 dOCaMz44J5BAi2wl2mlyuQIDXcZHOrDBq0/mCF+z0NS8HPBhymmYfYpnTN0V0S9sFxgK4GIL1Pj
 0V5SC96Ga00JBh4RANK/QC2cyvu1/XCwToWJFni59/6NT/0FFSviWRNb/6llCKnCYZ2dAkmjK/c
 BbzoMzREhX81DvFYi4QdndyZOGn1YqI3GgtIZ5b4zJ0yfWw4gkn6bEN6VqPhvVzFnL8pZjGCSSx
 qWDMpFonGCGTAocMSLpLXyht0gmjIjL+JIf8pul95tfoRDeGoIxX3D0nbdejTlLggPo4fOqmWJK
 xm9Jy5vyClOb9MCnGryjKvwFew5L34P7ylszzb7NAuaMnft0AcgG7NNJ4z9fViy/BzGeCkFDzCV
 UF+vWmfiF2zC8zci3OnJnmPVX1yEhnAB/1ZPG8dqMi40qVCodCdoB8iV9W4x19H9tdR4t5uC+x
X-Received: by 2002:a5d:5d82:0:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-45e5c5995bfmr21403486f8f.35.1779099787786; 
 Mon, 18 May 2026 03:23:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm35753399f8f.16.2026.05.18.03.23.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:23:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] docker: Remove LegacyKeyValueFormat warnings in
 non-generated files
Date: Mon, 18 May 2026 12:22:21 +0200
Message-ID: <20260518102222.80735-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Manually update Dockerfiles to not use legacy 'ENV key value' format:
https://docs.docker.com/reference/build-checks/legacy-key-value-format/

This removes warnings when building / using the containers:

 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 98)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 64)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 97)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .../docker/dockerfiles/debian-hexagon-cross.docker | 14 +++++++-------
 .../dockerfiles/debian-loongarch-cross.docker      | 10 +++++-----
 .../docker/dockerfiles/debian-tricore-cross.docker |  6 +++---
 .../docker/dockerfiles/debian-xtensa-cross.docker  |  8 ++++----
 tests/docker/dockerfiles/python.docker             |  5 +++--
 scripts/coverity-scan/coverity-scan.docker         | 12 ++++++------
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 91d4b71ac95..3c94f040b81 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -39,15 +39,15 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV TOOLCHAIN_INSTALL /opt
-ENV TOOLCHAIN_RELEASE 12.Dec.2023
-ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
-ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV TOOLCHAIN_INSTALL=/opt
+ENV TOOLCHAIN_RELEASE=12.Dec.2023
+ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl
+ENV TOOLCHAIN_URL=https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
 
 RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
-ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
-ENV MAKE /usr/bin/make
+ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 55b3dbe4510..d2ba07972ce 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -40,12 +40,12 @@ RUN apt-get update && \
 RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
-ENV PATH $PATH:/opt/cross-tools/bin
-ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
+ENV PATH=$PATH:/opt/cross-tools/bin
+ENV LD_LIBRARY_PATH=/opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
-ENV MAKE /usr/bin/make
+ENV QEMU_CONFIGURE_OPTS="--disable-docs --disable-tools"
+ENV DEF_TARGET_LIST=loongarch64-linux-user,loongarch64-softmmu
+ENV MAKE=/usr/bin/make
 
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index fd797dc7ee4..9e7ff321677 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -40,9 +40,9 @@ RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/trico
     | tar -xzC /usr/local/
 
 # This image can only build a very minimal QEMU as well as the tests
-ENV DEF_TARGET_LIST tricore-softmmu
-ENV QEMU_CONFIGURE_OPTS --disable-user --disable-tools --disable-fdt
-ENV MAKE /usr/bin/make
+ENV DEF_TARGET_LIST=tricore-softmmu
+ENV QEMU_CONFIGURE_OPTS="--disable-user --disable-tools --disable-fdt"
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index ef63e44e2ef..d9130fc3378 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,16 +19,16 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
-ENV TOOLCHAIN_RELEASE 2020.07
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
         curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
         | tar -xzC /opt; \
     done
 
-ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
-ENV MAKE /usr/bin/make
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 59e70a02484..79c554a2d87 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -4,7 +4,7 @@ FROM fedora:latest
 MAINTAINER John Snow <jsnow@redhat.com>
 
 # Please keep this list sorted alphabetically
-ENV PACKAGES \
+ENV PACKAGES="\
     gcc \
     make \
     python3 \
@@ -15,7 +15,8 @@ ENV PACKAGES \
     python3.11 \
     python3.12 \
     python3.13 \
-    python3.9
+    python3.9 \
+    "
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index a349578526d..bb9db40f27a 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -153,12 +153,12 @@ exec "$@"' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-ENV QEMU_CONFIGURE_OPTS --meson=internal
+ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
+ENV LANG=en_US.UTF-8
+ENV MAKE=/usr/bin/make
+ENV NINJA=/usr/bin/ninja
+ENV PYTHON=/usr/bin/python3
+ENV QEMU_CONFIGURE_OPTS=--meson=internal
 
 RUN dnf install -y curl wget
 ENV COVERITY_TOOL_BASE=/coverity-tools
-- 
2.53.0


