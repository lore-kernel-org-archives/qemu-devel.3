Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1CCEFCF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFE-0004M6-M9; Tue, 06 Jan 2026 13:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF4-0004I5-Ea
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:19 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0001xG-Ea
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:18 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F2EB07A0122;
 Tue,  6 Jan 2026 13:57:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 13:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725831; x=
 1767812231; bh=gV85BtOa3ju7+rchpWU4AtKlDgPfTrv/o/idwmCmK1w=; b=N
 5LwwaBtIi2BizBsyXpZ7k4AoYQ8zM6JSndKdnl7pm+E2+v3pTKMIdfE4RwK3fzCl
 FapSvTvqyI/pCJKWoij65WAbl6WFMM5BiIa5TRbgAEkbWU/KtJuhSQjBOVqHkmKG
 a1u3H2X/DsCsrJymTLsvEi61I5qSADLx7KrQ5O1QG8VFN9mWbk5EnCdX6z9O9RXg
 8t6RuGrcZsdJfdMxz/k23nmKc/YTGZUkkXJa1LFlqWQ6yqxV2mFFxQRUt7yB3Too
 yNyiu4h0mxGJz+rTlUHlAno7wdIKDAeOTRCpGZrodQht8SAB00RXmsG+dGbsk2iL
 L9BrKin+jOtH+e2w5DQFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725831; x=1767812231; bh=g
 V85BtOa3ju7+rchpWU4AtKlDgPfTrv/o/idwmCmK1w=; b=PEQ+AUqFguyBf1GmJ
 Y4Y0C+nPECBBz2oL4JTC0rg1RGXJ834vfSLQqcOm8bioYc5lyeP6tJVeXlUAhOIQ
 6EVldVZyKJuZkD28PdXOVFHxAP3wBlrvKxbXhNB2a+EWQbKG+IaLE6GO9hnmzEm9
 vWy6cgTkJG22ZwWRU0P3T/lG4mBaHZsJ0QkregraOBLQ584TbdeDPVflIfmd3Urh
 2qcy/zlNunvmsb6UNSz1sm46WlpNsX/avmnDUGKWIiy6tDF0zBxCqdHQj/frTAiE
 SWZ5XHQwonUcv02G+sAhxTB17mI4VvdjUxhkAt8taVGUYu644/Z3WSC9rDadvXQz
 w2Ccw==
X-ME-Sender: <xms:B1tdafz678hWDvl7P5NbopT3uyHNyzu0zTWO-620dLQAezW5ZkT8KQ>
 <xme:B1tdaes8zsN2gbDstfjsrfjp77J4hsGgIpDvX9Il29OtwHCCt0bcIwhkfVRBjpqOn
 dgWUEGWJoD2VA1liPxfqll0zQj-pn9tS8l86e4jDBKTM6DV8Vx5zg>
X-ME-Received: <xmr:B1tdaWsardCPXZACV9ZFEgQW-q9G4cWIM9tV2kqP-KUPAh0x-cgsxuUc-pAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:B1tdaTPl3mwbSuvYsLPSARmI-AZJeZix9F_GPLpVUpWmR2PvQ0k6Aw>
 <xmx:B1tdaU3kOIwsb3iyCBWjJbX99NC58tA8FagbdbZHkVDS-vaM022VCQ>
 <xmx:B1tdafPj4xga7YkrrtJ0xBjNpkvXTEF-fc1MM7T8pc6c0VzofLhQWw>
 <xmx:B1tdaU1qq6O6ZKkVV23Cf0-i1JKfXhIidLBNIm7e7m4HLt0OeOujHg>
 <xmx:B1tdac4i-xNCwzUuwkKNGWtzSaqXKEAr5ckyn4Vdo7gBbnaWvBx-8aHq>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ac256117;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 6/9] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Tue,  6 Jan 2026 13:56:57 -0500
Message-ID: <20260106185700.2102742-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Use scissor registers to clip blit operations. This is required
for text rendering in X using the r128 driver. Without it overly-wide
glyphs are drawn and create all sorts of chaos.

Use QemuRect helpers for calculating the intersection of the
destination and scissor rectangles. Source coordinates are
also updated to reflect clipping. The original destination dimensions
are stored in 'dst' while the clipped rectangle is in 'visible' for
clear distinction between the two.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 110 +++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b8df549474..145eb487c4 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -43,6 +44,19 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static QemuRect dst_rect(ATIVGAState *s)
+{
+    QemuRect dst;
+    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                     s->regs.dst_x :
+                     s->regs.dst_x + 1 - s->regs.dst_width);
+    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.dst_y :
+                     s->regs.dst_y + 1 - s->regs.dst_height);
+    qemu_rect_init(&dst, dst_x, dst_y, s->regs.dst_width, s->regs.dst_height);
+    return dst;
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -51,11 +65,21 @@ void ati_2d_blt(ATIVGAState *s)
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
-            (s->regs.dp_rop3));
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+            s->regs.dp_rop3);
+
+    QemuRect dst = dst_rect(s);
+    QemuRect scissor;
+    qemu_rect_init(&scissor,
+                   s->regs.sc_left, s->regs.sc_top,
+                   s->regs.sc_right - s->regs.sc_left + 1,
+                   s->regs.sc_bottom - s->regs.sc_top + 1);
+    QemuRect visible;
+    if (!qemu_rect_intersect(&dst, &scissor, &visible)) {
+        return;
+    }
+    uint32_t src_left_offset = visible.x - dst.x;
+    uint32_t src_top_offset = visible.y - dst.y;
+
     int bpp = ati_bpp_from_datatype(s);
     if (!bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -73,17 +97,16 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride *= bpp;
     }
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+    if (visible.x > 0x3fff || visible.y > 0x3fff || dst_bits >= end
+        || dst_bits + visible.x
+         + (visible.y + visible.height) * dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            s->regs.dst_width, s->regs.dst_height,
+            s->regs.src_x, s->regs.src_y, dst.x, dst.y, dst.width, dst.height,
             (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
             (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
     switch (s->regs.dp_rop3) {
@@ -91,9 +114,11 @@ void ati_2d_blt(ATIVGAState *s)
     {
         bool fallback = false;
         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
+                         s->regs.src_x + src_left_offset :
+                         s->regs.src_x + 1 - dst.width + src_left_offset);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+                         s->regs.src_y + src_top_offset :
+                         s->regs.src_y + 1 - dst.height + src_top_offset);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -107,7 +132,7 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + visible.height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -116,31 +141,31 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height);
+                src_x, src_y, visible.x, visible.y,
+                visible.width, visible.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
                                    src_stride, dst_stride, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   src_x, src_y, visible.x, visible.y,
+                                   visible.width, visible.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = s->regs.dst_width * (bpp / 8);
+            int llb = visible.width * (bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     visible.height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
                                    src_stride, tmp_stride, bpp, bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   visible.width, visible.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
                                        tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                                       0, 0, visible.x, visible.y,
+                                       visible.width, visible.height);
             }
             g_free(tmp);
         } else
@@ -153,17 +178,17 @@ void ati_2d_blt(ATIVGAState *s)
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
 
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp;
+            for (y = 0; y < visible.height; y++) {
+                i = visible.x * bypp;
                 j = src_x * bypp;
                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (dst_y + y) * dst_pitch;
+                    i += (visible.y + y) * dst_pitch;
                     j += (src_y + y) * src_pitch;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                    i += (visible.y + visible.height - 1 - y) * dst_pitch;
+                    j += (src_y + visible.height - 1 - y) * src_pitch;
                 }
-                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+                memmove(&dst_bits[i], &src_bits[j], visible.width * bypp);
             }
         }
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
@@ -171,13 +196,13 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    visible.y * surface_stride(ds),
+                                    visible.height * surface_stride(ds));
         }
         s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         dst_x + s->regs.dst_width : dst_x);
+                         visible.x + visible.width : visible.x);
         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+                         visible.y + visible.height : visible.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -202,20 +227,21 @@ void ati_2d_blt(ATIVGAState *s)
 
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height, filler);
+                dst_bits, dst_stride, bpp, visible.x, visible.y,
+                visible.width, visible.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
+                         visible.x, visible.y, visible.width, visible.height,
+                         filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_pitch;
-                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
+            for (y = 0; y < visible.height; y++) {
+                i = visible.x * bypp + (visible.y + y) * dst_pitch;
+                for (x = 0; x < visible.width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
             }
@@ -225,11 +251,11 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    visible.y * surface_stride(ds),
+                                    visible.height * surface_stride(ds));
         }
         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+                         visible.y + visible.height : visible.y);
         break;
     }
     default:
-- 
2.51.2


