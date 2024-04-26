Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Jts-00026I-T0; Fri, 26 Apr 2024 07:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0Jtq-00025w-DG
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0Jto-0001V5-BH
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714131469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xN/obj540nyS6f/WwRMvu+y4nau4AqVktNZez0jQggo=;
 b=Te1fVG0ALVR//wQ+CvcW1I7xUexzn/h2Bhmh0teAIcF6y+O4MjjXC/G/jkd1cx4jZi0VWu
 sfQWaB2O5VW1+zPNiWWlmo6W8V2tnuqpzOhUn4x7wz1YkY5a6MGshmAuOnjg/9xTV4APQa
 N6K+MviLEa+aIrptIoV0REvz+prlpLE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-WeRJ1kIKOSO4cDS5hoXmQQ-1; Fri,
 26 Apr 2024 07:37:45 -0400
X-MC-Unique: WeRJ1kIKOSO4cDS5hoXmQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9A328EC106;
 Fri, 26 Apr 2024 11:37:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FAD6C271A4;
 Fri, 26 Apr 2024 11:37:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
Date: Fri, 26 Apr 2024 13:37:42 +0200
Message-ID: <20240426113742.654748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During the past months, the netbsd and openbsd jobs in the Cirrus-CI
were broken most of the time - the setup to run a BSD in KVM on Cirrus-CI
from gitlab via the cirrus-run script was very fragile, and since the
jobs were not run by default, it used to bitrot very fast.

Now Cirrus-CI also introduce a limit on the amount of free CI minutes
that you get there, so it is not appealing at all anymore to run
these BSDs in this setup - it's better to run the checks locally via
"make vm-build-openbsd" and "make vm-build-netbsd" instead. Thus let's
remove these CI jobs now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/cirrus.yml           | 37 -------------------------------
 .gitlab-ci.d/cirrus/kvm-build.yml | 31 --------------------------
 2 files changed, 68 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/kvm-build.yml

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 4671f069c3..74de2edbb4 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -89,40 +89,3 @@ aarch64-macos-14-base-build:
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
2.44.0


