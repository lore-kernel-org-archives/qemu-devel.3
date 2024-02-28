Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB3C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSpa-0005RR-Kg; Wed, 28 Feb 2024 17:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpT-0005PN-5B; Wed, 28 Feb 2024 17:55:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpQ-0000Vf-60; Wed, 28 Feb 2024 17:55:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8782C51809;
 Thu, 29 Feb 2024 01:55:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E849A8BB3C;
 Thu, 29 Feb 2024 01:54:55 +0300 (MSK)
Received: (nullmailer pid 274125 invoked by uid 1000);
 Wed, 28 Feb 2024 22:54:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 64/78] .gitlab-ci.d/windows.yml: Drop msys2-32bit job
Date: Thu, 29 Feb 2024 01:54:40 +0300
Message-Id: <20240228225455.274062-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

MSYS2 is dropping support for 32-bit Windows.  This shows up for us
as various packages we were using in our CI job no longer being
available to install, which causes the job to fail.  In commit
8e31b744fdf we dropped the dependency on libusb and spice, but the
dtc package has also now been removed.

For us as QEMU upstream, "32 bit x86 hosts for system emulation" have
already been deprecated as of QEMU 8.0, so we are ready to drop them
anyway.

Drop the msys2-32bit CI job, as the first step in doing this.

This is cc'd to stable, because this job will also be broken for CI
on the stable branches.  We can't drop 32-bit support entirely there,
but we will still be covering at least compilation for 32-bit Windows
via the cross-win32-system job.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240220165602.135695-1-peter.maydell@linaro.org
(cherry picked from commit 5cd3ae4903e33982e7a9bbd04674af517e796d6e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 5c1e385dc8..8fc08218d2 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -131,12 +131,3 @@ msys2-64bit:
     # qTests don't run successfully with "--without-default-devices",
     # so let's exclude the qtests from CI for now.
     TEST_ARGS: --no-suite qtest
-
-msys2-32bit:
-  extends: .shared_msys2_builder
-  variables:
-    MINGW_TARGET: mingw-w64-i686
-    MSYSTEM: MINGW32
-    EXTRA_PACKAGES:
-    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
-    TEST_ARGS: --no-suite qtest
-- 
2.39.2


