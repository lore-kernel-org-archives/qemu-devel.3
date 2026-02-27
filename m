Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0928EFEFB5A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbe-0000Nb-LI; Fri, 27 Feb 2026 10:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbZ-0000Le-Uc
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:13 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbW-0005kW-W8
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:13 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65c187dfc82so3503698a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205489; x=1772810289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lRLMJwcavPCngc4gcpwE1HUqI3iRCO8dOjTLFyK4Xo=;
 b=mEtHStkrTqkm9vJ4tWKIzNmqS8WqxPrl1IHJKaRWXKciL3MQxNkv3eVfgFiYSkezm7
 Mn/e6JPLQpl9/8+zomtYycvpEhJnXe9DAqIOnDaa2LqAkYK+xc6vZauldA6foPHTpNeB
 Yi6iuVo61fI9m2vp1SkGEjdC8GDhUEa6VzfPbkI/lrBkGiBu6kHhq+Tc4+V9seeUKwaZ
 wqXT37/qtPcWTzwobmG7hyb2q0ELZxdre9KgywSK94k3xSJNtxvwYHzV++iGhtYdVqoH
 5JGRwjdxHn9Gt0Ro5EmTpD0EKASuRHfuftYNItIckI7etqd9jv+rr7GW0suSiWyNxJm8
 WuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205489; x=1772810289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/lRLMJwcavPCngc4gcpwE1HUqI3iRCO8dOjTLFyK4Xo=;
 b=NQD0XUQCBi+ZFwpIqDBaeeecH/mNzSKyRPUbQUZuf6NYnw0UzldROmvIodjUbnzgj9
 IVN1SHU/vFS8XSf4wL9uag0hm8D0/lksIPZTuRcrtw9IAM7jGpLBcUy2Fmu//JRdO9ph
 ZtdEki4gFYdGgDwsFsAfBR3tl29JcPUX0WKNNj0e7mf03xuBQiNfqKzL06KM9ttLWzyM
 lM5giKcz0wX+oSnMpqDqGD2XROpZQtgYwgFWqdM/h/X7II1C7AiWsfYN9M1o+hI815V9
 JCqp04ZTX7AgjQlIaannM8pyaP5UqHWWsmeI3Wo0sLQZJhECeg+5+T23MM7NpkhgP5Jx
 aX4w==
X-Gm-Message-State: AOJu0YzEOWwxFNOj0kGHMgiq5wH6kJEI0rK7r2wOAZES1+6xbBseP2YF
 3ghEb1KZNa2rw95enEe2ePG4khss9j7A4nBHa6fKwDN0Hp7SP1R10dWTnIX7QHu3cKo=
X-Gm-Gg: ATEYQzxtDPn7xQX+5I4iP1vUaOFM7dbdG0iPpPiIYbJcg8nbZdZdb4m7bB9ypTiDgIg
 2+gvVGPbT+E58iVjC3vH8JxMAPxznia1zVbEnnLHZ0vPdRzog18aphyawoGNwzhIzf3NCoBKP43
 8YfusDFI4OE6IUfmUshEPzaqSbrgpDQLU4xTFWlakU08nSXYegunULXxeFbJX576Kd9gIkF48r1
 82ibghyOHFHMbr/oMp0t8sdGyNpeWe3fihrYttEUggoDSze7DG5xq9fcaXz4BQDd0y1FDrZJd6x
 2LFiZDF1GcyP6HTTztALFmmJewsiDHQAhHejiwmI6oSenlcSwrxS7axG1zyHlTkwxgUELbVn2bB
 15IM0uq0V4JOjBV+F7vopkUW6fj4/KNqSx9LbxE9Z42omRbtV9sU8cS6ih7KyzhoowHJgJ/1GB1
 Xf9ZuCfk6l1oClnXcH52TeBgE=
X-Received: by 2002:a05:6402:444c:b0:65f:8d21:68df with SMTP id
 4fb4d7f45d1cf-65fddcecec2mr1597171a12.19.1772205489158; 
 Fri, 27 Feb 2026 07:18:09 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd466d7sm1306610a12.13.2026.02.27.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53E4A5F8AB;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 2/7] tests/docker: migrate legacy-test-cross compilers to trixie
Date: Fri, 27 Feb 2026 15:17:59 +0000
Message-ID: <20260227151805.2335641-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

The bugs have evidently been fixed in the latest release so we can
migrate the laggards into how all-test-cross container and remove the
legacy hacks. They are also packaged for the main architectures so we
don't need to jump through the amd64 hoops.

Suggested-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260226185303.1920021-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 090579bf236..5e114acea28 100755
--- a/configure
+++ b/configure
@@ -1458,7 +1458,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
-      hppa|m68k|mips|riscv64|sparc64)
+      alpha|hppa|m68k|mips|riscv64|sh4|sparc64)
         container_image=debian-all-test-cross
         ;;
       mips64)
@@ -1470,14 +1470,6 @@ probe_target_compiler() {
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
 
-      # debian-legacy-test-cross architectures (need Debian 11)
-      # - libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
-      # - sh4-linux-user: binaries don't run with bookworm compiler
-
-      alpha|sh4)
-        container_image=debian-legacy-test-cross
-        ;;
-
       # architectures with individual containers
 
       aarch64)
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1b656b9eb08..fef19c2d5da 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -376,18 +376,6 @@ build-user-static:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
-      --target-list-exclude=alpha-linux-user,sh4-linux-user
-    MAKE_CHECK_ARGS: check-tcg
-
-# targets stuck on older compilers
-build-legacy:
-  extends: .native_build_job_template
-  needs:
-    - job: amd64-debian-legacy-cross-container
-  variables:
-    IMAGE: debian-legacy-test-cross
-    TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user
-    CONFIGURE_ARGS: --disable-tools
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-hexagon:
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 2a0cea6ce1a..92a7f1c1b47 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -10,12 +10,6 @@ amd64-debian-user-cross-container:
   variables:
     NAME: debian-all-test-cross
 
-amd64-debian-legacy-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-legacy-test-cross
-
 arm64-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 6aeccf8be0c..c8b8e44ad86 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -45,7 +45,6 @@ weekly-container-builds:
     # cross
     - amd64-debian-cross-container
     - amd64-debian-user-cross-container
-    - amd64-debian-legacy-cross-container
     - arm64-debian-cross-container
     - hexagon-cross-container
     - loongarch-debian-cross-container
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 1823233438a..b73776d95b5 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -64,6 +64,8 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
   libc6-dev-armhf-cross \
+  gcc-alpha-linux-gnu \
+  libc6.1-dev-alpha-cross \
   gcc-mips-linux-gnu \
   libc6-dev-mips-cross \
   gcc-mips64-linux-gnuabi64 \
@@ -77,7 +79,9 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   gcc-riscv64-linux-gnu \
   libc6-dev-riscv64-cross \
   gcc-s390x-linux-gnu \
-  libc6-dev-s390x-cross
+  libc6-dev-s390x-cross\
+  gcc-sh4-linux-gnu \
+  libc6-dev-sh4-cross
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
@@ -90,7 +94,7 @@ apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS --disable-docs
-ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
+ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
deleted file mode 100644
index 5a6616b7d39..00000000000
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ /dev/null
@@ -1,51 +0,0 @@
-# Docker legacy cross-compiler target (tests and minimal qemu)
-#
-# Compilers for some of our older targets which we cant currently
-# upgrade. Currently:
-#
-#   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
-#   sh4-linux-user: binaries don't run with bookworm compiler
-#
-# As we are targeting check-tcg here we only need minimal qemu
-# dependencies and the relevant cross compilers.
-
-FROM docker.io/library/debian:11-slim
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy qemu
-
-# Add extra build tools and as many cross compilers as we can for testing
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        bison \
-        ccache \
-        clang  \
-        flex \
-        git \
-        ninja-build \
-        gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross \
-        gcc-sh4-linux-gnu \
-        libc6-dev-sh4-cross \
-        python3-pip \
-        python3-setuptools \
-        python3-venv \
-        python3-wheel && \
-        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-
-RUN /usr/bin/pip3 install tomli
-
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
-ENV MAKE /usr/bin/make
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 8f0aa3fa343..c74345e03d0 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -172,6 +172,8 @@ debian_all_test_cross_compilers = [
     "  libc6-dev-arm64-cross \\\n",
     "  gcc-arm-linux-gnueabihf \\\n",
     "  libc6-dev-armhf-cross \\\n",
+    "  gcc-alpha-linux-gnu \\\n"
+    "  libc6.1-dev-alpha-cross \\\n"
     "  gcc-mips-linux-gnu \\\n",
     "  libc6-dev-mips-cross \\\n",
     "  gcc-mips64-linux-gnuabi64 \\\n",
@@ -185,7 +187,9 @@ debian_all_test_cross_compilers = [
     "  gcc-riscv64-linux-gnu \\\n",
     "  libc6-dev-riscv64-cross \\\n",
     "  gcc-s390x-linux-gnu \\\n",
-    "  libc6-dev-s390x-cross\n",
+    "  libc6-dev-s390x-cross\\\n",
+    "  gcc-sh4-linux-gnu \\\n",
+    "  libc6-dev-sh4-cross\n",
     "RUN if dpkg-architecture -e amd64; then \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
@@ -198,7 +202,7 @@ debian_all_test_cross_compilers = [
     "${AVAILABLE_COMPILERS} && \\\n",
     "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
     "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
-    "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
+    "ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
 ]
 
 def cross_build(prefix, targets):
-- 
2.47.3


