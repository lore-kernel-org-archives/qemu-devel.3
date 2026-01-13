Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C0D2D106
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfera-0003IY-4A; Tue, 13 Jan 2026 08:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferY-0003H8-Cf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:12 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferW-0000Ys-Pk
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:12 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so49037565ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312509; x=1768917309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAzqqltGybDf3hiQcFF6O8LjGsk9iEn7XN53fTmC7cE=;
 b=WjQVqM3JHuMdze4XdkJ+/NgGS+0dnEgyK+zzAJcr39u5bR2Hcs7oFM37PXfFKAGgTe
 Litny68r5lZnviQ4sIfomvOR4tNoVRZaxoWzIH841dJE3ZgxfUO5+ZWNS01w24sR4VXa
 KxgxflQAZ4AFvUbrTlpwP2LJJk+jItYrg+J0y5UEAz5rbUlgkCrbhV1RztJ30NBm1BxX
 FZUvT59nim+EK79B8Vpp3u99EGOUuTDfcTe16Swu9qPrh3mWVETJ4A7d9WyvcjcwogRr
 BmuPH1Oi2wLhAmJgCMfHw59rcIAJIZ4i1qmiggeSlLWMMLemme9A4+cUJIwnbq2A0ohk
 k3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312509; x=1768917309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAzqqltGybDf3hiQcFF6O8LjGsk9iEn7XN53fTmC7cE=;
 b=CNZCASqB9dacR2qCKLGfG/k8EVfvl+XEgdQHRwPKLWiOBMakrSuYNdKO7h0+//fv+A
 LbHt5C/Sil9LVr6S+WEfQKs5eB6TgYEp0JxwCxk4Mc7XxeSsedFMt7y+iAgzuV2b7zkO
 J3cZKhnZO0mpxOnlFGxdXIULvFf3Wj9VGzgyy7dbFeKLH/BxNYHMplgK6yt3DeYMPaYS
 mQuvOWgOb1Ml4a6dV9uAG22n/lEr5PECvx7O/rkOMo9gRVqpx7nRbrJ6Bxlcv2nTZ9t6
 0xlqucJgN0YPhOPKDjshD0FBUfPN8tEWydinD0u0BYujE6x92Z+aZhp+VKLdHMVDUksa
 e+xw==
X-Gm-Message-State: AOJu0YzXChzVEWLXTcl5Pvwmvf+yKYTJTqC6qrkfWnbDHqZiB5suep92
 gqYlTZ0xPlvXfCatC9qP90oKdD9sCiD6c5JLRakUyX3MVzMzcpjC+ktG/ZFUC158
X-Gm-Gg: AY/fxX7IFujdenzT2/vFfVqyZb5dxTy+FD5VStk7YvjZhhQYDeRNJXELVHTqXaQpmna
 lMiJDso0sXHbp3fRmMA9c1iPILdsfbrQAUqKhEf2zG+c9M8HP1Ux/viXhZaSKMfVaVnxBSwfC2w
 9Mg+q8u9LLInWrmcxMDBR4+Otvk85MxnBR3aAXqb/wkVk31wgkN2gt/aCx6xyVCVgif/5qtPFqy
 DNeUpAsSrg5ZdSUkr4oS2QmVQ0lz2KDyd2xPiE8jT/jRrJUUhdDnH2d4pRapLQiJXK8druvXEEn
 8tMsA1sdCTESxCGKj8ty7z/V16A2nIwYG/gDqa7jtaXobMDpD8zvai9RIsFRgHEI8ZBtZRRR/Ii
 rJHqeBcq3i5h9g4E2g0QJSWOZ3EpH6rl8G6tt3yiuThZb62eKmnuGQxx0fyymOAFBcwpFsW+DCK
 iKmr48M9xzF0R2WZRfNbXK
X-Google-Smtp-Source: AGHT+IGt3uHlDlwp6XU4sDCiBApK+KT/39h1acaj+JyY/ZSZuzLkMfohKl8/uvTDQPeBAzHKSkebig==
X-Received: by 2002:a17:903:3c30:b0:2a0:fe4a:d67c with SMTP id
 d9443c01a7336-2a3ee437a5dmr206421465ad.10.1768312509104; 
 Tue, 13 Jan 2026 05:55:09 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:eb29:7536:a39f:7476])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm38240465ad.6.2026.01.13.05.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:55:08 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 4/4] .gitlab-ci.d: Add build tests for wasm64
Date: Tue, 13 Jan 2026 22:54:31 +0900
Message-ID: <ee30d4956a485fd46b4735028486d3fb7b22fe60.1768308374.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768308374.git.ktokunaga.mail@gmail.com>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
(emsdk-wasm-cross.docker) with different build args.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
 .gitlab-ci.d/container-cross.yml    | 11 ++++++++++-
 .gitlab-ci.d/container-template.yml |  4 +++-
 .gitlab-ci.d/containers.yml         |  3 ++-
 4 files changed, 36 insertions(+), 6 deletions(-)

V5:
- Fixed wasm64 tests (build-wasm64-64bit and build-wasm64-32bit) to share
  the same wasm64 container. The build-wasm64-32bit test passes
  --wasm64-32bit-address-limit to the configure script so that the output is
  lowered to wasm32 by Emscripten's -sMEMORY64=2.

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index dfe954fe3c..ea0f5bb057 100644
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
index 0fd7341afa..7022015e95 100644
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
index 82c1b69e8d..b92e96b0fc 100644
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
index f7d3e7205d..dde9a3f840 100644
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
2.43.0


