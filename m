Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F86C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGO-0006IE-6O; Tue, 06 May 2025 11:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFl-0004oA-52
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFh-0002G7-H3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5fPcSRenOtHMz4uaGFfKiF21+jzNjvCMF1Z6vLFTkY=;
 b=BAQYOukLgzHvFMuGX4c00YURfxCvrhohvonmwuWtdGp+lhz4mE3y5nsq9cqnU/x/xKNsg4
 TcQbY+NhaK/+cEdtSJxyKizDcRAG1yNMG+bOhmJdKqTLYdPfUEZ2pb3jQk9KMH4xIW7gtO
 Qi/qXWIHRRJqRh+E/jvbFbDhMXeCGqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-46O40VfDPKGIwRLHgsBBTA-1; Tue, 06 May 2025 11:30:35 -0400
X-MC-Unique: 46O40VfDPKGIwRLHgsBBTA-1
X-Mimecast-MFC-AGG-ID: 46O40VfDPKGIwRLHgsBBTA_1746545434
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913b2d355fso1352646f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545433; x=1747150233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5fPcSRenOtHMz4uaGFfKiF21+jzNjvCMF1Z6vLFTkY=;
 b=K+AsKIm4Bh0wImC7hOCvgWcLfVSXW1p8jJ3SsLI6/HN9zKOKRoPHH8QXwiQ+oU1p9b
 8s9qbluyYC1VwT+GYLidiLcCHg/8KyUqaw9JVpMbgXhhT1U/HEax2YkIkrlfUeRU9ryY
 1U+XRNvFk7P/zzyDOPXAoEQIlJUgOkmFom+Gkrj0ow+nrJCmAYF55UnbNT4GzxtinYLE
 sodZUmh25M4lko/rT52bpsDAqUsOIoHv8dpoA4KpdZHTTRMM2yIrnI3SZR4cjwHEjh7V
 jtthyhiFy0HbRhalAabNmMgGDaRd75s7kkZQh+epIIgXuMahZwrLf9DpCVYmNnPAUTMO
 D7xA==
X-Gm-Message-State: AOJu0YyghzbnD5cBuobv6OwbLBd1pNWWafrR5hTSNv3pQ/CcpPxgZgBR
 azoFqA5/o1j618RL+Mm34mFsqHimX4DMWvsL6h3Cn3gHHuw7gcQrD4w/9WZWds7xIz6DC+Gf9LA
 XkhsXpK/17rk/vhdCewZZ2LPiG4jzZ07t8hXw6F9zZxEG7WKDMTtCkz20jwRxbI9VWEiYGbRNbZ
 kRx8Z/FArlRZzeQ9Bu81E8aNnPDkrBCdgxplbE
X-Gm-Gg: ASbGncsX4PIVHJxfcm8dU4xs0IC30kwffGyFMnk4WPqSbPPOBnWlzodcaSebuj/kvSI
 SU2fwKDlSCQEqgzX1276SbWMUsV9A3yPMN83Zps0sUt0dOl9ZkXrMbEjqWc3VrUO91RhbMgtQoZ
 uDKrh6Ezq9e0IY1+Ijkwywvw/8Y4j5he6laYWPE/ssl3Wf8xWJzrs2dVhA2xIR2TJdNqVM2YkUX
 2ZIsQ7je4o2JCmDA6X5t9HRMvRI7sRnIkP6P5Qd/NBWc1aEzJ2bIy/uGH9pmNa0ZdfpgWeUdVQX
 5u3c/f/M3XAhCxU=
X-Received: by 2002:a5d:694d:0:b0:3a0:ad65:9e6f with SMTP id
 ffacd0b85a97d-3a0ad659ec0mr2116601f8f.57.1746545433331; 
 Tue, 06 May 2025 08:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF24BlWIhKY7bxi7BtQHFkxd+Hld185O9W4/8kE11PonoIj2z+em2DOggwYbe4QNh4jrB01iA==
X-Received: by 2002:a5d:694d:0:b0:3a0:ad65:9e6f with SMTP id
 ffacd0b85a97d-3a0ad659ec0mr2116583f8f.57.1746545432962; 
 Tue, 06 May 2025 08:30:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0bb5sm13803307f8f.7.2025.05.06.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 30/30] gitlab: Enable CI for wasm build
Date: Tue,  6 May 2025 17:29:25 +0200
Message-ID: <20250506152927.222671-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Add GitLab CI job that builds QEMU using emscripten. The build runs in the
container defined in tests/docker/dockerfiles/emsdk-wasm32-cross.docker.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/ade0deb2dc65618a91755590f6729485b4001b94.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 27 +++++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml          |  9 +++++++++
 .gitlab-ci.d/container-cross.yml    |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d4f145fdb58..118371e377d 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -115,3 +115,30 @@
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_FUNCTIONAL: 1
+
+.wasm_build_job_template:
+  extends: .base_job_template
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) + 1)
+    - section_end setup
+  script:
+    - du -sh .git
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - emconfigure ../configure --disable-docs
+          ${TARGETS:+--target-list="$TARGETS"}
+          $CONFIGURE_ARGS ||
+      { cat config.log meson-logs/meson-log.txt && exit 1; }
+    - if test -n "$LD_JOBS";
+      then
+        pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
+      fi || exit 1;
+    - section_end configure
+    - section_start build "Building QEMU"
+    - emmake make -j"$JOBS"
+    - section_end build
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 431bc07d8fb..248aaed1370 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -792,3 +792,12 @@ coverity:
       when: never
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
+
+build-wasm:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm32-cross
+    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e45ea17cf15..8d3be53b75b 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -91,3 +91,8 @@ win64-fedora-cross-container:
   extends: .container_job_template
   variables:
     NAME: fedora-win64-cross
+
+wasm-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm32-cross
-- 
2.49.0


