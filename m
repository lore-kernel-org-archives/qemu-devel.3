Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E089CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXQ-0001QK-Sb; Fri, 22 May 2026 17:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWN-0008Lu-4C; Fri, 22 May 2026 17:35:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWL-0007gn-9b; Fri, 22 May 2026 17:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=hJaRuAX6LIkyhNtmQcr5JlRnYbl5/hyQbDJItjZQY8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uxa4bOJ94bqonr2O7ER7r9ZReWMafVp6FDfvOYUHx7wQrOWi8sMsQ8+rxj0n3RP2W
 W5iVkFdwbVcSqCe3QAY09l0AKBjtk5EodQYE98ITeLSY8uxfuCxvtrmofYNzsQByA8
 VqzE85/UoNY+QDldtTXL5/EJWU4+IPbs7gaQMnHabVePb/e4n73aenrr2CW9XqGpKb
 vrMtLi/bxzCMkNwtM4AOtQqlqrbF5To1822OWBrDf41MBEDLYzY0kFAT7GLka5ciHt
 0h+L0xlYiiZ6krD4T4cuaQpYY08HQEpKET5lBEYhosB3sJSVPqN98n/hn4fGYYF2E2
 pHQQK/ucwUDEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2933D1AFAD7;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4AB0F3B715D;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Auger <eric.auger@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 72/94] tests/qtest/iommu-smmuv3-test: Skip if no TCG
 GICv3 device present
Date: Sat, 23 May 2026 00:33:29 +0300
Message-ID: <20260522213356.806058-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

On a KVM-only (--disable-tcg) build, the iommu-smmuv3 qtest fails:

qemu-system-aarch64: QTest does not support GICv3 emulation
Broken pipe
../../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

This is because the test runs the virt board with the qtest
accelerator and gic-version=3.  In the virt board this selects the
TCG (emulated) GICv3, but in a --disable-tcg build we don't compile
that device, only the KVM GICv3 (which isn't usable with qtest).

Add a check to the test so we skip it if the arm-gicv3 device isn't
in the QEMU binary.

Cc: qemu-stable@nongnu.org
Fixes: d8d19c31b220142641 ("tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 0129c626503c6d7220848a1f944a8f8e033ceaf9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
index dae9821b92..708fae5fd3 100644
--- a/tests/qtest/iommu-smmuv3-test.c
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -64,6 +64,11 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
         g_test_skip("virt machine not available");
         return;
     }
+    if (!qtest_has_device("arm-gicv3")) {
+        /* This can happen for a KVM-only build: qtest uses the TCG GICv3 */
+        g_test_skip("gicv3 not available");
+        return;
+    }
 
     /* Initialize QEMU environment for SMMU testing */
     qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
-- 
2.47.3


