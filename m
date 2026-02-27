Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88862FEFB5D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzba-0000Lt-DZ; Fri, 27 Feb 2026 10:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbY-0000LD-Mr
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:12 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbW-0005kR-6T
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:12 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65fac0b51baso4028133a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205488; x=1772810288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gdbp7cCfKPN88niQvYSNW+Fatzs8R/gyPaadw4SxJ5w=;
 b=UNkFJLt/4WUrnVRKp+PV0dwH2M99PYV69QHyXSgjrfEHmhligDjmxv078K47C5PFoG
 FAlOgpKVjHEwHvvgSZJYScVL03zjNrdAIAwaPQT8vk0ETJfl0P0L1lgh6rSY2ejkpcL5
 bgHjYUimqFuEW128fB8Ae0tih2wcjaW6RIOXcNUuDdU8lB/vcgxC1q2WL4DSA9UVf65Q
 uEtVFbpdU5cqptiO62AJybzviSQ6GFZLohAJo2Df+l0H3Y5RQHj+OstUlqw2126ALKo7
 Z/1awmaiS5achx3RGm/LRDwsIPWhhd5jAu8eFPCPvSF33wuGLycfk8HzjO5HFm0Y3r+C
 hdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205488; x=1772810288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gdbp7cCfKPN88niQvYSNW+Fatzs8R/gyPaadw4SxJ5w=;
 b=oYe56b6MA+Z2byp2iqsAGMdh6U2uaQp7nMsctWiAAgF4gi144qLXj3MSoy4VhoEWh1
 ceisEWy+Csl1cWmPzck/tMILZtUGl/2hyYIVnWT/U6U0NqxTI2HwuyRXtpmJkX9S3F3b
 5M++0uDyy/X3SHTq4n9JHnUaJe8sZCd11rwenr8Hq+xfeBhi7n9B1EEsKHcMZGbrHZN0
 Xt/+pPxnVMdAW+Aehenm44+TTCBB7GhCpU1zKugpvehHldflf60JdsgTB+dkfxrHZIi9
 lzSGhMKDQXA1YhH7MDLD6+Dux7LN0bfj25sBmXHnV6h16gew4jGOfUyGwbW56ip99Q2W
 kxcg==
X-Gm-Message-State: AOJu0Yy0T5LUNFWqJfRYgsxUO1YYPq3CQ1xOhpl0Ac/J0L4kO8ouiihm
 Q3NNTY7XYU72qI5WNBfdaYIWh24gTnNLnbPeirgCSumy8UbdipIrefBdte6SqkEySC1+w6njNgR
 HncHo
X-Gm-Gg: ATEYQzx8JuS0+wlUcLhqEGWUCU+nm+g29TcKyLg6SoS62QtbhrwE7Q3Eafw62seuBf3
 RJarsudoUaPnP7G7mPEZhsN8zwqcZJSzAxQQC2hbfLWZw0MzKoWkeAopt7IPuXAH4kNBZyxzuBh
 QzGFxFS/3M2nYL0Fubno6V1I9JWif7p7OlN+ubM9JXZ29hgH4ssYLExezIlmJvxx/a8V9Q3qjNA
 Nmi+4D3Nhis7TnIiad7CYJaBcVZgaI5s9Fy1epoZImjRwZM//heTsfoTSAUX/sa3gcwlnpE/jwu
 4S0rTlXA5o3aliOCS74uwIt428B28Zj3NXst8CNZe6xYE6d6XyX00pgFsv4IF0Ij9wYrdM5APCa
 9HzRiuJ8Fs45Rsxs2T3sJNlWppn1bC5bve4NDQElRDoTfFdde7z9z9MT3KH4v4Lv2XOHwFx8FOq
 KWrXcJGhkDGI/6oeqAxv+LoSU=
X-Received: by 2002:a05:6402:354d:b0:658:bf9f:75be with SMTP id
 4fb4d7f45d1cf-65fe2d730bbmr1848193a12.16.1772205488211; 
 Fri, 27 Feb 2026 07:18:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac07c06csm1329368a12.33.2026.02.27.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 366EF5F7F6;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/7] tests/docker: upgrade most non-lcitool debian tests to
 debian 13
Date: Fri, 27 Feb 2026 15:17:58 +0000
Message-ID: <20260227151805.2335641-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: John Snow <jsnow@redhat.com>

Debian 11 was EOL in 2024, and Debian 12 will be EOL this June. This
patch moves all but one of our tests, debian-legacy-test-cross, onto
Debian 13.

This patch does the bare minimum to upgrade these tests and doesn't make
any attempt at optimization or cleanup that may or may not be possible
with this upgrade.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[AJB: tweak summary line]
Message-ID: <20260226185303.1920021-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 23152b4918b..91d4b71ac95 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -5,10 +5,12 @@
 # needs to be able to build QEMU itself in CI we include its
 # build-deps.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
+
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
@@ -24,6 +26,7 @@ RUN apt-get update && \
         ninja-build \
         python3-pip \
         python3-setuptools \
+        python3-tomli \
         python3-venv \
         python3-wheel && \
 # Install QEMU build deps for use in CI
@@ -36,8 +39,6 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 ENV TOOLCHAIN_INSTALL /opt
 ENV TOOLCHAIN_RELEASE 12.Dec.2023
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 538ab534902..55b3dbe4510 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -4,10 +4,11 @@
 # This docker target uses prebuilt toolchains for LoongArch64 from:
 # https://github.com/loongson/build-tools/releases
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -31,12 +32,11 @@ RUN apt-get update && \
         ninja-build \
         python3-pip \
         python3-setuptools \
+        python3-tomli \
         python3-venv \
         python3-wheel && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
diff --git a/tests/docker/dockerfiles/debian-toolchain.docker b/tests/docker/dockerfiles/debian-toolchain.docker
index ab4ce29533d..9a256209a78 100644
--- a/tests/docker/dockerfiles/debian-toolchain.docker
+++ b/tests/docker/dockerfiles/debian-toolchain.docker
@@ -4,13 +4,15 @@
 # This dockerfile is used for building a cross-compiler toolchain.
 # The script for building the toolchain is supplied via extra-files.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 # Install build utilities for building gcc and glibc.
 # ??? The build-dep isn't working, missing a number of
 # minimal build dependiencies, e.g. libmpc.
 
-RUN sed 's/^deb /deb-src /' </etc/apt/sources.list >/etc/apt/sources.list.d/deb-src.list
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
@@ -34,7 +36,7 @@ RUN cd /root && ./build-toolchain.sh
 # Throw away the extra toolchain build deps, the downloaded source,
 # and the build trees by restoring the original image,
 # then copying the built toolchain from stage 0.
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 7e00e870ceb..fd797dc7ee4 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
@@ -31,12 +31,11 @@ RUN apt update && \
        pkgconf \
        python3-pip \
        python3-setuptools \
+       python3-tomli \
        python3-wheel \
        python3-venv && \
        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/tricore-toolchain-9.40/tricore-toolchain-9.4.0.tar.gz \
     | tar -xzC /usr/local/
 
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d011eee2ad3..ef63e44e2ef 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -5,7 +5,7 @@
 # using a prebuilt toolchains for Xtensa cores from:
 # https://github.com/foss-xtensa/toolchain/releases
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-- 
2.47.3


