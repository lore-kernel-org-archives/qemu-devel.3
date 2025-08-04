Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7477AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivsm-0005QG-OC; Mon, 04 Aug 2025 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulO-0004PD-Rf
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:04 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulN-0000UO-3Q
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3864824b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754312279; x=1754917079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/vS2KBui16zTZGJMb9su+mH6/2ju/NTf8jiWbG0wUQ=;
 b=fp6+nQA1NrprjRPdGwRTdJS3mrA1tVlJpIom9qzVZLkrHESgDTGxZQeKAzsrQ0z6up
 65vNq9d3QTvDL4wFhLSpiUoWEqiN5kyvVwVrJ+JNj04z0CIaH2WYZiDEUm9DyvRpsnAx
 Ukf244JOUmsLbP3z2mvQupvpVmLpCEPnf3XKx2sdxsfyJmwGbAaVUPgqbNyN0CYBOcvZ
 9jFk+vzH8qG3JqSJuD8Q9tkPgLgH8/WJc3jMY+ZEnRq4OtyaZ2DbwD7W7/PZKz6PcTaT
 zgspANgmX9Z91TkWlG3TM+CKez7gdW4tn+Yz5sYmEx1ISF+rQIpUYBVQlcaDL0E8lDcl
 qUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312279; x=1754917079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/vS2KBui16zTZGJMb9su+mH6/2ju/NTf8jiWbG0wUQ=;
 b=J9PElIa3zEdiNIRDXfwN1mlAUFAQt0e7qPO39f7L+Osa9dH0IUt28TN6KluEMKo/xw
 68De6vgijl27CfGCknNLxn9XGGCLuHJJHcfIYMfkWP5lQ4X0nNn/MEN8gPGp/3gzGBMq
 GFMmFVWPiPNGW1E6uyscAA33WNzp/omb5D3dcAtn5Pkla2zB5sL5C6/RhKE3Owx6ZetL
 2ogs13YrqWzJWtF96tZp/SKnW9zT+v4YOn2vMxeVHxJoZPxfY3wKlx7dOnJBb+/fDYbF
 P5+58tUc/d7BM+qxpgeh7GZNBY57T5ZlH23aXtdA4gp3DyLbolp6iDrUgg56Ys6HZBJU
 YFtA==
X-Gm-Message-State: AOJu0YxZkHts1not0gp5LYNTSeZfCqd1tI1Cj07U/O9cy1TEiGvzigMr
 6TmtMZPthHVi2B5XZbB9RmoYo2kPMjttWKUa0EhFR2CTUlklBlwe58CHwNjwMw==
X-Gm-Gg: ASbGnct4atwp9GLg9kaaGh7goAZGOvuzMV9uws2an/TP/+n+4vuOQnRVdRN3kHMliUV
 fhFMcAkF3kRDNkkYLgxS6o/svreN/Z0fCDyJ3nGf0xtLWVWeVo3xD5WXOaCdsO3i5UO+oM+O5U2
 jQV4X8gXi9HhVQ2qSjKJkJHzTU1NQXeLROn9JGV1qnYQDfMhVVn6jZ67w5J/ojrdN1SI6GnFO0k
 jLMpsOZr2EwRpC6ZsfIbtev+qMdCBssnQl6VDdrlYSrXfGNJhyleFcyPPE0ClzHgmcSrVXU3bX7
 hkKhEqMjafH67bUqJ6uJ3YwRaRuqh6upqkq/iXGPJj41BhPQA9CdFN+FT//r0cQjTxdW2mbi8bK
 ytxSlKuSc0OiTXq2bg00mSQ==
X-Google-Smtp-Source: AGHT+IFKHK7Sl5Z//6Qxf4XsoIpRfLqO6XcYwfs7ocy2SM/SYJ9jFuu8bxvO4eMHdilzduwifPWpnQ==
X-Received: by 2002:a05:6a20:2453:b0:232:cc63:45d8 with SMTP id
 adf61e73a8af0-23df8fef591mr15166968637.20.1754312278668; 
 Mon, 04 Aug 2025 05:57:58 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:d117:15e5:e721:f1cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm10488308b3a.42.2025.08.04.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:57:58 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 4/4] .gitlab-ci.d: Add build tests for wasm64
Date: Mon,  4 Aug 2025 21:57:17 +0900
Message-ID: <d3a7e2c7d5d8e5257cd7be7da79d135c43cbbc55.1754310749.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754310749.git.ktokunaga.mail@gmail.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42d.google.com
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
 .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
 .gitlab-ci.d/container-cross.yml    | 18 +++++++++++++++++-
 .gitlab-ci.d/container-template.yml |  4 +++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a60063..f45efbaae3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -787,11 +787,29 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm:
+build-wasm32:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    job: wasm-emsdk-cross-container
+    job: wasm32-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm-wasm64:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-memory64=1 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm-wasm64l:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64l-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64l-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-memory64=2 --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..1bacaff818 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -92,7 +92,23 @@ win64-fedora-cross-container:
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
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64l-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64l-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=2
+    DOCKERFILE: emsdk-wasm-cross
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383..01ca840413 100644
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
-- 
2.43.0


