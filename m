Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8D5EE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH7y-0000hM-1C; Wed, 11 Sep 2024 02:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7v-0000Xp-JI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7r-0004PG-AX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:54 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a429so7329890a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037209; x=1726642009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfk4OlmPzpXdEoaFjjJFeaEzfslRcj4w5ekMaaS4uFU=;
 b=c0NrCX4PSEmd2b5rTLxYDTemi8qK0NuJaZjUEQ3i2XD0qtB9wFbwpMjJMyDxmxWEMP
 ZFXz5xWWKo1CSmGmCJB87vEKSke1L54BlxOan/UpwSgiL8Jmz1NAuXDH+qu36r/ASTV4
 gbB4sy8RIkrycmz8tJzWE1SrFmN7SjMFq3FMVFT6S396t4JlSHvyY5+5nlKRzBNXb7R9
 36ecAxNoHQoTOX27X3JZhk/0ccYi3eGe7nGY2Wd1R0wlGhhTyEJfnAW+qSY2+iQgdesa
 AT4Bakhi0ry6B6UNgUacwf0wu8UO6Atmsjv5SXauN0QAkcD96aZ7YTyYjgwAIbnQqfEP
 a7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037209; x=1726642009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfk4OlmPzpXdEoaFjjJFeaEzfslRcj4w5ekMaaS4uFU=;
 b=tlnbdrekfcTwg7/KY3Usq155mrOwAoAIybhgqjHyEYI16fZNYBeboTZ1sgAgSJwrBZ
 0V+yj5CDoKymamLs53zf2tx+TSN8ejAMS9L27ssKrt5QmUuoymb8ar5q3i4q2rxaDeLb
 L4gV/gsiYrIlp0X3MenNqumv1e4McG1Wi6PBwiid+93cYWxVup/DPITcIj1pA13vsWNY
 tVhyqZuu6XtQyRIXCh0ZXocOwDx5fNmi8hRkTrWpeOteqzjWHdYlJRB+M11vJYjgFPES
 ux+iFGhpmYR/A4UGtZm2syz0CtnPX5+L/5mkV3h5QQZKMYXgy2sLIKsU0bBKn3+MZ62v
 0AFQ==
X-Gm-Message-State: AOJu0Yxz92deaQA0YuwU0tS11cr+DOmrEAyzPinCBD+KcGhBJTDKkrpL
 AEtYbe3XTdHrVOX/KkESVWQOQKGM6EkXJAbSDmx1YwiyK4TmxwmTBVOASuE62n4=
X-Google-Smtp-Source: AGHT+IGqPlhxW1oHEYAfCleE48t0iyksiGVrFOWNqMIB2vjn8aQ3WZmBaTOqExDTZ9GnizglcJ6G8w==
X-Received: by 2002:a05:6402:2691:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5c3dc7bad6amr12297164a12.25.1726037208430; 
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76fcfsm5036039a12.65.2024.09.10.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 411285F9CE;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 02/10] tests/docker: update debian i686 and mipsel images to
 bookworm
Date: Wed, 11 Sep 2024 07:46:37 +0100
Message-Id: <20240911064645.357592-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
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

Whatever issues there were which stopped these being updates when the
rest were have now been resolved. However mips64el continues to be
broken so don't update it here.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-3-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 3fe8ee623d..2328ee1732 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch i686 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch i686 debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,16 +48,15 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
@@ -69,8 +68,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -145,6 +142,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev:i386 \
                       libvirglrenderer-dev:i386 \
                       libvte-2.91-dev:i386 \
+                      libxdp-dev:i386 \
                       libzstd-dev:i386 \
                       nettle-dev:i386 \
                       systemtap-sdt-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 0d559ae4ba..4ac314e22e 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,16 +48,15 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
@@ -69,8 +68,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -143,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev:mipsel \
                       libvirglrenderer-dev:mipsel \
                       libvte-2.91-dev:mipsel \
+                      libxdp-dev:mipsel \
                       libzstd-dev:mipsel \
                       nettle-dev:mipsel \
                       systemtap-sdt-dev:mipsel \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 199d5fad87..c60490a7fa 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -159,7 +159,7 @@ try:
                         trailer=cross_build("arm-linux-gnueabihf-",
                                             "arm-softmmu,arm-linux-user"))
 
-    generate_dockerfile("debian-i686-cross", "debian-11",
+    generate_dockerfile("debian-i686-cross", "debian-12",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
                                             "x86_64-softmmu,"
@@ -171,7 +171,7 @@ try:
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
 
-    generate_dockerfile("debian-mipsel-cross", "debian-11",
+    generate_dockerfile("debian-mipsel-cross", "debian-12",
                         cross="mipsel",
                         trailer=cross_build("mipsel-linux-gnu-",
                                             "mipsel-softmmu,mipsel-linux-user"))
-- 
2.39.2


