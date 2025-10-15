Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDD5CCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95Sa-0001Uo-Bk; Wed, 15 Oct 2025 13:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v95SW-0001U5-VF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:38:45 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v95SJ-0000hk-VQ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:38:41 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 015C314001A4;
 Wed, 15 Oct 2025 13:38:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Wed, 15 Oct 2025 13:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1760549909; x=1760636309; bh=RwPI2yPCbr
 0toTWpm1SItFJUF3sQIfFI43TqEZV2Bsg=; b=QZWoHoRlsbR57vqnCQOGggrQ/p
 JQok0xQ65P52/7/XP47sYQ1WSXXQb0alYlyvjryTAnA6V3sCRR9UAgopEeFX7GzO
 jqDp2AyujBIwAO6NPSQVDwCmcg7saOUzi3WHn1Gjv++zvqo8gWZdz6BOfgrpS51Q
 9Z2MWFkNHo2Zu75qhP/irYKXSwKinY9iKUiVLxQ26ONoG1PQzvQv92c0SfU2F3TW
 AFkOvG9ptSTGTZFqOVnzOUGwZmkzQwl83SAm7bWenXrNy+lWa41OGI4Si/2HtE0i
 Q4kkqgAFrbaa0H1DpfCiZY4q51+f7W7pliq9rVtWz1aNupIuGwXQsxTxKKxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1760549909; x=1760636309; bh=RwPI2yPCbr0toTWpm1SItFJUF3sQIfFI43T
 qEZV2Bsg=; b=aJJad23x6CrKE+xVx91GpYKlnjuUK3bxBwOiQII47S6yQJnwzjN
 /uDqI552nxefFckrIlIxyO+GBqpGdR4qkQCa0FK2tYQyBX+SVXxN1oKRt/D/gD/Y
 cCw+57dpbLWqX01vEdO1gO/WtC+Qjq0lhx6jWOkr5FBchuLQq5huk2fIwYj/mRC8
 Q4jQaUsM8T625YhSh5Jq+ryLNLjCUvIPz0WkME3Ivyjsd2h3i/MQIHQaGedIzVrU
 kgFj3CKsNQwxPRfyHrDnnZGTe5AOa9TM/LdQYMO4v3jxMvzZTpnizsQgyYI4Rvi+
 QRbmjQYroxi+VGFViS11Mw9zEPGzl2XIM8Q==
X-ME-Sender: <xms:FdzvaCezMIV_OsEI2DEmucLq_2-DlsNTb5Uam5ytf15I2kKghhIWaA>
 <xme:FdzvaDE40ovSc9FepZrsqfGoEZIlQb9Tlbc9Li6aY0QvTwEdANZjBVqMdNFpebjk4
 CgTjoMp4a2CGRe8y_QxGVhCWVH_5xO-n4qJSHzjV_QHScCGcCAw>
X-ME-Received: <xmr:FdzvaL2FPFUl51gRrU4UUpZpd9Y9DvBClQkw6M-VGYrCKJBWmOOiw8aqO6U6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegtdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfetue
 fgueejleetgefgieegveejleeggedugfeuvdehgefhffduffeludekieevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslh
 honhhskhhirdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrh
 grgigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
 dprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:FdzvaLnpyWCapfCDI2yxU89U1O8deC0E4M3zP5D7koCtgaJUdwo47Q>
 <xmx:FdzvaL92lrcVd3z8cEaUYOn44KcLW6JPMhHSbZPxAcLF1EpzG0LFXQ>
 <xmx:FdzvaAqD0HfKefCdXpeMicF2R7fAVQF-MSobKcsoe4tNDbFaG2J6Aw>
 <xmx:FdzvaEkP9CjbD0qhlke9f7hIS16JLUMDyR3QdU5_I1SbiCFes0nAtQ>
 <xmx:FdzvaNg3NvEn-9C6mSWCoyqFWdKtPph1mJ32FId7gPTfftScrhPplm32>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 13:38:28 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2224f0e7;
 Wed, 15 Oct 2025 17:38:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, kraxel@redhat.com, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
Date: Wed, 15 Oct 2025 13:37:16 -0400
Message-ID: <20251015173716.1764461-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.498,
 FROM_SUSPICIOUS_NTLD_FP=1.997, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Rage 128 cards always request 64MB for their linear (framebuffer)
aperture. This is regardless of the amount of physical VRAM on the
board. The following are results from real hardware tests:

Card                          VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
-----------------------       ----    --------   --------------  ----------------  ---------------
Rage 128 Pro Ultra TF         32MB     64MB       0x02000000      0x02000000        0x02000000
Rage 128 RF/SG AGP            16MB     64MB       0x01000000      0x02000000        0x02000000
Radeon R100 QD [Radeon 7200]  64MB    128MB       0x04000000      0x04000000        N/A

Previously the linear aperture (BAR0) would match the VRAM size.
This discrepancy caused issues with the X.org and XFree86 r128 drivers.
These drivers apply a mask of 0xfc000000 (2^26 = 64MB) to the linear
aperture address. If that address is not on a 64MB boundary the
framebuffer points to an incorrect memory location.

Testing shows that the Radeon R100 also has a BAR0 larger than VRAM
(128MB in this case) and the X.org driver for Radeon also masks to 64MB.

For Rage 128, CONFIG_APER_SIZE also differs from the previous value and
the behavior stated in the documentation. The Rage 128 register guide
states that it should contain the size of the VRAM + AGP memory. The cards
tested above show that this isn't the case. These tests also included
enabling/disabling AGP with 8MB of memory. It didn't change the
contents of CONFIG_APER_SIZE.

For Radeon R100, CONFIG_APER_SIZE behavior remains the same. There is
some worry that changing it could cause issues for other cards.
Especially given that I have only a single example here to test.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 20 ++++++++++++++++++--
 hw/display/ati_int.h |  4 ++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a87..7af12777c8 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -30,6 +30,7 @@
 #include "ui/console.h"
 #include "hw/display/i2c-ddc.h"
 #include "trace.h"
+#include "qemu/units.h"
 
 #define ATI_DEBUG_HW_CURSOR 0
 
@@ -361,7 +362,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size / 2;
+        val = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+            ATI_RAGE128_LINEAR_APER_SIZE / 2 : s->vga.vram_size / 2;
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
@@ -952,6 +954,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
+    uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
     if (s->use_pixman != 0) {
@@ -1011,7 +1014,20 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
 
-    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    /*
+     * Rage128: Framebuffer inhabits the bottom 32MB of the linear aperture.
+     *          The top 32MB is reserved for AGP (not implemented).
+     *
+     * R100: Linear aperture layout differs from Rage 128. No
+     *       AGP_APER_OFFSET register exists.
+     */
+    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+        ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
+    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
+                       aper_size);
+    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b0..4f66d0df3f 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -29,6 +29,9 @@
 /* Radeon RV100 (VE) */
 #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
 
+#define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
+#define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -97,6 +100,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
-- 
2.51.0


