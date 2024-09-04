Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD6BCD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr7s-0002F1-G1; Wed, 04 Sep 2024 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7k-0001kI-Df
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7i-0005Ee-NB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so55284255e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460601; x=1726065401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odGoqcjooDH+2T5GeNHtTqagY4hAIjBCQzv56YGeYY8=;
 b=n410qmWGstu8RUbQfVKzmQigZ0+OjboC+7R8hoAg0dAPh1s1l249AMgzxqdccNRtVh
 Q50cjihgufSMI+R3FG6ZgzmQRJAjbmobnTtHZFQ44dzKKgGG0EAtJoHXArzWD0CA1fAk
 aI1fpw8BVAIZmQ3hklOVMVjdRy9SkNzURSrlZWOBzzm5/6ROae9QboDH83jRP00iN4Fy
 NTyQwLHmu4tFKJbdMK8tHKLjI2rzBRRkgAZS/rb5wopYRdmyTsx3Zi5mWKMJgAiMcw+8
 wLcTAPBRm2vNSIUZFlZuCooZwGXLsr16+uGz9tN/rTbXOgYYCofO1qiv9JOWIIMh5JP7
 UcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460601; x=1726065401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odGoqcjooDH+2T5GeNHtTqagY4hAIjBCQzv56YGeYY8=;
 b=e325ZTkVaMbNPCyP+BKgEj4ayBiqkp0SuMCrAGO6bOiRR2G7x9xJE+IJJb08KhPwuO
 cnIFj5EgBsh45miDTP9U/BEOCwaNFeHh9LFDGWIOBWzyxtnefYXjo/lJaXASHj+YMAlp
 UAX8o8jLNgbmVMpw5P665Wuq07VmcbFUG25xJpt4MypQDVJI+QUQsnxlfxpTwGl4PJbR
 GpXFGMAmdGROWPfme6szHlkSNPtRiRmhI1R+j90cL572GtJQ6dR+U4iqSN93LYM9/+qM
 TB60zEBsMKuNYQvupGKQ/wizYh9YoxasEH2fF39VGzitr8f6OcoaTwwNY7XlHTmd1YYC
 og7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWansfub0wSbjKMQwgq63uzOTBNf5O+2tYtDtm6sHpgqqkADqYnAIIq+znzh9zznXVQQ1ffTvS+P71c@nongnu.org
X-Gm-Message-State: AOJu0YwU9naMu5k4AvYVOaLcGNfzsGWpneJwS+iEJDOyqmoJ8QrUO1a6
 Hj1KolevJoFsLJndAYd7aUK6HpApwSTi29VHYNSadudK7OBHi4NCK55XfyVAx6w=
X-Google-Smtp-Source: AGHT+IHHsK3Emaesn5x4+YFJJpIdkcMu3wkRRCF16i6g1bR3qTpII6FDmOfS27y+o3iYIInQNoEpWQ==
X-Received: by 2002:a05:600c:1c0d:b0:429:994:41ae with SMTP id
 5b1f17b1804b1-42c7b59e84cmr86875595e9.2.1725460601197; 
 Wed, 04 Sep 2024 07:36:41 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42baa08d9f9sm230902095e9.32.2024.09.04.07.36.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:36:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/15] buildsys: Remove CRIS cross container
Date: Wed,  4 Sep 2024 16:35:51 +0200
Message-ID: <20240904143603.52934-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

We removed the cross compiled CRIS tests in the previous commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                                         |  4 ----
 .gitlab-ci.d/container-cross.yml                  |  5 -----
 tests/docker/Makefile.include                     |  1 -
 tests/docker/dockerfiles/fedora-cris-cross.docker | 14 --------------
 4 files changed, 24 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker

diff --git a/configure b/configure
index d08b71f14b..4cf8be9eeb 100755
--- a/configure
+++ b/configure
@@ -1250,7 +1250,6 @@ probe_target_compiler() {
     aarch64) container_hosts="x86_64 aarch64" ;;
     alpha) container_hosts=x86_64 ;;
     arm) container_hosts="x86_64 aarch64" ;;
-    cris) container_hosts=x86_64 ;;
     hexagon) container_hosts=x86_64 ;;
     hppa) container_hosts=x86_64 ;;
     i386) container_hosts=x86_64 ;;
@@ -1309,9 +1308,6 @@ probe_target_compiler() {
         container_image=debian-armhf-cross
         container_cross_prefix=arm-linux-gnueabihf-
         ;;
-      cris)
-        container_image=fedora-cris-cross
-        ;;
       hexagon)
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e3103940a0..78c8d2faa8 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -96,11 +96,6 @@ xtensa-debian-cross-container:
   variables:
     NAME: debian-xtensa-cross
 
-cris-fedora-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: fedora-cris-cross
-
 win64-fedora-cross-container:
   extends: .container_job_template
   variables:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 708e3a72fb..681feae744 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -117,7 +117,6 @@ docker-image-debian-microblaze-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docke
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
-DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
 # images that are only used to build other images
 DOCKER_VIRTUAL_IMAGES := debian-bootstrap debian-toolchain
diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
deleted file mode 100644
index 97c9d37ede..0000000000
--- a/tests/docker/dockerfiles/fedora-cris-cross.docker
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Cross compiler for cris system tests
-#
-
-FROM registry.fedoraproject.org/fedora:33
-ENV PACKAGES gcc-cris-linux-gnu
-ENV MAKE /usr/bin/make
-RUN dnf install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.45.2


