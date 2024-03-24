Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FC6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 16:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roQSd-0003dT-P2; Sun, 24 Mar 2024 12:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1roQSc-0003ch-18; Sun, 24 Mar 2024 12:12:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1roQSZ-0006tM-IQ; Sun, 24 Mar 2024 12:12:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 89C294E6003;
 Sun, 24 Mar 2024 17:11:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id q52ltfNNo1Wl; Sun, 24 Mar 2024 17:11:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4650D4E601F; Sun, 24 Mar 2024 17:11:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] docs/system/ppc/amigang.rst: Fix formatting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Message-Id: <20240324161148.4650D4E601F@zero.eik.bme.hu>
Date: Sun, 24 Mar 2024 17:11:48 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Add missing space to fix character formatting where it was missed in
two places.

Fixes: 623d9065b6 (docs/system/ppc: Document running Linux on AmigaNG machines)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/system/ppc/amigang.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index ba1a3d80b9..e2c9cb74b7 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -16,7 +16,7 @@ firmware to support AmigaOS 4.
 Emulated devices
 ----------------
 
- * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
+ * PowerPC 7457 CPU (can also use ``-cpu g3, 750cxe, 750fx`` or ``750gx``)
  * Articia S north bridge
  * VIA VT82C686B south bridge
  * PCI VGA compatible card (guests may need other card instead)
@@ -73,7 +73,7 @@ https://www.powerdeveloper.org/platforms/pegasos/schematics.
 Emulated devices
 ----------------
 
- * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
+ * PowerPC 7457 CPU (can also use ``-cpu g3`` or ``750cxe``)
  * Marvell MV64361 Discovery II north bridge
  * VIA VT8231 south bridge
  * PCI VGA compatible card (guests may need other card instead)
-- 
2.30.9


