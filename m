Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB4C369D0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPyB-00067l-OC; Wed, 25 Sep 2024 07:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwi-0006tf-Tk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwg-00042R-Ra
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwWnn7F0IA8668O/RtqUw3SrdoOv+JBapXUjElCJD7U=;
 b=b8FO9+Sgs4rUHecM32SCbiQlofPj+cs8QDF4TyMKhkQUyDqaXwjjFUtMUTyZv0YBlyIww5
 hR65a+vez1RzwRYyL82epJg3JQy06KLyhKJA0n4W/yxhwSytnLw+hLNW677emWLpJpxDZl
 Etn6MW357NLRR1ds4ZNjTh8AWR9mkCM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-bIjS_JP6OrKnqZHEVMq5cQ-1; Wed,
 25 Sep 2024 07:12:31 -0400
X-MC-Unique: bIjS_JP6OrKnqZHEVMq5cQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BFDE19772E6; Wed, 25 Sep 2024 11:12:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF4591956094; Wed, 25 Sep 2024 11:12:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 44/44] .gitlab-ci.d: Make separate collapsible log sections for
 build and test
Date: Wed, 25 Sep 2024 13:10:25 +0200
Message-ID: <20240925111029.24082-45-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

GitLab lets a CI job create its own collapsible log sections by
emitting special escape codes, as documented here:

https://docs.gitlab.com/ee/ci/yaml/script.html#expand-and-collapse-job-log-sections

Use these to make "configure", "build" and "test" separate
collapsible stages.

As recommended by the GitLab docs, we use some shell which is
sourced in the CI job to define functions to emit the magic
lines that start and end sections, to hide the ugliness of
the printf lines from the log.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240918125449.3125571-3-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml  | 14 ++++++++++++++
 .gitlab-ci.d/buildtest.yml           |  1 +
 .gitlab-ci.d/crossbuild-template.yml | 25 ++++++++++++++++++++++++
 scripts/ci/gitlab-ci-section         | 29 ++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 scripts/ci/gitlab-ci-section

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 5f2fc7e6f4..8c69c60d21 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -8,8 +8,11 @@
     key: "$CI_JOB_NAME"
     when: always
   before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
     - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
+    - section_end setup
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -19,6 +22,7 @@
     - mkdir build
     - cd build
     - ccache --zero-stats
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
@@ -27,11 +31,16 @@
       then
         pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
       fi || exit 1;
+    - section_end configure
+    - section_start build "Building QEMU"
     - $MAKE -j"$JOBS"
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
     - ccache --show-stats
 
 # We jump some hoops in common_test_job_template to avoid
@@ -54,6 +63,8 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
     - meson subprojects download $(cd build/subprojects && echo *)
     - cd build
@@ -63,7 +74,10 @@
     - if [ "x${QEMU_TEST_CACHE_DIR}" != "x" ]; then
         $MAKE precache-functional ;
       fi
+    - section_end buildenv
+    - section_start test "Running tests"
     - $MAKE NINJA=":" $MAKE_CHECK_ARGS
+    - section_end test
 
 .native_test_job_template:
   extends: .common_test_job_template
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 2ab8c4806e..87848c2ffe 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -188,6 +188,7 @@ build-previous-qemu:
     # Override the default flags as we need more to grab the old version
     GIT_FETCH_EXTRA_FLAGS: --prune --quiet
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
     - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index d1cb7a35db..45a9810355 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -9,8 +9,11 @@
     when: always
   timeout: 80m
   before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
     - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
+    - section_end setup
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -19,22 +22,30 @@
     - mkdir build
     - cd build
     - ccache --zero-stats
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
         --target-list-exclude="arm-softmmu
           i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
           mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
+    - section_start installer "Building the installer"
     - if grep -q "EXESUF=.exe" config-host.mak;
       then make installer;
       version="$(git describe --match v[0-9]* 2>/dev/null || git rev-parse --short HEAD)";
       mv -v qemu-setup*.exe qemu-setup-${version}.exe;
       fi
+    - section_end installer
     - ccache --show-stats
 
 # Job to cross-build specific accelerators.
@@ -52,6 +63,7 @@
       - ccache/
     key: "$CI_JOB_NAME"
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -60,13 +72,19 @@
     - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
     - mkdir build
     - cd build
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-tools --enable-${ACCEL:-kvm} $EXTRA_CONFIGURE_OPTS
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
 
 .cross_user_build_job:
   extends: .base_job_template
@@ -77,6 +95,7 @@
       - ccache/
     key: "$CI_JOB_NAME"
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -84,16 +103,22 @@
     - export CCACHE_MAXSIZE="500M"
     - mkdir build
     - cd build
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-system --target-list-exclude="aarch64_be-linux-user
           alpha-linux-user m68k-linux-user microblazeel-linux-user
           or1k-linux-user ppc-linux-user sparc-linux-user
           xtensa-linux-user $CROSS_SKIP_TARGETS"
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
 
 # We can still run some tests on some of our cross build jobs. They can add this
 # template to their extends to save the build logs and test results
diff --git a/scripts/ci/gitlab-ci-section b/scripts/ci/gitlab-ci-section
new file mode 100644
index 0000000000..9bbe80420d
--- /dev/null
+++ b/scripts/ci/gitlab-ci-section
@@ -0,0 +1,29 @@
+# Copyright (c) 2024 Linaro Ltd
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# gitlab-ci-section: This is a shell script fragment which defines
+# functions section_start and section_end which will emit marker lines
+# that GitLab will interpret as the beginning or end of a "collapsible
+# section" in a CI job log. See
+# https://docs.gitlab.com/ee/ci/yaml/script.html#expand-and-collapse-job-log-sections
+#
+# This is intended to be sourced in the before_script section of
+# a CI config; the section_start and section_end functions will
+# then be available for use in the before_script and script sections.
+
+# Section names are [-_.A-Za-z0-9] and the section_start pairs with
+# a section_end with the same section name.
+# The description can be any printable text without newlines; this is
+# what will appear in the log.
+
+# Usage:
+# section_start section_name "Description of the section"
+section_start () {
+    printf "section_start:%s:%s\r\e[0K%s\n" "$(date +%s)" "$1" "$2"
+}
+
+# Usage:
+# section_end section_name
+section_end () {
+    printf "section_end:%s:%s\r\e[0K\n" "$(date +%s)" "$1"
+}
-- 
2.46.0


