Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED48D4A5E2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoR-0005xr-M4; Thu, 15 Jan 2026 21:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnx-0005qN-Mx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:22 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnu-0002Qt-0m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:17 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 5F1071D0007F;
 Thu, 15 Jan 2026 21:43:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 21:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531392; x=
 1768617792; bh=xcGTQxYooEV7acDTJpYUIDY2KtNsL1X3AN5+oPbdfcs=; b=M
 iH8BikwgL+4h8ISvdwiS60gCxujnruCm8mYrGm/bT19cdcfe0peFWZrvf0DwCJyx
 uUNJiOROg4lIzp6NPALL77IDW2XYoT4JuZA+DV7oZb29cb8ibqn245nz5iaPMo2d
 iVSHxDXu2wavSVu19JTtMW1qklDnyuy6C2t2pQ8IudbdwuGIdIFfbCGwa0eZS3h0
 Bmu+MDq+owxDVIvOxKzme0Y9M8KcIe1NxUielgJdjxgfqVhEhIoLzlW/YIEMmpOi
 tjEH0LBR6a+N0C3S33V7WTvdq9pZtYBJ7RZiiGkI6BYM2e3uL1IIu0zDGgKSj3Ob
 S3+MwRGmkgfAwAAt/L0eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531392; x=1768617792; bh=x
 cGTQxYooEV7acDTJpYUIDY2KtNsL1X3AN5+oPbdfcs=; b=iMdt5huNZ5rZ0s8Cc
 VPEKjPTASzoLyaZQgySoBxrjIcC3Ex8NQgGM0R2v3XQoNWz7EZqtzjTvdUt4R/wK
 EjL+G7SSvIRPbdtihSkCLxwtHw192wMEpBmon3FYTDOpfXhMokuv8f7HSIIoDPEF
 WrSe0Pbclgqsz6Uilg/ftrRCnoY0oh74CY0ZexC/d5+Z0hOgGl//6VUq5wPDvEN3
 bmBjdlI6fXPv3uKOkAh8deuESpKhfEMfYVGvxPeze1ByGybeAuGPBrzcaaPO4VeS
 uvzfFxVh/E9sJqQURlHKBGKeocMnIrVbq1DyrYrFY1vQ/NYTu2aCp14qyWx9fgSZ
 nDzIg==
X-ME-Sender: <xms:wKVpaTZ6thbgfc38IiLrnoEGzLODJQYE6ja0HMeAmnNqgD0Mx8LTDQ>
 <xme:wKVpaZ2EGM0XXom6Pcz974o5hY5sPaIj6JoHcEmQGpM0jgr8ZndWlJb8ugTO2orPk
 2UjgwSrwv_8OdTdEFdFcRYGtWTGWW2KoptWwE22I3FezgqqBgjObWA>
X-ME-Received: <xmr:wKVpaTWNz_WjU2iW52ddKBTRwUlTxCDeKHUNFt0QRs2XEDwIWZ-R0W9soVBq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wKVpaTVB4y3zX0MVc21Qmb59vu8tPeC85rOtOtUh-x4dbhzU6VKRqw>
 <xmx:wKVpaSfdlTNCzTPgsiWsTtSpNb-Z4XsdmhVzOuLjR5BqzXRPbwmIYQ>
 <xmx:wKVpacW0BVjb_fJY0ARGF6QATB8fgwBPm-LGvax4S7pBBkr9DbcAbA>
 <xmx:wKVpabf_RYSRwwlvFVwl1as2dc5JK3n-6mtYhPfOyztiFhXn7FIO6g>
 <xmx:wKVpafC1s3MBvGjNpRyiQ07BXgJi5BtIubRIlfxUPneTqicIBX5kLQgC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8f6fe13e;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
Date: Thu, 15 Jan 2026 21:42:52 -0500
Message-ID: <20260116024258.1487173-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

A large amount of the common setup involved in a blit deals with the
destination. This moves that setup to a helper function which
initializes a struct (ATIBltDst) holding all of the dst state. This setup
will be shared between blits from memory as well as from HOST_DATA.

Otherwise this is a pure refactor of the ati_2d_blt function to make use
of the setup_2d_blt_dst helper and the struct it initializes. There should
be no change in behavior in this patch.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 195 +++++++++++++++++++++++++-------------------
 1 file changed, 112 insertions(+), 83 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a8c4c534b9..75bd38e9b0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -24,7 +25,16 @@
  * possible.
  */
 
-static int ati_bpp_from_datatype(ATIVGAState *s)
+typedef struct {
+    QemuRect rect;
+    int bpp;
+    int stride;
+    bool top_to_bottom;
+    bool left_to_right;
+    uint8_t *bits;
+} ATIBltDst;
+
+static int ati_bpp_from_datatype(const ATIVGAState *s)
 {
     switch (s->regs.dp_datatype & 0xf) {
     case 2:
@@ -43,57 +53,76 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static void setup_2d_blt_dst(const ATIVGAState *s, ATIBltDst *dst)
+{
+    unsigned dst_x, dst_y;
+    dst->bpp = ati_bpp_from_datatype(s);
+    dst->stride = s->regs.dst_pitch;
+    dst->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    dst->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    dst->bits = s->vga.vram_ptr + s->regs.dst_offset;
+    dst_x = (dst->left_to_right ?
+            s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
+    dst_y = (dst->top_to_bottom ?
+            s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+    qemu_rect_init(&dst->rect, dst_x, dst_y,
+                   s->regs.dst_width, s->regs.dst_height);
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        dst->bits += s->regs.crtc_offset & 0x07ffffff;
+        dst->stride *= dst->bpp;
+    }
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+    int dst_stride_words;
+    ATIBltDst _dst; /* TEMP: avoid churn in future patches */
+    ATIBltDst *dst = &_dst;
+
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
+
+    setup_2d_blt_dst(s, dst);
+
+    if (!dst->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
+    if (!dst->stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
-
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
-    }
-    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+    if (dst->rect.x > 0x3fff || dst->rect.y > 0x3fff || dst->bits >= end
+        || dst->bits + dst->rect.x
+         + (dst->rect.y + dst->rect.height) * dst->stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
+
+    dst_stride_words = dst->stride / sizeof(uint32_t);
+
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            s->regs.dst_width, s->regs.dst_height,
-            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
-            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
+            s->regs.src_pitch, dst->stride, s->regs.default_pitch,
+            s->regs.src_x, s->regs.src_y, dst->rect.x, dst->rect.y,
+            dst->rect.width, dst->rect.height,
+            (dst->left_to_right ? '>' : '<'),
+            (dst->top_to_bottom ? 'v' : '^'));
+
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+        unsigned src_x = (dst->left_to_right ?
+                       s->regs.src_x : s->regs.src_x + 1 - dst->rect.width);
+        unsigned src_y = (dst->top_to_bottom ?
+                       s->regs.src_y : s->regs.src_y + 1 - dst->rect.height);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -103,44 +132,47 @@ void ati_2d_blt(ATIVGAState *s)
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            src_stride *= dst->bpp;
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + dst->rect.height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height);
+                src_bits, dst->bits,
+                src_stride, dst_stride_words,
+                dst->bpp, dst->bpp,
+                src_x, src_y, dst->rect.x, dst->rect.y,
+                dst->rect.width, dst->rect.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
-            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
-            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   s->regs.dst_width, s->regs.dst_height);
+            dst->left_to_right && dst->top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst->bits,
+                                   src_stride, dst_stride_words,
+                                   dst->bpp, dst->bpp,
+                                   src_x, src_y, dst->rect.x, dst->rect.y,
+                                   dst->rect.width, dst->rect.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = s->regs.dst_width * (bpp / 8);
+            int llb = dst->rect.width * (dst->bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     dst->rect.height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride, tmp_stride,
+                                   dst->bpp, dst->bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   dst->rect.width, dst->rect.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                fallback = !pixman_blt(tmp, (uint32_t *)dst->bits,
+                                       tmp_stride, dst_stride_words,
+                                       dst->bpp, dst->bpp,
+                                       0, 0, dst->rect.x, dst->rect.y,
+                                       dst->rect.width, dst->rect.height);
             }
             g_free(tmp);
         } else
@@ -149,35 +181,33 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = bpp / 8;
+            unsigned int y, i, j, bypp = dst->bpp / 8;
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp;
+            for (y = 0; y < dst->rect.height; y++) {
+                i = dst->rect.x * bypp;
                 j = src_x * bypp;
-                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (dst_y + y) * dst_pitch;
+                if (dst->top_to_bottom) {
+                    i += (dst->rect.y + y) * dst->stride;
                     j += (src_y + y) * src_pitch;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                    i += (dst->rect.y + dst->rect.height - 1 - y) * dst->stride;
+                    j += (src_y + dst->rect.height - 1 - y) * src_pitch;
                 }
-                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+                memmove(&dst->bits[i], &src_bits[j], dst->rect.width * bypp);
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    dst->rect.y * surface_stride(ds),
+                                    dst->rect.height * surface_stride(ds));
         }
-        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         dst_x + s->regs.dst_width : dst_x);
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+        s->regs.dst_x = (dst->left_to_right ?
+                         dst->rect.x + dst->rect.width : dst->rect.x);
+        s->regs.dst_y = (dst->top_to_bottom ?
+                         dst->rect.y + dst->rect.height : dst->rect.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -200,36 +230,35 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height, filler);
+                dst->bits, dst_stride_words, dst->bpp, dst->rect.x, dst->rect.y,
+                dst->rect.width, dst->rect.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst->bits,
+                    dst_stride_words, dst->bpp, dst->rect.x, dst->rect.y,
+                    dst->rect.width, dst->rect.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_pitch;
-                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = dst->bpp / 8;
+            for (y = 0; y < dst->rect.height; y++) {
+                i = dst->rect.x * bypp + (dst->rect.y + y) * dst->stride;
+                for (x = 0; x < dst->rect.width; x++, i += bypp) {
+                    stn_he_p(&dst->bits[i], bypp, filler);
                 }
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    dst->rect.y * surface_stride(ds),
+                                    dst->rect.height * surface_stride(ds));
         }
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+        s->regs.dst_y = (dst->top_to_bottom ?
+                         dst->rect.y + dst->rect.height : dst->rect.y);
         break;
     }
     default:
-- 
2.51.2


