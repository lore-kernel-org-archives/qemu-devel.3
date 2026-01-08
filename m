Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4C3D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtYb-00012t-BQ; Thu, 08 Jan 2026 12:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYa-000109-0G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYY-0000Jq-7s
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:19 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so40087185ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892337; x=1768497137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ty2GcWIekY1X+M6y7u9gB/HftapcTxph5C6KB8kF90=;
 b=AtJb157nXfbLKRdivlAu9kMgKfsvMtTO7ArZ67ZvxMoKKXPS1jK/y2hNOgQQPICbvw
 vDELHuN5pfa5ff8ygWuIfHiwaels1H7Eh9uerW0pRQ0wSXfJO62bb/Q1Rb5ARE96rUFb
 LLGXLSyRR8ahrLhx70EfWV1rVnm9WBcD2LT2j3FfVCrNhZRXszqWbymjltPvJ7JscoLq
 sVtQ5agjo0EFkY5wlKXDi3s+xuIHKe9SS7Ti4l3u6law3/1ITKhz9JUHrpzZzUtrfMfJ
 BbIeIT9D4YOt0ZGAZKhki9vgiINxdEDFtB0REIMPa+TZlu33aYlnF81wcr5GM6tWFU/q
 57aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892337; x=1768497137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ty2GcWIekY1X+M6y7u9gB/HftapcTxph5C6KB8kF90=;
 b=PeU9cjdQRzZyaHNCyw/fW/P/I/fgT4WVf0iGxFv87J6BwKxgh8AkdyuKIF/TyQWfS1
 /jZrIQi7oXSvxd8YI8HYGlix0n0VZp+5MCy8+ykwq8+Fqyj9wJ0anyIN/jKgB1j9QI3Q
 HpKRGOq9DlDAcT8NJw5RGVK1cLJKjuCNzZvRHnZSCfKEkkcRFov0SazFq2JzNDagODIF
 1inupKykMJMvJMxu3IVihM0QLz2oXruN/xIzbL+4nis0TeFOCxkxVbYFGCr109Mtdm6J
 JC6QGuDBXY5Gf89Gxls2WhOsGvvX1TlyFU4Xlm8nCYzhusoy1fMnRxqx4G29LEdvcXOV
 kyDg==
X-Gm-Message-State: AOJu0YyAowPFbwMyV6ORRaa1IlAZKmF/7bs0fJ+n0uOyIDuBEfYkVTwH
 k6jQZPrmnmuKWLRIe0OzOOJzYSMbJ588GGeBwjzwXWkNOlYazODRP+f23PvFvf4G
X-Gm-Gg: AY/fxX45jKM/1NvuxcpvhIuwGHABU+6hlgoiUHnVi+OqLqUKx/GKn4ZTj61wakIq+Ai
 bmU1uiIhoeD0wsoHAsxEDn8tVhm0WWOwALdAojQ6IfcgqMRYfzIXWO7alHgv8YnUmsI2Bu1OW1P
 Qj2hkzg6r81EFsMZDQ3m1j7bq2rGQ3XhqLCnXQk5a292X8lqUrbau7+o6jx9I/eh5l+KRiucA+f
 nMYWG7So7loLV65WK0Wnlr863WWVGQPrYQ+DZ0auOKZ4vQiLsZHO73myB1Aa2ASBzRCt2QpJK/U
 7R9q9htyGB524xV2aehcXeGnHzgHjTQpHh34yoSZK3FYOqM8+uXIl9M6VCCm5Y/iI0pFduaSXE1
 9eQjXlL7LH7Ul7wua4fTWTthP2nsmukGMP2CDBTh8ywhyuJxbpQ4+oy6FqsIhFlMam69j3KJrsQ
 AnzntfRvooIQ==
X-Google-Smtp-Source: AGHT+IGw6oD1wjGPHOMnWc+b5aFt2Tx2TRkZqr2Uz8EdzmmLEZtBhXS0DPrT4h+4M6eI+zgUFLZKuw==
X-Received: by 2002:a17:903:298b:b0:2a0:d5bf:b271 with SMTP id
 d9443c01a7336-2a3ee486f81mr63992945ad.32.1767892336857; 
 Thu, 08 Jan 2026 09:12:16 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:7ace:63ca:408f:4cc4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm82808355ad.3.2026.01.08.09.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:12:16 -0800 (PST)
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
Subject: [PATCH v4 4/4] .gitlab-ci.d: Add build tests for wasm64
Date: Fri,  9 Jan 2026 02:11:28 +0900
Message-ID: <79ec37f7fa0352d0463ed6ec5496f6a88f47d111.1767886100.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767886100.git.ktokunaga.mail@gmail.com>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
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

The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
(emsdk-wasm-cross.docker) with different build args.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml          | 26 ++++++++++++++++++++++----
 .gitlab-ci.d/container-cross.yml    | 20 ++++++++++++++++++--
 .gitlab-ci.d/container-template.yml |  4 +++-
 .gitlab-ci.d/containers.yml         |  4 +++-
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index dfe954fe3c..98bf28488c 100644
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
+    - job: wasm32-32bit-emsdk-cross-container
   variables:
-    IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    IMAGE: emsdk-wasm32-32bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-64bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-64bit-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-64bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-32bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-32bit-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-32bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0fd7341afa..66fc7343e2 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -86,7 +86,23 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm-emsdk-cross-container:
+wasm32-32bit-emsdk-cross-container:
   extends: .container_job_template
   variables:
-    NAME: emsdk-wasm32-cross
+    NAME: emsdk-wasm32-32bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-64bit-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-64bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-32bit-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-32bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=2
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
index f7d3e7205d..ae99e0a541 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -58,7 +58,9 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm-emsdk-cross-container
+    - wasm32-32bit-emsdk-cross-container
+    - wasm64-64bit-emsdk-cross-container
+    - wasm64-32bit-emsdk-cross-container
     # containers
     - amd64-alpine-container
     - amd64-debian-container
-- 
2.43.0


