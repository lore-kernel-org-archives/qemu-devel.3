Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42646C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb545-0002dd-0B; Thu, 23 Jan 2025 16:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tb543-0002dK-C4; Thu, 23 Jan 2025 16:48:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tb541-00015d-6T; Thu, 23 Jan 2025 16:48:38 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 443624E602B;
 Thu, 23 Jan 2025 22:48:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id zU7nQuhqkVfM; Thu, 23 Jan 2025 22:48:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 401B54E601A; Thu, 23 Jan 2025 22:48:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/usb/hcd-ehci: Fix debug printf format string
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-Id: <20250123214831.401B54E601A@zero.eik.bme.hu>
Date: Thu, 23 Jan 2025 22:48:31 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The variable is uint64_t so needs %ld instead of %d.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/hcd-ehci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 6c4c14c895..23b3e20fdb 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2287,7 +2287,7 @@ static void ehci_work_bh(void *opaque)
             ehci_update_frindex(ehci, skipped_uframes);
             ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
             uframes -= skipped_uframes;
-            DPRINTF("WARNING - EHCI skipped %d uframes\n", skipped_uframes);
+            DPRINTF("WARNING - EHCI skipped %ld uframes\n", skipped_uframes);
         }
 
         for (i = 0; i < uframes; i++) {
-- 
2.30.9


