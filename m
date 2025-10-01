Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D4CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 03:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3noQ-0002GZ-4J; Tue, 30 Sep 2025 23:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v3noO-0002GA-7p
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 23:47:28 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v3noC-0003Ks-EX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 23:47:27 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 183841D000AE;
 Tue, 30 Sep 2025 23:47:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 23:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1759290426; x=1759376826; bh=77T6ZHXAsX
 lxg15T+Zt5PA5HBrq95r94h9NliztyOxo=; b=qHihEZB1t3O5finlBNjgMVfkY2
 /JBbAoHFTg2Jnwdp2nRnanhwIRXQouxJ6khP45jLd4P/IeHcXX5XqFnYZBaSEE4g
 +B50fg1E1xmwhbU3RKjSPR3Hw09rGTa2h72gwnGNs82qZfSz2+1O/S80KEKlBKJF
 Rv0qtdtVRvsRtP9DW7DOCZZGIflvaxLeN17nbT9mN18PMBAPZVZkycHTmsuvB74e
 t0bH8ERbOXGBNCEYppu4qifrd621+HhVqQdH9QKDM8fG1uIUZIVgbwe9N3Z97jcs
 qbPWdhOBUS/cVUTz+hb+u0mFD74i3/ClblfAms0cvYLiqxz69RFZD+WOA5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1759290426; x=1759376826; bh=77T6ZHXAsXlxg15T+Zt5PA5HBrq95r94h9N
 liztyOxo=; b=GUDENe3admx8JJgOmmhGu6e3pMrbkDViAURvDKVeDIqYpEvloUn
 exs6VDjsDS4DsJG4Yrv7SmOKnoPW/6zAHAe1gu6M3LbBHUG8KXwO6P9Nq/wJB/VR
 urVUgKN1emKOadhNVJ9DttPAFQoMRbVL+AEyUIs3t5n9BqxzjluPSyejKdLp9QEi
 k+mH0+/IGTO8L21DaPaqP29wL4I8CMIGbS/hqkSD0UOLoXqULjQ6D89GOzXXvpvd
 s9Kx0BT7a5ZeyZA1Jp5Akn7i+HZT+T3XgGDvJzUBvx3S4qPplQ2ets+jeu4UBGIV
 C8dNHSLiUEcBjN6n2OLwb6O6UhnFwWDxjHQ==
X-ME-Sender: <xms:OqTcaEsWRQ2B_nV8iNAR-2Yv16gm-deEJZcgcMPfkSEMWsh21OO78w>
 <xme:OqTcaNzMQBFyES1ri4z5Z1-3fI95742qjH-phUWV-2O97huNcZc5GuI17cQKZyK1n
 4ziU9rHBg-RL6WdfbZWzd3sfKGQNvyr12aYlzUmm_vx5HJxYt5_pPo_>
X-ME-Received: <xmr:OqTcaCjrc0Ix1J8U0Z8UUfXKh9ktYUe6YEgI6rNTBfEbgaPiBDAX-z-ODn8C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhiuceo
 tghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhteeugf
 eujeelteeggfeigeevjeelgeegudfguedvheeghfffudffledukeeiveenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghloh
 hnshhkihdrgiihiidpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
 tghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:OqTcaJCvFMLW_KS_fSXB9KEHGE4YR79ML3Z64Yvy1fzEfqrFhcdZTQ>
 <xmx:OqTcaHsWkyXvNEOghtbvWhjcojlsmartY0kvWsjkNh09ZZHfpz30vw>
 <xmx:OqTcaGZdEbEFoRhwkLgxrn5M4XrGcA6_c1bUHDbPPBrvHdIN6MCIgA>
 <xmx:OqTcaCXmHHZlTowjs8BUSrDMwWDHCBAFUQIhP7t4dBb5iEetxe2sWw>
 <xmx:OqTcaDBVeHXkDFrjYYCa166c0ly27L3KEDYQtq191XSksuELEaLe7F-k>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 23:47:06 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3e91d973;
 Wed, 1 Oct 2025 03:47:05 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
Date: Tue, 30 Sep 2025 23:46:16 -0400
Message-ID: <20251001034616.3017119-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.036, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

Real Rage 128 cards always request 64MB for their linear (framebuffer)
aperture. This is regardless of the amount of physical VRAM on the
board. This is required for 64MB alignment which is important given the
26-bit addressing in src and dst registers.

This discrepancy caused X to segfault or display garbage depending on
the version tested. X expects this 64MB alignment.

This was confirmed by testing against the behavior of real 16MB and 32MB
Rage 128 cards.

Real Radeon R100 cards request 128MB for linear aperture. This was
tested against a Radeon 7200 with 64MB of VRAM.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 26 ++++++++++++++++++++++++--
 hw/display/ati_int.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a87..db189e0767 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -30,9 +30,13 @@
 #include "ui/console.h"
 #include "hw/display/i2c-ddc.h"
 #include "trace.h"
+#include "qemu/units.h"
 
 #define ATI_DEBUG_HW_CURSOR 0
 
+#define ATI_RAGE128_LINEAR_APERTURE_SIZE (64 * MiB)
+#define ATI_RADEON_LINEAR_APERTURE_SIZE (128 * MiB)
+
 #ifdef CONFIG_PIXMAN
 #define DEFAULT_X_PIXMAN 3
 #else
@@ -361,7 +365,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size / 2;
+        val = memory_region_size(&s->linear_aper);
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
@@ -1011,7 +1015,25 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
 
-    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    uint64_t aperture_size;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
+        aperture_size = ATI_RADEON_LINEAR_APERTURE_SIZE;
+    } else {
+        aperture_size = ATI_RAGE128_LINEAR_APERTURE_SIZE;
+    }
+    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
+                       aperture_size);
+
+    /*
+     * Rage 128: Framebuffer inhabits the bottom 32MB of the linear aperture.
+     *           The top 32MB is reserved for AGP (not implemented).
+     *
+     * Radeon: The entire linear aperture is used for VRAM.
+     *         AGP is mapped separately.
+     */
+    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b0..ff2a69a0a5 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -97,6 +97,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
-- 
2.51.0


