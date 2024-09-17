Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F55CAC593
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqchx-0005mM-7E; Tue, 17 Sep 2024 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchM-0003CM-0m; Tue, 17 Sep 2024 14:13:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchK-0002vR-7h; Tue, 17 Sep 2024 14:13:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5CDBA8FBFE;
 Tue, 17 Sep 2024 21:12:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DDAF413E75E;
 Tue, 17 Sep 2024 21:13:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 70/82] gitlab: migrate the s390x custom machine to 22.04
Date: Tue, 17 Sep 2024 21:12:44 +0300
Message-Id: <20240917181256.634732-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alex Bennée <alex.bennee@linaro.org>

20.04 is dead (from QEMU's point of view), long live 22.04!

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240426153938.1707723-3-alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 108d99742af1fa6e977dcfac9d4151b7915e33a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index a0e79acd39..29e52df283 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -29,7 +29,7 @@
       junit: build/meson-logs/testlog.junit.xml
 
 include:
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
   - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
similarity index 88%
rename from .gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index cdae6c5212..85e2809573 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -1,13 +1,13 @@
-# All ubuntu-20.04 jobs should run successfully in an environment
+# All ubuntu-22.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 20.04/20.04"
+# "Install basic packages to build QEMU on Ubuntu 22.04"
 
-ubuntu-20.04-s390x-all-linux-static:
+ubuntu-22.04-s390x-all-linux-static:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -23,12 +23,12 @@ ubuntu-20.04-s390x-all-linux-static:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-all:
+ubuntu-22.04-s390x-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  timeout: 75m
  rules:
@@ -42,12 +42,12 @@ ubuntu-20.04-s390x-all:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-alldbg:
+ubuntu-22.04-s390x-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -65,12 +65,12 @@ ubuntu-20.04-s390x-alldbg:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-clang:
+ubuntu-22.04-s390x-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -87,11 +87,11 @@ ubuntu-20.04-s390x-clang:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-tci:
+ubuntu-22.04-s390x-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -107,12 +107,12 @@ ubuntu-20.04-s390x-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
-ubuntu-20.04-s390x-notcg:
+ubuntu-22.04-s390x-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-- 
2.39.5


