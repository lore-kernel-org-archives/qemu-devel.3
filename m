Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA7CD8C9A
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4R-000648-5V; Sat, 06 Jun 2026 15:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4P-00063G-Ow
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4M-000136-QD
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 850631D00022;
 Sat,  6 Jun 2026 15:52:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 06 Jun 2026 15:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775552; x=
 1780861952; bh=nV5gQGa7tVGGnv1cHuBOy8aHu7FdD1UW6rgORbw3idM=; b=C
 ZTn5c64XVWPyaRnmPtVr5soOlB1b0I1jEM0S95YWlzamqLtXzVH4Q1ZLx7Rndqjb
 2/G4AH9vnxDUIx6jmehpy4qhHUHVP+Z2deM/SOZQr4Zi9XKE6oN5rXj7t9+dUnyj
 3qhglKHjAaOPBtDueoY5K56FZzE6RvczQedUWqfLayJxyk/570Cf8cZ6yB3AN5GM
 Nff4Io3DMR3R10NtkKt1wAbpzWkipffr3LsOJugYw1dGmluLk5V9CWF2WCoSvyib
 bTwfBBZGnsoR9rsDj1hKJ+XRgFlttFv02TJvkSBT371tssKRqp+/FlZEep/uBNWK
 aCtXMcUNLAr+bWQKT20Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775552; x=1780861952; bh=n
 V5gQGa7tVGGnv1cHuBOy8aHu7FdD1UW6rgORbw3idM=; b=ExS7tPDFPWdux59x/
 oXM2fadR2ChLYzwMIjiY5KN1fzpdk6Wjp44EHR9SYEgYdEMAFSkr+CNtTgmvJrNf
 Cow/33bzPm82aqUqqPgmwyqmHj0pC0rMeHgtKy6h3d8cUNigTQFSBX0GOuaxOXvB
 YwAfBDlXK8pWY5so8Zj3ZNq700dYF8dEAkdRD57jcIhlj3KII/1rCak030y5YW+E
 D73UTWGwUC4fohY7wxlFF6qd08FgoC6iF+4/FafS3GTN+3Z+mSHJIL3ABdxazr+r
 c5paz95T+R/eqRDW/5GIenH5r+ZBrDVJsEuMHaqkcijUekb8y9MGd5aU9PgzMEhR
 /SWng==
X-ME-Sender: <xms:gHokasEbrzsjH7Ct1A2pONwg88I2cG6uVJXUbQNGj4LtBSwx7DPGFA>
 <xme:gHokaswuPGKaGdzcdnL9nqc7hXisDU3tX_xmZnN5drcQSrX361JM8XLl5hcjRBIRx
 fvHn9dNAPqnBdl2IFIfyRG0xmxRlp7l7RQQNAZj5uCr5F_UasOgQiw>
X-ME-Received: <xmr:gHokajg9OSb9o2O8oWmu1bjnJNxOQpkmJgpVE0oMZIol800wKMWaxJcA4FPP>
X-ME-Proxy-Cause: dmFkZTF5V5TJt4YyOidEvSaeu/MRla4xP+DmdZQhB39MOi6suQo+ewwhopiobLPZpZFZya
 cAlJGIfDtnd9YI9euUev0/BPlhx7gFnO282gf6qihxTXQ9XGsNSFgetoCcqBrBvyjHrANh
 atTdGgjKUldYBX7wk7l0Cl09WJIHvldYLH4ZomEKYEpVZT82+Oh5snshv7XK6+9Sb5cWbw
 e84vQB5olzLLZrdcgzNge+k12PyvF6W544E61zazKBZo950akvs+WrgTOdnqD9gQaa29eu
 Mvbl6jhgYAGUnVDqLD0fWkRRImSA3/gMsTXu4gQwDYtEjGvTqg8SUjhCR0pAYP3BvhiErw
 /9pzAr9QNUhJnS4q8suxaG7qN4Lbm/eNTakOGGrANR1UkwRn1wWem4EDm51Pf/kPhDD5aE
 5cZokUX57WSSkT8Qpgxxr8d3+NlI0UyKYgzAOT4qxoZrsz1gXT6d6gEtAzkRnRzHTOpz/9
 4UhGcdG4lHK8CMYCToRyGyCDCh2V6/YWSefBA177xsIcMgdWFv67xr9ntVmgnsx+GBHmq9
 jtRz0kOcp1KD/TXsaShRErFDI1uNR/WgzYGLGhWbGvOauNnVCwh/H5glDZf3FMncA/jbIy
 cE4AXGCnRa0RAPebhJaeuetq9RboUgRyxl//YledjAOrs2XOKh/ms61mmKfA
X-ME-Proxy: <xmx:gHokanzkyZuCp_fzExAPZs2ilCSbHL3MFbtq75U33ydNGl1m1b-Fvg>
 <xmx:gHokamIs70zXIj70ntCpxQPV7aCBgGthmRecpIZ12POrd2xIlCoqXw>
 <xmx:gHokauRyn5SY5iBhieP6D-WOrwkiI2NboB3sX1HODmqZYToC2naZlA>
 <xmx:gHokaurMH5nRIxtrGO7WWgddXy6Un15F_EvZEB_JQliDiiWKQC6xpA>
 <xmx:gHokaieOISl-ozL1HTndFyVpZaBjc93O_HMkEO6HGyWl5otlH10CHmqJ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:31 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 77189e14;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 1/7] ati-vga: Extract ati_reg_write() from ati_mm_write()
Date: Sat,  6 Jun 2026 15:52:10 -0400
Message-ID: <20260606195216.2524314-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Move register write logic into its own function. This is in preparation
for CCE engine support for register writes. MMIO writes will have their
own distinct policy that doesn't apply to writes made by the CCE engine.

Note: Because of the recursion in the MM_DATA handler the calls to
ati_mm_write needed to be changed to ati_reg_write. This means that
tracing output changes slightly for MM_DATA writes. Otherwise, this
is purely a refactor and does not change behavior.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 58 ++++++++++++++++++++++++++------------------
 hw/display/ati_int.h |  2 ++
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d77589df67..b4c9086188 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -562,32 +562,10 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
     }
 }
 
-static void ati_mm_write(void *opaque, hwaddr addr,
-                           uint64_t data, unsigned int size)
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size)
 {
-    ATIVGAState *s = opaque;
-
-    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
-        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
-    }
     switch (addr) {
-    case MM_INDEX:
-        s->regs.mm_index = data & ~3;
-        break;
-    case MM_DATA ... MM_DATA + 3:
-        /* indexed access to regs or memory */
-        if (s->regs.mm_index & BIT(31)) {
-            uint32_t idx = s->regs.mm_index & ~BIT(31);
-            if (idx <= s->vga.vram_size - size) {
-                stn_le_p(s->vga.vram_ptr + idx, size, data);
-            }
-        } else if (s->regs.mm_index > MM_DATA + 3) {
-            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
-        }
-        break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
     {
         int i = (addr - BIOS_0_SCRATCH) / 4;
@@ -1043,6 +1021,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     }
 }
 
+static void ati_mm_write(void *opaque, hwaddr addr,
+                         uint64_t data, unsigned int size)
+{
+    ATIVGAState *s = opaque;
+
+    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
+        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
+    }
+    switch (addr) {
+    case MM_INDEX:
+        s->regs.mm_index = data & ~3;
+        break;
+    case MM_DATA ... MM_DATA + 3:
+        /* indexed access to regs or memory */
+        if (s->regs.mm_index & BIT(31)) {
+            uint32_t idx = s->regs.mm_index & ~BIT(31);
+            if (idx <= s->vga.vram_size - size) {
+                stn_le_p(s->vga.vram_ptr + idx, size, data);
+            }
+        } else if (s->regs.mm_index > MM_DATA + 3) {
+            ati_reg_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
+        }
+        break;
+    default:
+        ati_reg_write(s, addr, data, size);
+        break;
+    }
+}
+
 static const MemoryRegionOps ati_mm_ops = {
     .read = ati_mm_read,
     .write = ati_mm_write,
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 0c48934d33..18dca730c3 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -128,6 +128,8 @@ struct ATIVGAState {
 };
 
 const char *ati_reg_name(int num);
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size);
 
 void ati_2d_blt(ATIVGAState *s);
 bool ati_host_data_flush(ATIVGAState *s);
-- 
2.53.0


