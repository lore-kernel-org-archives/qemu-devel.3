Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8199BD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibP-00050Z-4D; Thu, 08 Jan 2026 00:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibN-0004zl-CU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:29 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibL-0005Gu-IN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso2460957b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850226; x=1768455026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rVsBcnPsfvmZvQdij3NSQo+uhfcRf83AZzrXvhkPZQ4=;
 b=Fl/rbIS7gClwzJPXqC4kV49ShQ8LLxiand1uDuJNazjWPp6NZRYYgem7GTy9ccHsSj
 3T3A/s29zgzWF0KRv15Vu1oaOkUj0L5wSuZkRjpZi/vPjxpiu0X58yuf9YnK/pGy7aJr
 IsYZageHnQdmuiyjUxYCy0fe+8I5jgJQ7pLMSqJvs2Rq0ZsrEtIpm+WV/1BObfMK9QGJ
 6PPvYdkVjXfzbIufmHoKwjoqnrTyMZ0lgLN8Q78d0AW60uEn9sjFpsoIZ8OZzdvfPTQW
 9byyej2aIta+jbhSCm8ldscfOESYRzUQXVJa5KANRuYIRIag7Kdv9kg9ceqLrijOy5O5
 wyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850226; x=1768455026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rVsBcnPsfvmZvQdij3NSQo+uhfcRf83AZzrXvhkPZQ4=;
 b=OsH4gqQAKPtLe9/9pBRR1oVuX1mJJEOkwFUSsm2fG6qMn1rXPqAnJVqWRfbZKp7JgS
 H24xofC3uRTlEtVxlbhSpzyWO6iqWFHoGX6k19KxuGvCNZx4oc+jbTl2fR/H54Z0mqBg
 NxmD+XdUNniWQs9cpax0n1ek7KIp95uX/suil1CZ2yeUI5fcpZFcu4kgByi9VFzJYOs1
 rFJXzheh4kAUfa1ocJNac8lrftB0zYyYMb4/op5o9AKapdgpmnWDW8G6bkW8+2FWr5PL
 qvkGgP0TLUUoeKukS4C4KhFoWmATuAMajvFgUs3Stsctlpx+N82aTq9JZffVzfS7AYM2
 lJQw==
X-Gm-Message-State: AOJu0Yxxf07CsAqO6fVqYjjUB1tPo0RQGK+5Az0eQNKfWU03USIB/Ezf
 tdFF6hC/uvdEN6p43HKeYwFcnrUu1U3M8sEFZLgpedcm8E3/ImS8Hw/24+tTaEaafo1x78QTKDb
 T7oZHVb8=
X-Gm-Gg: AY/fxX7Zv/J8D0TgqWjXVuKyXhlPb4HgIGsYFcjmwyZd6iVUxldT+NRGIoOlx/IskMn
 9Nvvrt3TE9UauhkkkkuXiEjd3sACq+7j+xpT0iQy8L8Ba6F/OefI5m5KsU3SzVDYloxu1UhnqF/
 R20mApQB/UT4DITI2sF2CZAddPhKQqJC7dO8Ea4+Dco7SOLrYHu1JX0jhJk2CDDyCA4Va/VGWRa
 YMYKE6DIuGymkQRdnHmftsDkSqeJ5yAWDqxlE2FNvB9g8tGgWQL5lzqGEHn3250iw0VK7VcVV2Q
 3JJpwhDJ4vvsxHF879V/kg2oBgEyjsW8IZ4chfscZJrEcSK7S/IYu3fEYjNk+hk4339EE5zfJko
 JiatIfPUbKJsUt82CqYdfRRYqrX7yP9/CH9xz4kIQxaPv6mmFBkfyD1KPoKlPBj74Nzv6WWiVAw
 o4rBtqsNcIH0maOKeuiQ==
X-Google-Smtp-Source: AGHT+IGYEvbXQjjeOaWhwde2tqnDDR1eqrV2JkhTPk6CCGLAAnjFhk+Qf0D+NXWgQkb727VRojjm6Q==
X-Received: by 2002:a05:6a20:6a2b:b0:366:14ac:e1dc with SMTP id
 adf61e73a8af0-3898f9db6f7mr5113319637.66.1767850225673; 
 Wed, 07 Jan 2026 21:30:25 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/50] gitlab: Remove 32-bit host testing
Date: Thu,  8 Jan 2026 16:29:29 +1100
Message-ID: <20260108053018.626690-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

These deprecated builds will be disabled.
Remove testing of armhf, i686, and wasm32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml | 27 -----------------
 .gitlab-ci.d/buildtest.yml          |  9 ------
 .gitlab-ci.d/container-cross.yml    | 17 -----------
 .gitlab-ci.d/containers.yml         |  3 --
 .gitlab-ci.d/crossbuilds.yml        | 45 -----------------------------
 5 files changed, 101 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d866cb12bb..9c2ae39ddd 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -123,30 +123,3 @@
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_FUNCTIONAL: 1
-
-.wasm_build_job_template:
-  extends: .base_job_template
-  stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - section_end setup
-  script:
-    - du -sh .git
-    - mkdir build
-    - cd build
-    - section_start configure "Running configure"
-    - emconfigure ../configure --disable-docs
-          ${TARGETS:+--target-list="$TARGETS"}
-          $CONFIGURE_ARGS ||
-      { cat config.log meson-logs/meson-log.txt && exit 1; }
-    - if test -n "$LD_JOBS";
-      then
-        pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
-      fi || exit 1;
-    - section_end configure
-    - section_start build "Building QEMU"
-    - emmake make -j"$JOBS"
-    - section_end build
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index dfe954fe3c..1d4b8a030a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -784,12 +784,3 @@ coverity:
       when: never
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
-
-build-wasm:
-  extends: .wasm_build_job_template
-  timeout: 2h
-  needs:
-    - job: wasm-emsdk-cross-container
-  variables:
-    IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0fd7341afa..044795d9ff 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armhf-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armhf-cross
-
 hexagon-cross-container:
   extends: .container_job_template
   stage: containers
@@ -40,12 +34,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-i686-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-i686-cross
-
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
@@ -85,8 +73,3 @@ win64-fedora-cross-container:
   extends: .container_job_template
   variables:
     NAME: fedora-win64-cross
-
-wasm-emsdk-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: emsdk-wasm32-cross
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f7d3e7205d..222522ca16 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -47,10 +47,8 @@ weekly-container-builds:
     - amd64-debian-user-cross-container
     - amd64-debian-legacy-cross-container
     - arm64-debian-cross-container
-    - armhf-debian-cross-container
     - hexagon-cross-container
     - loongarch-debian-cross-container
-    - i686-debian-cross-container
     - mips64el-debian-cross-container
     - ppc64el-debian-cross-container
     - riscv64-debian-cross-container
@@ -58,7 +56,6 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm-emsdk-cross-container
     # containers
     - amd64-alpine-container
     - amd64-debian-container
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 99dfa7eea6..59ff8b1d87 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armhf-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: armhf-debian-cross-container
-  variables:
-    IMAGE: debian-armhf-cross
-
 cross-arm64-system:
   extends: .cross_system_build_job
   needs:
@@ -30,44 +23,6 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
-cross-i686-system:
-  extends:
-    - .cross_system_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    EXTRA_CONFIGURE_OPTS: --disable-kvm
-    MAKE_CHECK_ARGS: check-qtest
-
-cross-i686-user:
-  extends:
-    - .cross_user_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    MAKE_CHECK_ARGS: check
-
-cross-i686-tci:
-  extends:
-    - .cross_accel_build_job
-    - .cross_test_artifacts
-  timeout: 60m
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
-    # Force tests to run with reduced parallelism, to see whether this
-    # reduces the flakiness of this CI job. The CI
-    # environment by default shows us 8 CPUs and so we
-    # would otherwise be using a parallelism of 9.
-    MAKE_CHECK_ARGS: check check-tcg -j2
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


