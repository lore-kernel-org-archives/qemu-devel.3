Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E20E9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1J-00073U-Ai; Wed, 04 Feb 2026 11:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1A-00070R-5Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:16 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng16-0004WH-GN
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:15 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6EF281D00144;
 Wed,  4 Feb 2026 11:46:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 11:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223570; x=
 1770309970; bh=laB0U4bo8HCPOWBM9uXAA+xB62yuJOctU/qX8DNsXjM=; b=W
 UXyjYhJCbnmp0/A0WM8SfrpgUKPugzI6rCWb7pLvjPKjzaooAsF8w18oLWI181gj
 xPRbPBwjzRdZAfEdONKjQjLX026EG8LOfsR8LLeznxKBTh5FBtNaTbLIewIPHwSE
 SCBCxvx08aHvY4s5qEBukMUTW9s6tQh1HPIOLcJR6MO+Z+Ip5+bu6kEVTiGwkjzt
 a+7cpOCO/lRlo8Mff1S/Hz8LAra2jxm2Yl903iBSNaqgvX2siluXIzAieMuQH/4F
 2MG6Ff0jZlkJXvGN3w4MSaHmlVTT1tP6198uVb36Kn9e0men7WK6NUYVXo+mTzcN
 a5mgvvslbSitU1lvU0NoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223570; x=1770309970; bh=l
 aB0U4bo8HCPOWBM9uXAA+xB62yuJOctU/qX8DNsXjM=; b=U2AYSxXheqT9spuhF
 H7UJJ3aEFRno6pj8gYVyOHvYwHTsp1LhVZ00nyc6n3c5kWvJiQwHgQvCI/Ksnt6s
 5CGSlx6cBMS/JMjexnmR5LSYK0tgGiitybIsDgRLEN6IR7LK/y3ya5JKrXF0YlBc
 ivkO53v22py88fbGIdIfWHPSYOBST+l9XHKtiTr7ptfwfSVhX0vQcI8i4IhbHJED
 rYavNiqcbKhHmSJYYXLvFDuMzXLvQ6/WUMP9zmIXfUkg1dyaHEucOKcHl3A3a9cw
 bSIBZyp5sIm1Djfy0LtABP0/HNGpSKX76jMt8lWLXoLDl1L++3++Eg40bRqm6rKx
 7al6g==
X-ME-Sender: <xms:0neDaZT1T1f4lwF4kw9rHlFmU_hJny-1rqpciU4Udi62yFnjSueMEw>
 <xme:0neDaaN_8HHBAzshQYnoVopciWsJLSqBR4qhY5SG4dWq4B8dju73FCvR-g8r7eZg5
 aHq-JP9M7VtoD6TVi9Cqo0lXgQPgG4fmcrMZQhuDp49Er3wgAmj4pY>
X-ME-Received: <xmr:0neDacPS1M4Be4KPUdtupqpW4ofvOWv5yInUE_vZhrlsXWcSYl61gZ0uCCtX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:0neDaatyh5SFD8YKrK0bxEnb8aP7eQg_FhJTZ_T84xDD4CAr1wrHFg>
 <xmx:0neDaWXwtlhucoRDZ8FHYBYXwJ9S47ZFqUzU2cVSOcnTHo-embfMSQ>
 <xmx:0neDaSuajF9_a4HI1QXDlpvGtxm0uXuCdq57kf0cSRIWvA8eMoe6Mw>
 <xmx:0neDaSVQ19gShHdKTHba3_bDyqBr4zzvi81TrXloYPjUIq_Q_lbLlQ>
 <xmx:0neDacbr3WcvJYCogLcZmTDof-F2-lacSuj4XRrwJ4QVLnysdT2NymlA>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:09 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3612959e;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 01/18] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
Date: Wed,  4 Feb 2026 11:45:49 -0500
Message-ID: <20260204164606.3425246-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
index e9c3ad2cd1..8438a77de0 100644
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
2.52.0


