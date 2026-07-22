Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1064C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPf-0000Jf-4h; Wed, 22 Jul 2026 08:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWPX-00080M-BF; Wed, 22 Jul 2026 08:50:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWPV-0002IH-7T; Wed, 22 Jul 2026 08:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724391; bh=AdE7x92jIH2QWSGF6PsRixekPg39t3VeZiT9+BrhRXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a4eV1F9lgXiaextROu/shqrJZo8uGEG5zOvYKQV8nkvq5gK7t2qUvJWxDe9elMp85
 HH1z9yaJ2p9dzdiqSQQUzBPlbMq3HreQ+ZEdVLVOl8eq1x5NPrjXD2uZXcE3cQTJbO
 zkEhse0KTx9ZoNOFffiHfXYJTgs0UlhQI57/5iqE60vEMgaxvbTuXnjCnMyCVnkgqD
 Um2b4ITR0lC8+ZaKS++4buVXYWq8yvlxa+kguUjmSibM6mIx3dZ8Jz36QiXSJ0x/gW
 T/R7Pg5/+EQMf2lNP3kGB8NIKdC5H78sM9T8KEWzFfhh3vp20jc0EQrxZnj369kNyK
 0X63fie64yUXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F43D1C3B22;
 Wed, 22 Jul 2026 15:46:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 766E03F377C;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A325117F2D; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 121/122] hw/net/cadence: Return current Cadence
 GEM queue pointers
Date: Wed, 22 Jul 2026 15:46:10 +0300
Message-ID: <20260722124622.31034-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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

From: Bin Meng <bin.meng@processmission.com>

Cadence GEM queue pointer registers are programmed with the descriptor
ring base, but reads return the descriptor currently being accessed.
The model tracked the current positions separately while continuing to
return the configured base.

The Linux macb driver uses the transmit queue pointer when recovering
from a used-buffer interrupt. A stale priority-queue pointer can make
the driver restart DMA before that queue handles its completion
interrupt, causing queue 0 to repeatedly raise TX_USED.

The primary queue has had this mismatch since the initial model.
Priority queue support later copied the same register-read behavior.

A single-queue machine usually handles TX_COMPLETE before TX_USED and
empties the software queue before the restart check, which kept the
issue hidden there.

Return the current RX and TX descriptor positions on queue-pointer reads
and clear those positions on reset.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Fixes: 6710172501be ("cadence_gem: Add queue support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260720120731.2022475-1-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 94c510a5dc4836550af1ecddcfa1ff945bae562a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index c36918e5043..defa446fbb2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1469,6 +1469,8 @@ static void gem_reset(DeviceState *d)
 
     /* Set post reset register values */
     memset(&s->regs[0], 0, sizeof(s->regs));
+    memset(&s->rx_desc_addr[0], 0, sizeof(s->rx_desc_addr));
+    memset(&s->tx_desc_addr[0], 0, sizeof(s->tx_desc_addr));
     s->regs[R_NWCFG] = 0x00080000;
     s->regs[R_NWSTATUS] = 0x00000006;
     s->regs[R_DMACFG] = 0x00020784;
@@ -1582,9 +1584,22 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     offset >>= 2;
     retval = s->regs[offset];
 
-    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset*4, retval);
+    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset * 4,
+             retval);
 
     switch (offset) {
+    case R_RXQBASE:
+        retval = s->rx_desc_addr[0];
+        break;
+    case R_TXQBASE:
+        retval = s->tx_desc_addr[0];
+        break;
+    case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
+        retval = s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1];
+        break;
+    case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
+        retval = s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1];
+        break;
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
-- 
2.47.3


