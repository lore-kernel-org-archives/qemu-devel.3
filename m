Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48F7C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 14:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryXyX-0006xK-Ds; Sun, 21 Apr 2024 10:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXyO-0006wk-Pk; Sun, 21 Apr 2024 10:15:16 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXyJ-0001Sy-5q; Sun, 21 Apr 2024 10:15:13 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 66A25C0CA6;
 Sun, 21 Apr 2024 16:15:07 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id fJOKSlKg9st8; Sun, 21 Apr 2024 16:15:07 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id E9386C0712;
 Sun, 21 Apr 2024 16:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr E9386C0712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713708907;
 bh=g0/8oYtYtCE3CzTawtDsudcNlcw/CRxYUBxIoT8mGVk=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=6kSGk0+NKKjhyKH/6quYk5qVi5nOqwRpymrwujDWmCDPfNOtkRQZiVsRsTZ1SiyD8
 f9FeZGAl5sPK3mrPySAnMFKMngo4i5+s3KEg+WKvZpJzLmAxRWqpAMy+S62UOXUocE
 uuTj09QPzuzIIR8TLDnYnhYwnT8Lwl4od2pXIi7k=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id kr2wYH-Sbvf5; Sun, 21 Apr 2024 16:15:06 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:e56c:d081:2a7:415b:bbbd])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 3C70DC060B;
 Sun, 21 Apr 2024 16:15:06 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/misc : Correct 5 spaces indents in stm32l4x5_exti
Date: Sun, 21 Apr 2024 16:14:23 +0200
Message-ID: <20240421141455.116548-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_exti.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 9fd859160d..5c55ee4268 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -59,22 +59,22 @@ static const uint32_t exti_romask[EXTI_NUM_REGISTER] =
=3D {
=20
 static unsigned regbank_index_by_irq(unsigned irq)
 {
-     return irq >=3D EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
+    return irq >=3D EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
 }
=20
 static unsigned regbank_index_by_addr(hwaddr addr)
 {
-     return addr >=3D EXTI_IMR2 ? 1 : 0;
+    return addr >=3D EXTI_IMR2 ? 1 : 0;
 }
=20
 static unsigned valid_mask(unsigned bank)
 {
-     return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
+    return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
 }
=20
 static unsigned configurable_mask(unsigned bank)
 {
-     return valid_mask(bank) & ~exti_romask[bank];
+    return valid_mask(bank) & ~exti_romask[bank];
 }
=20
 static void stm32l4x5_exti_reset_hold(Object *obj)
--=20
2.43.2


