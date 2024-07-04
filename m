Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC53C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtg-0004ax-KI; Thu, 04 Jul 2024 08:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLtW-0004Kp-R6; Thu, 04 Jul 2024 08:49:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLtN-0006PP-KJ; Thu, 04 Jul 2024 08:49:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 39ED6773A0;
 Thu,  4 Jul 2024 15:48:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C4F0AFE785;
 Thu,  4 Jul 2024 15:48:26 +0300 (MSK)
Received: (nullmailer pid 1471782 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 06/17] gitlab-ci.d/buildtest: Merge the
 --without-default-* jobs
Date: Thu,  4 Jul 2024 15:48:13 +0300
Message-Id: <20240704124826.1471715-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Let's safe some CI minutes by merging these two jobs. We can now
also drop "--disable-capstone" since the capstone submodule has
been removed a while ago. We should rather test --disable-fdt now
to check a compilation without the "dtc" submodule (for this we
have to drop i386-softmmu from the target list unfortunately).
Additionally, the qtests with s390x and sh4 are not read for
"--without-default-devices" yet, so we can only test mips64 and
avr here now.

Message-Id: <20230130104446.1286773-5-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e030d08c2fc02743dd37e3d2e6e28fdd739590b9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 7243b8079b..956025f689 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -560,29 +560,22 @@ build-coroutine-sigaltstack:
     MAKE_CHECK_ARGS: check-unit
 
 # Check our reduced build configurations
-build-without-default-devices:
+build-without-defaults:
   extends: .native_build_job_template
   needs:
     job: amd64-centos8-container
   variables:
     IMAGE: centos8
-    CONFIGURE_ARGS: --without-default-devices --disable-user
-
-build-without-default-features:
-  extends: .native_build_job_template
-  needs:
-    job: amd64-fedora-container
-  variables:
-    IMAGE: fedora
     CONFIGURE_ARGS:
+      --without-default-devices
       --without-default-features
-      --disable-capstone
+      --disable-fdt
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: avr-softmmu i386-softmmu mips64-softmmu s390x-softmmu sh4-softmmu
+    TARGETS: avr-softmmu mips64-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
-    MAKE_CHECK_ARGS: check-unit check-qtest SPEED=slow
+    MAKE_CHECK_ARGS: check-unit check-qtest-avr check-qtest-mips64
 
 build-libvhost-user:
   extends: .base_job_template
-- 
2.39.2


