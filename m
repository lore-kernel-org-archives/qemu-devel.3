Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30BEC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGz9I-0004Ql-4a; Tue, 11 Jun 2024 06:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz9F-0004P4-V8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:41 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz9D-0006In-Vl
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:41 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso4425874a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718103278; x=1718708078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp4qcVgbomRF1I+d8YgrO8KMq/PZjFleULs4t/yYhDk=;
 b=GAjq+LVPHPVzI/jGdRukMWLWZXZIixe7NxzGBAAbdOC30Pws2k+pWD5m0uYRRx3u2f
 KD02ZV78SSyU/E+0k6SePdxXBNCIo6d2KWGRIg7F9qMTHJ6lftoofnGVUcpbMf0s/+E+
 n9rHgNu7NqM2HQE+06yIGjGdkT2LZxCYL083dPc0X2gJelClDbY+RLGPP+Br2Ta+usuy
 3mxf0riT2MPhUghkcFW/MNj4nDMuRRtCpJE9uVnvuAInTVqDBrJZA9jUrISQ6SuCHi3x
 DWwf9L7dnyMaD1zf2fKgwSrMfdFnrW3CBAsP2PhXQLRRiw1/X7dpAHZObSDqVI0FWogW
 DfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103278; x=1718708078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yp4qcVgbomRF1I+d8YgrO8KMq/PZjFleULs4t/yYhDk=;
 b=K1pBd4YBW+WGxHZmOuc5bhts7/eliGY5OT8OY7lL5pAjtBaQUgfh4jf1Fd87F917nR
 /QuB4EM4NpNsrCIS6FkQC65M3WHPlL1Is2PuTiMnhcua4A9P0DXATvxkYSki1fLidGb+
 qdIT9zGLZALjKwWmN+3TbKjWd2YKTwHnAvVz2vacynN5OquksEc8IShHUxAfggenTOLO
 uUgnOBogLF1AOiiu8SVcVlK3tZ1mQhN8x8CG7Z4A/h2ldiK8wLHO/IpKDj6E8o+SDvZA
 sUnhufMtNZV6jnTiGaMfYK/i1W6bEmw6zVvXZ5veIgxrkRhoU7174uwDsPZ3ATKjDLfF
 bmgw==
X-Gm-Message-State: AOJu0YyvZz5byP1Ka3W/mxDAAE61ED4mdOTsy5ZMoQbSijpmtgORbxGD
 NsXfFqv5kWt3eq/NL0Rtr9+t2k5qDT3ogAr2ZZYLYx6e1cIn5uj1oGFzotc+BUez7x0+eq2DsZl
 vF0Y=
X-Google-Smtp-Source: AGHT+IGZk66rgpvU3KD2iYIJ7JXd/esIByvlYjFu8zuZKJtEVOR+ipvIxl5gmFJpTnGFU5mPRsujfg==
X-Received: by 2002:a05:6a20:a125:b0:1b7:577c:7177 with SMTP id
 adf61e73a8af0-1b7577c72e0mr6114071637.16.1718103278301; 
 Tue, 11 Jun 2024 03:54:38 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042488212dsm5605381b3a.15.2024.06.11.03.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:54:37 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] test: Remove libibumad dependence
Date: Tue, 11 Jun 2024 18:54:27 +0800
Message-Id: <20240611105427.61395-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611105427.61395-1-pizhenwei@bytedance.com>
References: <20240611105427.61395-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Remove libibumad dependence from the test environment.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 -
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 -
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 -
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 -
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 -
 tests/docker/dockerfiles/debian.docker                | 1 -
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
 tests/lcitool/projects/qemu.yml                       | 1 -
 14 files changed, 14 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 8d7d8725fb..fd5489cd82 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -49,7 +49,6 @@ packages:
   - libglusterfs-dev
   - libgnutls28-dev
   - libgtk-3-dev
-  - libibumad-dev
   - libibverbs-dev
   - libiscsi-dev
   - libjemalloc-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 16050a5058..afa04502cf 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -49,7 +49,6 @@ packages:
   - libglusterfs-dev
   - libgnutls28-dev
   - libgtk-3-dev
-  - libibumad-dev
   - libibverbs-dev
   - libiscsi-dev
   - libjemalloc-dev
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index f8c61d1191..8058695979 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:amd64 \
                       libgnutls28-dev:amd64 \
                       libgtk-3-dev:amd64 \
-                      libibumad-dev:amd64 \
                       libibverbs-dev:amd64 \
                       libiscsi-dev:amd64 \
                       libjemalloc-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6510872279..15457d7657 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:arm64 \
                       libgnutls28-dev:arm64 \
                       libgtk-3-dev:arm64 \
-                      libibumad-dev:arm64 \
                       libibverbs-dev:arm64 \
                       libiscsi-dev:arm64 \
                       libjemalloc-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index f227d42987..c26ffc2e9e 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -108,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armel \
                       libgnutls28-dev:armel \
                       libgtk-3-dev:armel \
-                      libibumad-dev:armel \
                       libibverbs-dev:armel \
                       libiscsi-dev:armel \
                       libjemalloc-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 58bdf07223..8f87656d89 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armhf \
                       libgnutls28-dev:armhf \
                       libgtk-3-dev:armhf \
-                      libibumad-dev:armhf \
                       libibverbs-dev:armhf \
                       libiscsi-dev:armhf \
                       libjemalloc-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 9f4102be8f..f1e5b0b877 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -108,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:i386 \
                       libgnutls28-dev:i386 \
                       libgtk-3-dev:i386 \
-                      libibumad-dev:i386 \
                       libibverbs-dev:i386 \
                       libiscsi-dev:i386 \
                       libjemalloc-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index c861c3bd5b..59c4c68dce 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -107,7 +107,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
                       libgtk-3-dev:mips64el \
-                      libibumad-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index fe9415395e..880c774f1c 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -107,7 +107,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mipsel \
                       libgnutls28-dev:mipsel \
                       libgtk-3-dev:mipsel \
-                      libibumad-dev:mipsel \
                       libibverbs-dev:mipsel \
                       libiscsi-dev:mipsel \
                       libjemalloc-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 35c8ff0864..1d55b9514c 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:ppc64el \
                       libgnutls28-dev:ppc64el \
                       libgtk-3-dev:ppc64el \
-                      libibumad-dev:ppc64el \
                       libibverbs-dev:ppc64el \
                       libiscsi-dev:ppc64el \
                       libjemalloc-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index bef9dff17a..62ccda6ab1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:s390x \
                       libgnutls28-dev:s390x \
                       libgtk-3-dev:s390x \
-                      libibumad-dev:s390x \
                       libibverbs-dev:s390x \
                       libiscsi-dev:s390x \
                       libjemalloc-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 63d7aac616..0d1d401eb8 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -55,7 +55,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev \
                       libgnutls28-dev \
                       libgtk-3-dev \
-                      libibumad-dev \
                       libibverbs-dev \
                       libiscsi-dev \
                       libjemalloc-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index febd25b320..beeb44fc28 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -55,7 +55,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev \
                       libgnutls28-dev \
                       libgtk-3-dev \
-                      libibumad-dev \
                       libibverbs-dev \
                       libiscsi-dev \
                       libjemalloc-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 070d7f4706..0c85784259 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -47,7 +47,6 @@ packages:
  - libfdt
  - libffi
  - libgcrypt
- - libibumad
  - libibverbs
  - libiscsi
  - libjemalloc
-- 
2.34.1


