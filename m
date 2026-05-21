Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B509CD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3IB-0004h9-Ay; Thu, 21 May 2026 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Ho-00047C-Mh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hg-00004r-S5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so66479045e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369472; x=1779974272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlJ4jgLoEetm/zC8YlvKKOv8rd+Yctnv9k5IQArWiHQ=;
 b=tR+3WSL+a4Dk3KMaiFPHqLE7fhpLoma54l+jt2xZTrzrBn3IvrHuFVs/R7F32y/vLq
 m6reed1km+3GxapRigKwhWw6vqY8p6oCpal6J+/ZQf1OeuWHePrg3NZIePqUl23lXkZZ
 OYW3InxaNMdK7zeQ1cy3Fe2AWHGeRahXYrV55t2l7gm4RvwEHESq95BfZg36Q11fBiec
 s+YYiKj2Z/6yEBpkAKYJbMofGPqz9tq96BNg3Y+e1OHiJWoiQLNqqzKCqyrGPRCVvYGT
 Kp2SDK8fgwb6HNkyXDyz7BbbNFF49zuZITQJEm+9h2DtN78hjLmvnWVUafKjiistzJXs
 kYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369472; x=1779974272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rlJ4jgLoEetm/zC8YlvKKOv8rd+Yctnv9k5IQArWiHQ=;
 b=s/TWLQF1WEDmjNHluThyVd9K1LjgOMZIi3FogZnO4jVVxVTjGEzCTbMOJmEXw6IyHl
 VqpRoBrC7j5f3TascWi+gmXJgpCHhHiV0Wsm+cC2P764joLoZbh/jTVZVVa27rv8q5X/
 ZNdOfXsoSMPOuy0a/BE72u1ax9NGjVs3p1qxoma4WXc9lSdQrH1/OuJ+Ze8Vi+81pX8W
 LcAHkVBcYdnXxurSRxswzKotTNm5aplGTi3NS8Hi+vhVUi3eTLiBvgVoYt2K3VPFwp3p
 yLb8JkeqK4RvM3d+Ib4lB96KdDGeA0RgZ1wMiJWlNcXl05PsEL3qhC7tsKhRVzZX/lOL
 EMWg==
X-Gm-Message-State: AOJu0YzuFm1hbenpewNlFf5VFL+DscVwq7R6rJZSBzg+JJC0x07eiYwv
 VmkiHGir/sdGe5SHMvTiO+LWcIlceI+CfORFrLDEZg4cmwUzd0lW0F82imJ0ERveSpI=
X-Gm-Gg: Acq92OHV+r+2qi2raKTn+/Nr2tkBlmYXb0tneMx19zL1fvHmq4N8tr4mfo8Ta9U7M+J
 abNUCpG23HLcDzen6rSxf9Qzk4azo4s/JVN+AE2RaJa3MPax6ZlkifkBR3/k7KEnQiOODIwpd34
 AJ671xlKXVoGpdaEsoc0YRAu0Q16F8J2mya3S63fFQA+ERdPsE1x+esShdMG8k0ENiMyuOSHFEo
 G418dAaAUfUEdgl7x5tz7giQPEDU53sJ+LljSsHgOZmcQbs8tt0dwAcHXsv8egpgwBN5kc0R1ZT
 di/NvwTR/sBC1XjRyHrbnE3Tkl5dB4Eqd0nzdPts7OheGAOFQL3FFoQc2c63EgczrlRWbRUtv08
 MsN1S0RGf5SMTKpvRdUhJwa10euKxBO+i3qnKVvfk294h9RwugW31y8wEDW0reD9ppvWK1w3dcX
 rMpLLVewsr1K4Sd4ZDgzIRoaU=
X-Received: by 2002:a05:600c:8585:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-49038906125mr28888075e9.31.1779369472317; 
 Thu, 21 May 2026 06:17:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903ad2ee77sm23279625e9.0.2026.05.21.06.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E27905F886;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 16/16] docker: Remove LegacyKeyValueFormat warnings in
 generated files
Date: Thu, 21 May 2026 14:17:38 +0100
Message-ID: <20260521131739.540157-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Display lcitool changes before generated ones.

Update lcitool refresh script to not use legacy 'ENV key value'
format:
https://docs.docker.com/reference/build-checks/legacy-key-value-format/

Run "make lcitool-refresh" to update the generated container files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-8-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 4289cc381a6..d4d19e72ec6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -77,7 +77,7 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
         trailer = "\n".join(add_user_mapping)
 
     if enable_rust:
-        trailer += "\nENV ENABLE_RUST 1\n"
+        trailer += "\nENV ENABLE_RUST=1\n"
     generate(filename, cmd, trailer)
 
 
@@ -175,7 +175,8 @@ debian_all_test_cross_compilers = [
     "  dpkg-dev\\\n",
     "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
-    "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
+    "ENV AVAILABLE_COMPILERS=\"\\\n",
+    "  gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
     "  gcc-arm-linux-gnueabihf \\\n",
     "  libc6-dev-armhf-cross \\\n",
@@ -196,7 +197,8 @@ debian_all_test_cross_compilers = [
     "  gcc-s390x-linux-gnu \\\n",
     "  libc6-dev-s390x-cross\\\n",
     "  gcc-sh4-linux-gnu \\\n",
-    "  libc6-dev-sh4-cross\n",
+    "  libc6-dev-sh4-cross \\\n",
+    "  \"\n",
     "RUN if dpkg-architecture -e amd64; then \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
@@ -208,8 +210,8 @@ debian_all_test_cross_compilers = [
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
index 35c593502fc..061cd8e9b82 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -188,4 +188,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index d188d538365..3dfa60fdfd7 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -187,4 +187,4 @@ ARG UID
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
index d139c10c555..fc83fc0c00b 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -183,4 +183,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 2cfc33e8249..5f105b1d687 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -183,4 +183,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 7198036380b..2a7e8cba056 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index eb49da9781a..349de3a0bbb 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index f4c7896a75f..8bc42b1e00b 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 85b78f7e5f8..ee8b313d654 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -175,4 +175,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 5e88354f133..4f84b803798 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -185,4 +185,4 @@ ARG UID
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
index 393ac0cce73..a6996917c4b 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -162,4 +162,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 4b126b7e7de..fc363c647cd 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -149,4 +149,4 @@ ARG UID
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
2.47.3


