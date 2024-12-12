Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CD5E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfP-0007aN-5X; Thu, 12 Dec 2024 06:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfK-0007Gj-HX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfI-0007HJ-W8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=qNDehseV+I5i+8QLfpH/ecIB0gDEFoANmL+iEJKt2Js=; b=B3Ti21/q3eNr7Nh8ZIKGFrpStt
 m7rkDxFM7aJy+k5o7YgSOqvpBCIKqVEdvVjDvkLrMTvveDcC+4dO0mhxJg2DedmgQaEo2BZXe9K82
 NUxOjLKRH7CWs+I0hRN0ykJxltkSl6D4R88fRjAnRcMrBEWo8qs7grJsp7KyngCRT89h+JglXhuNj
 f98n3D+zJ83+A+qY9u7o6u8lBYHu6Twej4t+EI3jwexFo4Mo9rZ7IrbBiruy+N2VOBOAuzVM9hEGe
 V8PFkaJjWm8fFXe/m1QRkni+lMpPQ+0hkbdmREVgvh5NIYSlqbwihB/B6usOCfm1Qo9xlmJ/NtnM3
 cIv7LAJJhUOCR9UUEGRw3TZ664BiRPEscoAts+RKzvjO3CGCdezyRsx3FNVG5O1nsj+tfce7h7NtY
 XMi6vnQnDBc2J/vDSOK8K6D5FKSpVpHlzC4CKo1Uip7YVZfUqD9EgMTLuJiYFvK3ioXoVvqcYritc
 v8Bwwj3jsNuSZSY0FbVdHfPFU2VEMrU1hRLIWPEcgURZY1NvdFnOgs1CsWmDqra+pflItR51w1MOY
 7M1o8y+WoUrnBX3S3AswpZWYCojhFXLxYBJXPGic8oqWy1qwAi/xZ2nrKs3AwOgu2bRKYcMg1RMex
 eu+GF/PyJLDFpF3pkCEkkIjRo7B9R1ZGDR3lC6Jeo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheY-00070a-HM; Thu, 12 Dec 2024 11:46:50 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:02 +0000
Message-Id: <20241212114620.549285-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/34] next-cube: rearrange NeXTState declarations to
 improve readability
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

Move the NeXTState, next_dma and TYPE_NEXT_MACHINE definition to the same area
at the top of next-cube.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 86a0aaa511..5333fc7bef 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -38,30 +38,10 @@
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
 
-#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
-OBJECT_DECLARE_SIMPLE_TYPE(NeXTState, NEXT_MACHINE)
-
 #define ENTRY       0x0100001e
 #define RAM_SIZE    0x4000000
 #define ROM_FILE    "Rev_2.5_v66.bin"
 
-typedef struct next_dma {
-    uint32_t csr;
-
-    uint32_t saved_next;
-    uint32_t saved_limit;
-    uint32_t saved_start;
-    uint32_t saved_stop;
-
-    uint32_t next;
-    uint32_t limit;
-    uint32_t start;
-    uint32_t stop;
-
-    uint32_t next_initbuf;
-    uint32_t size;
-} next_dma;
-
 typedef struct NextRtc {
     int8_t phase;
     uint8_t ram[32];
@@ -72,18 +52,6 @@ typedef struct NextRtc {
     uint8_t retval;
 } NextRtc;
 
-struct NeXTState {
-    MachineState parent;
-
-    MemoryRegion rom;
-    MemoryRegion rom2;
-    MemoryRegion dmamem;
-    MemoryRegion bmapm1;
-    MemoryRegion bmapm2;
-
-    next_dma dma[10];
-};
-
 #define TYPE_NEXT_SCSI "next-scsi"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
 
@@ -132,6 +100,38 @@ struct NeXTPC {
     NextRtc rtc;
 };
 
+typedef struct next_dma {
+    uint32_t csr;
+
+    uint32_t saved_next;
+    uint32_t saved_limit;
+    uint32_t saved_start;
+    uint32_t saved_stop;
+
+    uint32_t next;
+    uint32_t limit;
+    uint32_t start;
+    uint32_t stop;
+
+    uint32_t next_initbuf;
+    uint32_t size;
+} next_dma;
+
+#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
+OBJECT_DECLARE_SIMPLE_TYPE(NeXTState, NEXT_MACHINE)
+
+struct NeXTState {
+    MachineState parent;
+
+    MemoryRegion rom;
+    MemoryRegion rom2;
+    MemoryRegion dmamem;
+    MemoryRegion bmapm1;
+    MemoryRegion bmapm2;
+
+    next_dma dma[10];
+};
+
 /* Thanks to NeXT forums for this */
 /*
 static const uint8_t rtc_ram3[32] = {
-- 
2.39.5


