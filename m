Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26ACD47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghr3-0007eV-Ep; Fri, 16 Jan 2026 06:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghr1-0007Tw-Qq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghr0-0005nU-3e
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:59 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso10168935e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562336; x=1769167136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0NDegptD8d1Zx0ptc1ByVU7iaPP5/DQ14N5L2MLvo1s=;
 b=K9E39UDS3oeGeGCy9/KzIN4wLB8E+TtaDA8XT1lflabOtPeQe6lIRSxvof8s6giNr0
 XwtGkENqsBg96+yDaF1k4SYhU8LiJ6tZPcdz0xCqpJfFnqpysQNUksTPbfFMZvU9le09
 jlIMs7P8w7rpj8FcYCkpSR3rpbvrOf6dTzLSCPcNB7d3Twyn0A3E7FrpZwti0M6raA9H
 WcDfD4FZ5qcd+/weaW/bq659/YRHbTI07ZdjB8jcEhwGC8UlI6xZI5Vdfz7qSSrV5PoY
 bagrM5fw5O7GrccVpvVOGYNW7M2sdOd5q/LFcU8ATBskaSPiKZvnOwvOuKgeX9qiJR/D
 EDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562336; x=1769167136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0NDegptD8d1Zx0ptc1ByVU7iaPP5/DQ14N5L2MLvo1s=;
 b=L1ee+rBtbvds+Osez6vdxW3ZfgY6so+bgx5AogRITqznd8OGpOmtpNnzeTQ2W56SaO
 PseZamUPpVji1465JhAsjGPMq2/oj4obvXCKfpQXt3jwsUFMD+39OP29hAJHli8IO8Js
 t1jPbrnJ6crGw1ax/TlbTlB2f/f2CJySWiNVavXGvXymBdGf0XSv5GbuJY6SUR2SswSq
 sf/UEdf5pu7OFFc+VPx7uhJrCKev/40gzE3q++cGVzjfg25NSA/Ak7bRmH88AZ0MlfsB
 Pw1YTrgNQNB+rtBiMBGywwYRTzbDp2RGQTa/U6WzWI6LqYuRA/GlKcZx3A+VRx+TTA6F
 QUJw==
X-Gm-Message-State: AOJu0YxjT0hhZyHDRCmXM5GcivY8UTA+5WEh/aXd5e1YTVY6Cf2UTixu
 DK1W7r4DZfaljH7n4dg8QjyMTYB+vLczZ2MPNMMk6i9IFoEq1ZDXZ2uukQKou9e3nntIIGUmab4
 PYQjbtzA=
X-Gm-Gg: AY/fxX7l5dAOpbBJpzBfKU8jWvoX4mvW7yNDSlUZWXlMO0vzVMOk2EnYxAHJpGHnvI2
 FRQzVY8jQRpOnC26ozS0NCIgcHvTFGLzCGErrwAWLM+ZH0BqO4Cyf4s2qL0u6zE7VIwXKrOB05L
 ZfU6zJYEMs8q30S9ckNSJEnmoqNwHccHj5nl7BbSfaviIzFgcbU3YVaBnoNe87gUYkGq2avXPwz
 DJZgoCpN2hRyr0hUMtlA8TxYX4eOHHs4Sf7sc6FQHzRhLupZ0k9nC8XZhrQmG6y8mH84rf2mXsV
 P1VH741zsudiPzCxyBuvmQUPwRIOFU/VHhBR9KWoKvoq6SFeEZTW8HDVS7/2m011fvEOY8uckYP
 rdU+5IzxNEZhmHEchJBfvY5Kk2qNjflwnYG+AYjLNgN9tgZxdiSETth7b6VjugAuwJDi1+4uuNa
 wVMvpXgEu/b5AuWa2rKDGe1F9TgUhbKKaWunZexQLcYc6TMELnE64alq5eUU9z
X-Received: by 2002:a05:600c:37c8:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-4801eb0d71cmr23604365e9.25.1768562336027; 
 Fri, 16 Jan 2026 03:18:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c2a2sm13863985e9.10.2026.01.16.03.18.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/30] gitlab-ci: Add build tests for wasm64
Date: Fri, 16 Jan 2026 12:17:44 +0100
Message-ID: <20260116111807.36053-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
(emsdk-wasm-cross.docker) with different build args.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee30d4956a485fd46b4735028486d3fb7b22fe60.1768308374.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
 .gitlab-ci.d/container-cross.yml    | 11 ++++++++++-
 .gitlab-ci.d/container-template.yml |  4 +++-
 .gitlab-ci.d/containers.yml         |  3 ++-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index dfe954fe3ce..ea0f5bb0574 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -785,11 +785,29 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm:
+build-wasm32-32bit:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    - job: wasm-emsdk-cross-container
+    - job: wasm32-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-64bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-32bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0fd7341afac..7022015e956 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -86,7 +86,16 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm-emsdk-cross-container:
+wasm32-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm32-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64
+    DOCKERFILE: emsdk-wasm-cross
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 82c1b69e8dd..b92e96b0fc5 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -10,12 +10,14 @@
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
     - until docker info; do sleep 1; done
+    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
   script:
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
     - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
       --build-arg BUILDKIT_INLINE_CACHE=1
-      -f "tests/docker/dockerfiles/$NAME.docker" "."
+      $BUILD_ARGS
+      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
     - docker push "$TAG"
   after_script:
     - docker logout
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f7d3e7205dc..dde9a3f840f 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -58,7 +58,8 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm-emsdk-cross-container
+    - wasm32-emsdk-cross-container
+    - wasm64-emsdk-cross-container
     # containers
     - amd64-alpine-container
     - amd64-debian-container
-- 
2.52.0


