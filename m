Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF21C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qs-0002hL-4J; Thu, 09 Jul 2026 22:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qp-0002OU-92
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:39 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qn-000085-3J
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso248072a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652256; x=1784257056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tVXtzp8EiFVmX56k6n8PIZXR48Bl6UjJaC1CchHDRLY=;
 b=M2H6MN2SJ6vlJJ/9lPHVuXtv8gwyEUqlEQYwCNRDBe1y1bPu6+F7RmxTRXLmC1xdmC
 vmYHc0pg9femiezFYdqVvYzlTX4BwiDTvinA48tMmI1wrar88K8ye9rJ/ZHl7lGLCxdS
 UEnA5+htWOfc0rC3B4bjsbTnSrUaCqhsq7yrzbxJsVk0j90bs1l2qb6+KThUtSTf/5Ee
 zCjFvdoiFZ5IpkSDJW3UqxQa46jBmYqgMoEVu/fnNBp1KcMk28K50jgzO4ob3qC6xvbt
 Wk/E+52scw6JUE78n3g42ipFEMSGL0OMXIWe7dkzRcxbcWK8/Jryxx8WbFVqRGfANd8z
 3DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652256; x=1784257056;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tVXtzp8EiFVmX56k6n8PIZXR48Bl6UjJaC1CchHDRLY=;
 b=MKhw51rN4k32DjcjU3+9IBVHIALYLqjQDngcr7x16wkeQvlAc6hn1UwWsilyqFFtWr
 GeHTpbPjUiV9tehnt5995CJQeon9gPnA+Jp2PIbhzuAKzf5TYG8M/ByHOtoHMVJZ5MbF
 1M2aYKPkPYZBSqLmI+SPDe+6Tg/FKFuhF5EE/iueY9o/firnsAhiiuFWgYjIdH+bg3jd
 Krt7+hXjfD5i6p9cirEZoPWTvxliJ5XgpKOf8jnnFOPQGXjlTtcALByJ2sMiBa4Nlrvj
 N3v3gFsfO6YLhQjsUQL58V6W6ugaPo9OyHFJpwRUs8TkqHISFjHzEiJwHHr0xfiBZW42
 Vk6Q==
X-Gm-Message-State: AOJu0YwFra9uZzF5d4p3uNnCKic4PVoasnaH4xh4IoXpaAnETp1HmMGA
 +af+nP4u6gAKDlldq6r9XHZI6rJW6j9bl4vs2CCQmW4z4w/S1ZMlyeNhTST+2Q==
X-Gm-Gg: AfdE7cne6wu8ETu+qedTUBVFzXxpeni/gwk/4mS7aKKwkB4F4LK3/u0P51Fx+LlT1wL
 9JUsPshvH1UFBy0HL+Zpk3DSBUWY7wWABu8RbO5ldl6KjMaOirx1A2LOyP2YqnaGuFFYvyWiOhp
 9bpXNPfxFe7L2iETzzQbeNMHuLwGivbuiOCKKhu27U5TgZGPPHGWu1SLbDZ/rWkIz1O6vOi+1ZF
 Dd7FWmJK2lGWbsHVBuk4mjcA7RmUnYWAw1i5HxWqdXqnKljio/hkauAw4yvP+9a902OBM8Y3UCf
 kkkxQjV9VKZ0JXW62HJvQ5TFG83DGpfpmIUCoXQrQUzyzVhbBo/3m8h5d+e7kikzwqPhlNoGrpa
 GzqgGbnV0Q1kGuDT2kbAKf1ea2W6xrn20e0QkyqI5LKZaMt7xm1DY2GsF1VHi/gKXr2QLng1TUX
 yvunXW1oxw+JRCpfBJqSRuQ3J8mJU/DaY=
X-Received: by 2002:a05:6a21:485:b0:3bf:5ff5:2b0f with SMTP id
 adf61e73a8af0-3c0bce1ec42mr10855280637.12.1783652255594; 
 Thu, 09 Jul 2026 19:57:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 37/40] gitlab-ci: Remove job building OpenSBI firmware binaries
Date: Fri, 10 Jul 2026 12:55:22 +1000
Message-ID: <20260710025525.1704417-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Bin Meng <bin.meng@processmission.com>

The OpenSBI firmware build job follows the same pattern as the EDK2 job
[1] that was removed earlier [2]: it exists to produce firmware binaries
from CI artifacts, but those outputs are not consumed by the tree.

Remove the job definition and its project include to avoid maintaining
bitrotting container and firmware build logic.

[1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
[2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")

Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260706161716.29488-1-bin.meng@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                     |  2 -
 .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
 .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
 .gitlab-ci.d/qemu-project.yml   |  1 -
 4 files changed, 125 deletions(-)
 delete mode 100644 .gitlab-ci.d/opensbi.yml
 delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..e25df9493c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4127,8 +4127,6 @@ R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
-F: .gitlab-ci.d/opensbi.yml
-F: .gitlab-ci.d/opensbi/
 
 Clock framework
 M: Luc Michel <luc@lmichel.fr>
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
deleted file mode 100644
index 42f137d624..0000000000
--- a/.gitlab-ci.d/opensbi.yml
+++ /dev/null
@@ -1,88 +0,0 @@
-# All jobs needing docker-opensbi must use the same rules it uses.
-.opensbi_job_rules:
-  rules:
-    # Forks don't get pipelines unless QEMU_CI=1 or QEMU_CI=2 is set
-    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      when: never
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if any files affecting the build output are touched
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      changes:
-        - .gitlab-ci.d/opensbi.yml
-        - .gitlab-ci.d/opensbi/Dockerfile
-        - roms/opensbi/*
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if the branch/tag starts with 'opensbi'
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_REF_NAME =~ /^opensbi/'
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if the last commit msg contains 'OpenSBI' (case insensitive)
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_MESSAGE =~ /opensbi/i'
-      when: manual
-
-    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
-    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
-      when: never
-
-    # Run if any files affecting the build output are touched
-    - changes:
-        - .gitlab-ci.d/opensbi.yml
-        - .gitlab-ci.d/opensbi/Dockerfile
-        - roms/opensbi/*
-      when: on_success
-
-    # Run if the branch/tag starts with 'opensbi'
-    - if: '$CI_COMMIT_REF_NAME =~ /^opensbi/'
-      when: on_success
-
-    # Run if the last commit msg contains 'OpenSBI' (case insensitive)
-    - if: '$CI_COMMIT_MESSAGE =~ /opensbi/i'
-      when: on_success
-
-docker-opensbi:
-  extends: .opensbi_job_rules
-  stage: containers
-  image: docker:latest
-  services:
-    - docker:dind
-  variables:
-    GIT_DEPTH: 3
-    IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
-  before_script:
-    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
-    - until docker info; do sleep 1; done
-  script:
-    - docker pull $IMAGE_TAG || true
-    - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-                                           --tag $IMAGE_TAG .gitlab-ci.d/opensbi
-    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-    - docker push $IMAGE_TAG
-
-build-opensbi:
-  extends: .opensbi_job_rules
-  stage: build
-  needs: ['docker-opensbi']
-  artifacts:
-    when: on_success
-    paths: # 'artifacts.zip' will contains the following files:
-      - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
-      - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
-      - opensbi32-generic-stdout.log
-      - opensbi32-generic-stderr.log
-      - opensbi64-generic-stdout.log
-      - opensbi64-generic-stderr.log
-  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
-  variables:
-    GIT_DEPTH: 3
-  script: # Clone the required submodules and build OpenSBI
-    - git submodule update --init roms/opensbi
-    - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
-    - echo "=== Using ${JOBS} simultaneous jobs ==="
-    - make -j${JOBS} -C roms/opensbi clean
-    - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
-    - make -j${JOBS} -C roms/opensbi clean
-    - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Dockerfile
deleted file mode 100644
index 5ccf4151f4..0000000000
--- a/.gitlab-ci.d/opensbi/Dockerfile
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Docker image to cross-compile OpenSBI firmware binaries
-#
-FROM ubuntu:18.04
-
-MAINTAINER Bin Meng <bmeng.cn@gmail.com>
-
-# Install packages required to build OpenSBI
-RUN apt update \
-    && \
-    \
-    DEBIAN_FRONTEND=noninteractive \
-    apt install --assume-yes --no-install-recommends \
-        build-essential \
-        ca-certificates \
-        git \
-        make \
-	python3 \
-        wget \
-    && \
-    \
-    rm -rf /var/lib/apt/lists/*
-
-# Manually install the kernel.org "Crosstool" based toolchains for gcc-8.3
-RUN wget -O - \
-    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz \
-    | tar -C /opt -xJ
-RUN wget -O - \
-    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv64-linux.tar.xz \
-    | tar -C /opt -xJ
-
-# Export the toolchains to the system path
-ENV PATH="/opt/gcc-8.3.0-nolibc/riscv32-linux/bin:${PATH}"
-ENV PATH="/opt/gcc-8.3.0-nolibc/riscv64-linux/bin:${PATH}"
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 104a147b2d..72d02bc65b 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -11,7 +11,6 @@ default:
 include:
   - local: '/.gitlab-ci.d/base.yml'
   - local: '/.gitlab-ci.d/stages.yml'
-  - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
   - local: '/.gitlab-ci.d/buildtest.yml'
-- 
2.54.0


