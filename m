Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D3FC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGU-00084x-TZ; Tue, 25 Aug 2026 03:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGR-0007tc-Pm; Tue, 25 Aug 2026 03:08:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGO-00066f-08; Tue, 25 Aug 2026 03:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=+j5qWRPxTOVkvBGZ+bjlJU1tF0kNvURpihIJiCoBapw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O2VkeFJthXxTDlKJOuBe8lLzCqpEVx64utm9IdKTZui8c5LAvggMfOdenLCbktphp
 KhS7KXaTMCl0dIIWDUWf0MGltMkSh77QuRrH3e9reMcTF/sfvyMaqsuw7kcPKyFOKl
 su9zuaYBfcMrKu/29LnQGvj4Xpy8lyza8GirKafaNC2QhcM7SK3w/YIO/LHeP2GG9Z
 DrdBg0BsqcqUZwA55eu9wMYqCi8hEyLW1OsJiveyogM4/Vr68om6polBQrNVibpEg4
 /2RaeywU2As+aEhf43A2oS/Hjf1pKxKSUho9ZsNSZDtiLWlZ8vVmIYVgAHb3qegTHe
 eL+5bX7r+el8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 363011CE21F;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EEFA8415F9A;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9142C3241E; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 58/91] hw/intc/arm_gicv3: Have GIC kconfig select
 GICv3 for HVF and WHPX
Date: Tue, 25 Aug 2026 10:05:30 +0300
Message-ID: <20260825070619.174584-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

While trying to fix the GICv3 dependency on KVM and WHPX in
commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
selects GICv3 for TCG, not HVF and WHPX. Fix that.

Cc: qemu-stable@nongnu.org
Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260812220816.94034-1-philmd@oss.qualcomm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a0c093900d84f6668c27eaeab4ca74935b5857b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 636d00b7e88..1fec78f3bf1 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,7 +23,7 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if TCG || HVF || WHPX
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-- 
2.47.3


