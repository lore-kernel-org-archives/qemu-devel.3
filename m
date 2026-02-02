Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6E5E7FDC2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzt2-0000Ev-6B; Mon, 02 Feb 2026 14:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzst-0000CR-P4; Mon, 02 Feb 2026 14:46:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsq-0003CY-5H; Mon, 02 Feb 2026 14:46:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B650C185095;
 Mon, 02 Feb 2026 22:46:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6408B35B277;
 Mon, 02 Feb 2026 22:46:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 03/69] gitlab: move custom runners to Ubuntu 24.04
Date: Mon,  2 Feb 2026 22:45:26 +0300
Message-ID: <20260202194638.939438-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-7-alex.bennee@linaro.org>
(cherry picked from commit eafc5f69e621725dcdcedcc1955d820af7abfc82)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 1aa3c60efe..f6330c1614 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -29,6 +29,6 @@
       junit: build/meson-logs/testlog.junit.xml
 
 include:
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
similarity index 78%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
index 8727687e2b..75029c9187 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-aarch32-all:
+ubuntu-24.04-aarch32-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch32
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
similarity index 89%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index ca2f140471..d26c7827f4 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-aarch64-all-linux-static:
+ubuntu-24.04-aarch64-all-linux-static:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -23,12 +23,12 @@ ubuntu-22.04-aarch64-all-linux-static:
  - make check-tcg
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-all:
+ubuntu-24.04-aarch64-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -45,12 +45,12 @@ ubuntu-22.04-aarch64-all:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-without-defaults:
+ubuntu-24.04-aarch64-without-defaults:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -67,12 +67,12 @@ ubuntu-22.04-aarch64-without-defaults:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-alldbg:
+ubuntu-24.04-aarch64-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -86,12 +86,12 @@ ubuntu-22.04-aarch64-alldbg:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-clang:
+ubuntu-24.04-aarch64-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -108,11 +108,11 @@ ubuntu-22.04-aarch64-clang:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-tci:
+ubuntu-24.04-aarch64-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -128,12 +128,12 @@ ubuntu-22.04-aarch64-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc --ignore=40`
 
-ubuntu-22.04-aarch64-notcg:
+ubuntu-24.04-aarch64-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
similarity index 88%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index ca374acb8c..6f6bea41cf 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-s390x-all-linux:
+ubuntu-24.04-s390x-all-linux:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -21,12 +21,12 @@ ubuntu-22.04-s390x-all-linux:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-all-system:
+ubuntu-24.04-s390x-all-system:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  timeout: 75m
  rules:
@@ -40,12 +40,12 @@ ubuntu-22.04-s390x-all-system:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-alldbg:
+ubuntu-24.04-s390x-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -63,12 +63,12 @@ ubuntu-22.04-s390x-alldbg:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-clang:
+ubuntu-24.04-s390x-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -85,11 +85,11 @@ ubuntu-22.04-s390x-clang:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-tci:
+ubuntu-24.04-s390x-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -105,12 +105,12 @@ ubuntu-22.04-s390x-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
-ubuntu-22.04-s390x-notcg:
+ubuntu-24.04-s390x-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-- 
2.47.3


