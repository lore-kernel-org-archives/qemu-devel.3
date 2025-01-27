Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48DEC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgUX-0008B2-0G; Tue, 28 Jan 2025 02:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgU7-0006zY-6y; Tue, 28 Jan 2025 02:58:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgU5-0000sk-DG; Tue, 28 Jan 2025 02:58:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACA05E1AF6;
 Tue, 28 Jan 2025 10:54:25 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 27ADF1A62DD;
 Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id E5BC252051; Tue, 28 Jan 2025 10:54:50 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 21/45] .gitlab-ci.d/cirrus: Remove the netbsd and
 openbsd jobs
Date: Mon, 27 Jan 2025 23:26:02 +0300
Message-Id: <20250127202630.3724367-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

During the past months, the netbsd and openbsd jobs in the Cirrus-CI
were broken most of the time - the setup to run a BSD in KVM on Cirrus-CI
from gitlab via the cirrus-run script was very fragile, and since the
jobs were not run by default, it used to bitrot very fast.

Now Cirrus-CI also introduce a limit on the amount of free CI minutes
that you get there, so it is not appealing at all anymore to run
these BSDs in this setup - it's better to run the checks locally via
"make vm-build-openbsd" and "make vm-build-netbsd" instead. Thus let's
remove these CI jobs now.

Message-ID: <20240426113742.654748-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit cc6cb422e09592158586279fddeef107df05ecbb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index cbc68a567a..92c97eefc1 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -91,40 +91,3 @@ aarch64-macos-14-base-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
     QEMU_JOB_OPTIONAL: 1
-
-
-# The following jobs run VM-based tests via KVM on a Linux-based Cirrus-CI job
-.cirrus_kvm_job:
-  extends: .base_job_template
-  stage: build
-  image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
-  needs: []
-  timeout: 80m
-  script:
-    - sed -e "s|[@]CI_REPOSITORY_URL@|$CI_REPOSITORY_URL|g"
-          -e "s|[@]CI_COMMIT_REF_NAME@|$CI_COMMIT_REF_NAME|g"
-          -e "s|[@]CI_COMMIT_SHA@|$CI_COMMIT_SHA|g"
-          -e "s|[@]NAME@|$NAME|g"
-          -e "s|[@]CONFIGURE_ARGS@|$CONFIGURE_ARGS|g"
-          -e "s|[@]TEST_TARGETS@|$TEST_TARGETS|g"
-      <.gitlab-ci.d/cirrus/kvm-build.yml >.gitlab-ci.d/cirrus/$NAME.yml
-    - cat .gitlab-ci.d/cirrus/$NAME.yml
-    - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
-  variables:
-    QEMU_JOB_CIRRUS: 1
-    QEMU_JOB_OPTIONAL: 1
-
-
-x86-netbsd:
-  extends: .cirrus_kvm_job
-  variables:
-    NAME: netbsd
-    CONFIGURE_ARGS: --target-list=x86_64-softmmu,ppc64-softmmu,aarch64-softmmu
-    TEST_TARGETS: check
-
-x86-openbsd:
-  extends: .cirrus_kvm_job
-  variables:
-    NAME: openbsd
-    CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
-    TEST_TARGETS: check
diff --git a/.gitlab-ci.d/cirrus/kvm-build.yml b/.gitlab-ci.d/cirrus/kvm-build.yml
deleted file mode 100644
index a93881aa8b..0000000000
--- a/.gitlab-ci.d/cirrus/kvm-build.yml
+++ /dev/null
@@ -1,31 +0,0 @@
-container:
-  image: fedora:35
-  cpu: 4
-  memory: 8Gb
-  kvm: true
-
-env:
-  CIRRUS_CLONE_DEPTH: 1
-  CI_REPOSITORY_URL: "@CI_REPOSITORY_URL@"
-  CI_COMMIT_REF_NAME: "@CI_COMMIT_REF_NAME@"
-  CI_COMMIT_SHA: "@CI_COMMIT_SHA@"
-
-@NAME@_task:
-  @NAME@_vm_cache:
-    folder: $HOME/.cache/qemu-vm
-  install_script:
-    - dnf update -y
-    - dnf install -y git make openssh-clients qemu-img qemu-system-x86 wget meson
-  clone_script:
-    - git clone --depth 100 "$CI_REPOSITORY_URL" .
-    - git fetch origin "$CI_COMMIT_REF_NAME"
-    - git reset --hard "$CI_COMMIT_SHA"
-  build_script:
-    - if [ -f $HOME/.cache/qemu-vm/images/@NAME@.img ]; then
-        make vm-build-@NAME@ J=$(getconf _NPROCESSORS_ONLN)
-          EXTRA_CONFIGURE_OPTS="@CONFIGURE_ARGS@"
-          BUILD_TARGET="@TEST_TARGETS@" ;
-      else
-        make vm-build-@NAME@ J=$(getconf _NPROCESSORS_ONLN) BUILD_TARGET=help
-          EXTRA_CONFIGURE_OPTS="--disable-system --disable-user --disable-tools" ;
-      fi
-- 
2.39.5


