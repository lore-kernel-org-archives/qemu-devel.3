Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057FEEB57B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9ob-0002GC-3r; Wed, 31 Dec 2025 22:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0002Eg-02
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:31 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oX-0003iE-Hs
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:30 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id D42191D0004E;
 Wed, 31 Dec 2025 22:57:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 31 Dec 2025 22:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239848; x=
 1767326248; bh=UBMhpECL7fJYtSjBb4yOdqcIHAavnh9XXEqdzRKmpM8=; b=f
 DhzxabgMQljySU3Ewke3W28WMi+r6xyr2MA3DUPWigDTsbshW3mplCcxWTi3lzO8
 /OMAI7vOmyk406Puwvvxz57gXLMwh8f2eisWu/wqU3aa6GgDw14wLoqZ8OfnQlyn
 3beouCALMkxawIaUMfAZetlK6GZCfL+kQJncKZQRL9SGCeJ2RDxPiI+X2A7b8MwJ
 lOGJi0RBE/MZb0/4dASCgV1OS8waPHGBvLDfdH6++Jd1HbKJfr4FnPomjm/ygVJk
 WdbL7kS02+9O51TiIHr0dcioi1o/gSTxiUT6BcS29EI55+3cRclfjxmY1Pdv12IH
 1uTulnkTNhJm29RzxxBvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239848; x=1767326248; bh=U
 BMhpECL7fJYtSjBb4yOdqcIHAavnh9XXEqdzRKmpM8=; b=wKR4nLvadHXvCm5vI
 ssUXNnoyZyYYrCeiB8u1tSaFodVxGKkzyZJzu/UfVNn2RqFQ8+RgOTsLBbaXzCJN
 dtWSkDbOXMQcxeWp83ovH6lNNXGHd0CNKVt+uVVopFGubBNGAg5JJOw8F1mRF+J9
 oygHPRhjBiqI7KQWBxuO9RmpogMrMAafgwykodEgd4iLslXaNFE4BYEu3FZ1p1En
 0msNg8cWwJQ7Dy+mqRPibtKIFaB9xJZhSFto2z8aTc2NS8pBrzQSvLHLIpsP4YGW
 8+TKsFYCnNfkkB27O1JuR87CxwBWrz5OKxdwWhktgg0iLOdEUX+TVw/dkVnQNFyy
 B4Fgg==
X-ME-Sender: <xms:p_BVabKCDf5o5fP-DfQdACHA6WvOSHesIEKwqsOXG3ZAOnEhZ4XMgg>
 <xme:p_BVaWmJFtmWPhiI1FjeBo4mbKz-mMwn0_ykHz8RHrmGxyJV2D8lOSwwO2gSlfE0p
 1bJvx8fS-S1ALroD5z0vpaAKkaY0C1Xqcmc2Gmws2XLOvgclVkidXv7>
X-ME-Received: <xmr:p_BVaRHgVp24Gbwdognxs2zZYZGdRKukKQSQs8NChaSfyiG-vAtIR_g47iPR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhn
 segvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:p_BVaeEww0HTc-R4jo_c-rJ4KdY6GLHQP0RR-dvZo1UaYUOFVM491Q>
 <xmx:qPBVaWNx0_U7VVudJsZ3aJLPAA8qSGNEp2CvfT6PTA91tSTmgnt_EA>
 <xmx:qPBVaVG6uw6oBQdjP_GA5mkRe3wVCKofA0hGG2rk3PYWdx2DqZ_xeQ>
 <xmx:qPBVaVMk0l1Qx7ZyhRF4Yuy38VQhGLkV3lGevmVzOJ7MTCd_mOAL4w>
 <xmx:qPBVaVwaz7ENtMK7RYjEo0FCXJcdh49GDMoHbK1kWbT2IbwyTj0SIWOv>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id dd9c2156;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 1/7] ati-vga: Extract ati_reg_write() from ati_mm_write()
Date: Wed, 31 Dec 2025 22:55:49 -0500
Message-ID: <20260101035555.1300511-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
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

Move register write logic into its own function. This is in preparation
for CCE engine support for register writes. MMIO writes will have their
own distinct policy that doesn't apply to writes made by the CCE engine.

Note: Because of the recursion in the MM_DATA handler the calls to
ati_mm_write needed to be changed to ati_reg_write. This means that
tracing output changes slightly for MM_DATA writes. Otherwise, this
is purely a refactor and does not change behavior.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 25 ++++++++++++++++---------
 hw/display/ati_int.h |  2 ++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e9c3ad2cd1..33f8e211dc 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -530,14 +530,9 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
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
     case MM_INDEX:
         s->regs.mm_index = data & ~3;
@@ -550,10 +545,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                 stn_le_p(s->vga.vram_ptr + idx, size, data);
             }
         } else if (s->regs.mm_index > MM_DATA + 3) {
-            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+            ati_reg_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
-                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
+                "ati_reg_write: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
@@ -942,6 +937,18 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     }
 }
 
+
+static void ati_mm_write(void *opaque, hwaddr addr,
+                         uint64_t data, unsigned int size)
+{
+    ATIVGAState *s = opaque;
+
+    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
+        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
+    }
+    ati_reg_write(s, addr, data, size);
+}
+
 static const MemoryRegionOps ati_mm_ops = {
     .read = ati_mm_read,
     .write = ati_mm_write,
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b0..ea1a8bceab 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -105,5 +105,7 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size);
 
 #endif /* ATI_INT_H */
-- 
2.51.2


