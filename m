Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF0EC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU2n-00034J-EJ; Mon, 27 May 2024 02:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2j-0002x0-EO; Mon, 27 May 2024 02:41:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2e-0007Am-NM; Mon, 27 May 2024 02:41:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CA546A3EF;
 Mon, 27 May 2024 09:41:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B6823D83E7;
 Mon, 27 May 2024 09:40:56 +0300 (MSK)
Received: (nullmailer pid 50261 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 01/19] gitlab-ci: Remove job building EDK2 firmware
 binaries
Date: Mon, 27 May 2024 09:40:32 +0300
Message-Id: <20240527064056.50205-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When we introduced this Gitlab-CI job in commit 71920809ce
("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries"),
the naive plan was to have reproducible binaries by downloading
what this job would build, testing it and eventually committing
it. With retrospective, nothing happened 3 years later and this
job is just bitrotting:

  Step 1/3 : FROM ubuntu:18.04
  18.04: Pulling from library/ubuntu
  mediaType in manifest should be
  'application/vnd.docker.distribution.manifest.v2+json' not
  'application/vnd.oci.image.manifest.v1+json'

Remove this job to avoid wasting maintenance and CI ressources.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230310133247.39268-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 690ceb71936f9037f6e11580709e26b62d83c17c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
deleted file mode 100644
index 314e101745..0000000000
--- a/.gitlab-ci.d/edk2.yml
+++ /dev/null
@@ -1,85 +0,0 @@
-# All jobs needing docker-edk2 must use the same rules it uses.
-.edk2_job_rules:
-  rules:
-    # Forks don't get pipelines unless QEMU_CI=1 or QEMU_CI=2 is set
-    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      when: never
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if any of the files affecting the build are touched
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      changes:
-        - .gitlab-ci.d/edk2.yml
-        - .gitlab-ci.d/edk2/Dockerfile
-        - roms/edk2/*
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if the branch/tag starts with 'edk2'
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_REF_NAME =~ /^edk2/'
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if last commit msg contains 'EDK2' (case insensitive)
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_MESSAGE =~ /edk2/i'
-      when: manual
-
-    # Run if any files affecting the build output are touched
-    - changes:
-        - .gitlab-ci.d/edk2.yml
-        - .gitlab-ci.d/edk2/Dockerfile
-        - roms/edk2/*
-      when: on_success
-
-    # Run if the branch/tag starts with 'edk2'
-    - if: '$CI_COMMIT_REF_NAME =~ /^edk2/'
-      when: on_success
-
-    # Run if last commit msg contains 'EDK2' (case insensitive)
-    - if: '$CI_COMMIT_MESSAGE =~ /edk2/i'
-      when: on_success
-
-docker-edk2:
-  extends: .edk2_job_rules
-  stage: containers
-  image: docker:19.03.1
-  services:
-    - docker:19.03.1-dind
-  variables:
-    GIT_DEPTH: 3
-    IMAGE_TAG: $CI_REGISTRY_IMAGE:edk2-cross-build
-    # We don't use TLS
-    DOCKER_HOST: tcp://docker:2375
-    DOCKER_TLS_CERTDIR: ""
-  before_script:
-    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
-  script:
-    - docker pull $IMAGE_TAG || true
-    - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-                                           --tag $IMAGE_TAG .gitlab-ci.d/edk2
-    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-    - docker push $IMAGE_TAG
-
-build-edk2:
-  extends: .edk2_job_rules
-  stage: build
-  needs: ['docker-edk2']
-  artifacts:
-    paths: # 'artifacts.zip' will contains the following files:
-      - pc-bios/edk2*bz2
-      - pc-bios/edk2-licenses.txt
-      - edk2-stdout.log
-      - edk2-stderr.log
-  image: $CI_REGISTRY_IMAGE:edk2-cross-build
-  variables:
-    GIT_DEPTH: 3
-  script: # Clone the required submodules and build EDK2
-    - git submodule update --init roms/edk2
-    - git -C roms/edk2 submodule update --init --
-       ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3
-       BaseTools/Source/C/BrotliCompress/brotli
-       CryptoPkg/Library/OpensslLib/openssl
-       MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
-    - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
-    - echo "=== Using ${JOBS} simultaneous jobs ==="
-    - make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log | tee -a edk2-stderr.log >&2
diff --git a/.gitlab-ci.d/edk2/Dockerfile b/.gitlab-ci.d/edk2/Dockerfile
deleted file mode 100644
index bbe50ff832..0000000000
--- a/.gitlab-ci.d/edk2/Dockerfile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-# Docker image to cross-compile EDK2 firmware binaries
-#
-FROM ubuntu:18.04
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-# Install packages required to build EDK2
-RUN apt update \
-    && \
-    \
-    DEBIAN_FRONTEND=noninteractive \
-    apt install --assume-yes --no-install-recommends \
-        build-essential \
-        ca-certificates \
-        dos2unix \
-        gcc-aarch64-linux-gnu \
-        gcc-arm-linux-gnueabi \
-        git \
-        iasl \
-        make \
-        nasm \
-        python3 \
-        uuid-dev \
-    && \
-    \
-    rm -rf /var/lib/apt/lists/*
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 691d9bf5dc..a7ed447fe4 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -4,7 +4,6 @@
 include:
   - local: '/.gitlab-ci.d/base.yml'
   - local: '/.gitlab-ci.d/stages.yml'
-  - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
diff --git a/MAINTAINERS b/MAINTAINERS
index 6966490c94..e688db1f55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3257,8 +3257,6 @@ F: roms/edk2
 F: roms/edk2-*
 F: tests/data/uefi-boot-images/
 F: tests/uefi-test-tools/
-F: .gitlab-ci.d/edk2.yml
-F: .gitlab-ci.d/edk2/
 
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
-- 
2.39.2


