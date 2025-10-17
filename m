Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA4BCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mk2-0000kr-1j; Fri, 17 Oct 2025 11:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mk0-0000gZ-Cu
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:51:40 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mjs-0003qc-9Q
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:51:39 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B8D647A0082;
 Fri, 17 Oct 2025 11:51:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 17 Oct 2025 11:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1760716289; x=
 1760802689; bh=yaOzH4ZD5Q2CrGhXF6tFydMjuFnRzi1IMa76PXsDv6I=; b=R
 H7qRfeD7RZ9JX3OPWDhzXLyYAXS9G8yDRCsend28Q4igda4wN7MUbrfdLhVAqgET
 tD6Ds5QweVvpIQMk+Brkm4wQjJmhXZOR1GgWjZ4SYEyqacW9+F1xqRf8BfDtV7G5
 AaX6uqQmlhCS5YR4kQq0fQxQLGozxNy4x/LzXL91L2skuYe65Z1ac1slOcVn2f85
 stf19SBvcy+eczV/JJ5f/SW8+gp65TUpq6e8gg344zOaJltPIm+7jmFixGK6EsAk
 lZyWdG7xxIRino2ZUx0ncMy6HGWFftknK8MeNAdSuWtHZKA/4/D21+to9YSP0lP5
 0GSSwkRq9wBWO3NbKFLkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760716289; x=1760802689; bh=y
 aOzH4ZD5Q2CrGhXF6tFydMjuFnRzi1IMa76PXsDv6I=; b=wUWLfG6HV2ckjxGij
 R2lc8dXUBp0Roq15WppumhL0cslpG0C14stqQ8DU3NruE+/93JIVcfnBlUdWbv3j
 ZJs9K6AMP/6nAtjaYw39Z5pjuB9U4Iq4jhg/BgWg1R8q15n6+PX/jQo9US2WR4Rx
 kXH8PdgSgDn4qtBRwGJN7yQJOO1DnLYfoppNgQ7FZ7YaZ7OKwPpjQf2s6jPxf9Z8
 /cY+8yd+9MU5XE8at8FyQzJixY5wPgSohzNj/gFI9VACP5TiXWDtfcAYtuFTsC3K
 QLZ/snEXTJP1zLNJ8M3kHB+owjOAGpb9YkHNi/kxdSET3wHLdBB3Jy5wF2roUsdu
 DWDtw==
X-ME-Sender: <xms:AWbyaAj7RbkJMSoaNN5RMPxELHBEI3KZyQU2oENaN2EJbq4_OmMY4A>
 <xme:AWbyaP744TiifaaqORZLn-80pZKrSlMCkVk_3_Zj701jbTAaLq3I02_RtuB9B6Znj
 pLQ-z7lznpwp_Fjc5-VhVZu9qtBruvUo5KIjn9OMOFRfIKZ8iYQgWc>
X-ME-Received: <xmr:AWbyaAbLJa_D_CXlzR6W9uVpReqUS2lRG35mB2uetSZxFLmF92_GDC7YAWvn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelheekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonh
 esvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdig
 hiii
X-ME-Proxy: <xmx:AWbyaM7_p2pepeIJu4YM31DV7yiHfSmxZHJBnwPAWiZcOssOgb0O8A>
 <xmx:AWbyaLC7WATriPXvHVBYyuY0fqGQL0hG61XFhKP6_lVJFGvZKI7k9w>
 <xmx:AWbyaKdjpDyr_cqZoRE8sz-YOmq6mPKJuRaz7i72kEeduRpXh9u8KQ>
 <xmx:AWbyaCLAs4njkP2ZL5L7rYvF_SABS4WNxQaga5QDuj-swCIY5p6bJQ>
 <xmx:AWbyaDWsRseybaKy7dVUEelek-wRwzLbknGkEjgIOTIkoISfNe5jnKcO>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 11:51:28 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id eebbe656;
 Fri, 17 Oct 2025 15:51:28 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, kraxel@redhat.com, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 1/1] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
Date: Fri, 17 Oct 2025 11:51:17 -0400
Message-ID: <20251017155117.1953708-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017155117.1953708-1-chad@jablonski.xyz>
References: <20251017155117.1953708-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
aperture and R100 cards always request 128MB. This is regardless
of the amount of physical VRAM on the board. The following are results
from real hardware tests:

Card                              VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
-----------------------           ----    --------   --------------  ----------------  ---------------
Rage 128 Pro Ultra TF             32MB     64MB       0x02000000      0x02000000        0x02000000
Rage 128 RF/SG AGP                16MB     64MB       0x01000000      0x02000000        0x02000000
Radeon R100 QD [Radeon 7200]      64MB    128MB       0x04000000      0x04000000        N/A
Radeon RV100 QY [Radeon 7000/VE]  32MB    128MB       0x02000000      0x04000000        N/A

Previously the linear aperture (BAR0) would match the VRAM size.
This discrepancy caused issues with the X.org and XFree86 r128 drivers.
These drivers apply a mask of 0xfc000000 (2^26 = 64MB) to the linear
aperture address. If that address is not on a 64MB boundary the
framebuffer points to an incorrect memory location.

Testing shows that the Radeon R100 also has a BAR0 larger than VRAM
(128MB in this case) and the X.org radeon driver also masks to 64MB.

For Rage 128, CONFIG_APER_SIZE also differs from the previous value and
the behavior stated in the documentation. The Rage 128 register guide
states that it should contain the size of the VRAM + AGP memory. The cards
tested above show that this isn't the case. These tests also included
enabling/disabling AGP with 8MB of memory. It didn't change the
contents of CONFIG_APER_SIZE.

For both Rage 128 and R100 the CONFIG_APER_SIZE is half of the PCI BAR0 size.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c     | 16 ++++++++++++++--
 hw/display/ati_int.h |  5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a87..0b4298d078 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -361,7 +361,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size / 2;
+        val = memory_region_size(&s->linear_aper) / 2;
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
@@ -952,6 +952,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
+    uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
     if (s->use_pixman != 0) {
@@ -1011,7 +1012,18 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
 
-    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    /*
+     * The framebuffer is at the beginning of the linear aperture. For
+     * Rage128 the upper half of the aperture is reserved for an AGP
+     * window (which we do not emulate.)
+     */
+    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
+    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
+                       aper_size);
+    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b0..708cc1dd3a 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -10,6 +10,7 @@
 #define ATI_INT_H
 
 #include "qemu/timer.h"
+#include "qemu/units.h"
 #include "hw/pci/pci_device.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
@@ -29,6 +30,9 @@
 /* Radeon RV100 (VE) */
 #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
 
+#define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
+#define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -97,6 +101,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
-- 
2.51.0


