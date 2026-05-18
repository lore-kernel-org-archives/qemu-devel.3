Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D57ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv8J-00047A-0q; Mon, 18 May 2026 06:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv84-0003Sn-18
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv80-0004lc-V4
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so1237984f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099795; x=1779704595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07s/+4PCllnmdpBet4+sTJfjB9IRh108i9d6ttP/mgw=;
 b=hu03ewycT7wTLfErZoHpuuCC8JazwUQq9fA0p+vSe3cQsb1mwW2n3u7BvTmcoZf9my
 EKqncXzresV/CxqmFzFGciSzAOw2rhPsCBeGZ0sek0orW7eApSwHcTZ+8H0o1hIjjQFy
 /HtFgNvHD8SBEU677vG+RwQb166cJkFGMS3c1RWI0ur/iEo6A3S96Az/W2Hy7K9Xv8iT
 pGcc6somvim5CH5ckTu9aGrorOiwpEB4I4jdDaN4KMkgfLr3DkJx3A14cTIZnC40auP9
 Xri/yemgyhJgG7B5Std/PJho6hyAgvcfV372jYCIAlQLOMIoEuUWSQvReSbwn9et3Jtf
 QkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099795; x=1779704595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=07s/+4PCllnmdpBet4+sTJfjB9IRh108i9d6ttP/mgw=;
 b=ASaT0UmMBhS6ix48qqvY9aNiZWfneILvhl474RcG9j//hE1OY2dhds9ctyyLLz19mO
 +hOs7Pwnm43psoLTx0DZFzjTH4/zLGk2CIAKordU5ftyjPIGlSesy7g0pHAoA1+EPkHF
 bjkc9LTf2dN4bqzqLvIe7yLCmF82BJy9qdTLMSFAFQu0ABZp5JJFZNQibAN31ZgIJ3qB
 pF6V00kjcUiYdqkMlrbZvD3QSfV0aasqRIKt19HHutsCSV0b6bxyTrWqHq4OLBqvXtHb
 0gpgwbVeta/MZZGg3XH/Ie83tsDWF9ZCRTocMTRd0QWUGKWKuiJb6+q/xfkE6QfoY/NJ
 gjdA==
X-Gm-Message-State: AOJu0YxiVt9VQhcVcHSv42hym8q0VKdfdju918VX4ZY8u2d1eeA0xxrG
 go9wzUrqpBMUawP8KPe5hZkxuOepsFLzLvOfLlxQQXu4inpBvKsFtOSqxydTxUHoIAjZ4W7VEZR
 aaS7/Vq4=
X-Gm-Gg: Acq92OHfPllV5PpBDxm3wJQU9WxtlIagvJgx+HGnC10LAHxilIuC44zXDVL5LdFBC2G
 AdyOmFig5sRRCEUZDVVNAJ7K6e/cfJmaxpZgBNDAzyuqdTdgWCNJQ2Vu9YN8q+nP/JClC/1LaSO
 hABaR2rhlSGiE2cX5Q+exSmGwISWWtGMbMiknTONl45iRnctzyJMXU3djGOMjPsm5S6GfJfBzVl
 JP8NkUP5in4eGJT3YLq3A/1mAeL/5RSv/cHXrXw+Bi/krsn4v6DQ4qMzkmqxc/72WDmzHfg9tsU
 MMslg7WVffpZ3HuQkgzkUYU4/PdUMTM0aPZHQq0RF8PW4NxuTXlVRVx9d6BUD/fLMAbf2/pCmMc
 QMe44+Zm8dmADAsgcwa4LO/uKjDHCPQxTu+AHfDlcP5I8ZgCYKkL/evaV0KjOTU01Saj0m62wFd
 rvFzbAdBn63PR4/u1Ht0JpYIoJMRXjCNLyO8TZk9YNOwWEahoL9NDnmSePmP+I26Fg/PE7MTFL
X-Received: by 2002:a05:6000:2913:b0:45e:779a:302c with SMTP id
 ffacd0b85a97d-45e779a305fmr8320998f8f.29.1779099794959; 
 Mon, 18 May 2026 03:23:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm37351284f8f.29.2026.05.18.03.23.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:23:14 -0700 (PDT)
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
Subject: [PATCH 7/7] docker: Remove LegacyKeyValueFormat warnings in generated
 files
Date: Mon, 18 May 2026 12:22:22 +0200
Message-ID: <20260518102222.80735-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Display lcitool changes before generated ones.

Update lcitool refresh script to not use legacy 'ENV key value'
format:
https://docs.docker.com/reference/build-checks/legacy-key-value-format/

Run "make lcitool-refresh" to update the generated container files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/lcitool/refresh                                | 12 +++++++-----
 tests/docker/dockerfiles/alpine.docker               |  2 +-
 tests/docker/dockerfiles/centos9.docker              |  2 +-
 .../docker/dockerfiles/debian-all-test-cross.docker  | 10 ++++++----
 tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker    |  2 +-
 .../docker/dockerfiles/debian-mips64el-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian.docker               |  2 +-
 tests/docker/dockerfiles/fedora-rust-nightly.docker  |  2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker   |  2 +-
 tests/docker/dockerfiles/fedora.docker               |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker        |  2 +-
 scripts/git.orderfile                                |  4 ++++
 19 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e4d01d792b7..a736f7f0ae6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -77,7 +77,7 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
         trailer = "\n".join(add_user_mapping)
 
     if enable_rust:
-        trailer += "\nENV ENABLE_RUST 1\n"
+        trailer += "\nENV ENABLE_RUST=1\n"
     generate(filename, cmd, trailer)
 
 
@@ -169,7 +169,8 @@ debian_all_test_cross_compilers = [
     "  dpkg-dev\\\n",
     "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
-    "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
+    "ENV AVAILABLE_COMPILERS=\"\\\n",
+    "  gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
     "  gcc-arm-linux-gnueabihf \\\n",
     "  libc6-dev-armhf-cross \\\n",
@@ -190,7 +191,8 @@ debian_all_test_cross_compilers = [
     "  gcc-s390x-linux-gnu \\\n",
     "  libc6-dev-s390x-cross\\\n",
     "  gcc-sh4-linux-gnu \\\n",
-    "  libc6-dev-sh4-cross\n",
+    "  libc6-dev-sh4-cross \\\n",
+    "  \"\n",
     "RUN if dpkg-architecture -e amd64; then \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
@@ -202,8 +204,8 @@ debian_all_test_cross_compilers = [
     "apt install -y --no-install-recommends \\\n",
     "${AVAILABLE_COMPILERS} && \\\n",
     "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
-    "ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
+    "ENV QEMU_CONFIGURE_OPTS=--disable-docs\n",
+    "ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
 ]
 
 def cross_build(prefix, targets):
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index a7ee85fcda7..118c6e8eeaf 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -141,4 +141,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 41a1225856e..0d5b5fa7f59 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -145,4 +145,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 287770a995a..a10ffc73500 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   dpkg-dev\
   gdb-multiarch\
   libclang-rt-dev
-ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
+ENV AVAILABLE_COMPILERS="\
+  gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
   libc6-dev-armhf-cross \
@@ -82,7 +83,8 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   gcc-s390x-linux-gnu \
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
-  libc6-dev-sh4-cross
+  libc6-dev-sh4-cross \
+  "
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
@@ -94,8 +96,8 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
-ENV QEMU_CONFIGURE_OPTS --disable-docs
-ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV QEMU_CONFIGURE_OPTS=--disable-docs
+ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 6fad808e1b6..7340ab72cf2 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -189,4 +189,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 889d8a1a755..4c52729068c 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -188,4 +188,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 988c87075f6..401c64269c1 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index d720ebb0bca..8b60c7b085f 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 90a2ef15574..82f4fefcccc 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -184,4 +184,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index b7e36b3d974..9962c879715 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -184,4 +184,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index a70fbee0c1d..1ad938a7127 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -187,4 +187,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 9ada5ecce0d..d04ebeab807 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -187,4 +187,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index a1de94ff9aa..5e8562aca33 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index c34923b253d..beb4cd3af93 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -176,4 +176,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 8766f952ac8..b3d63611595 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 751789e849b..c1e63feb46f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -120,4 +120,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ec787aa7027..7e8ad473a2a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -163,4 +163,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 66e90fa3634..a61467056af 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -150,4 +150,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 8edac0380ba..4b693c9deec 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -39,3 +39,7 @@ qga/*.json
 # code
 *.c
 *.c.inc
+
+# Generated Dockerfiles
+tests/lcitool/refresh
+tests/docker/dockerfiles/*
-- 
2.53.0


