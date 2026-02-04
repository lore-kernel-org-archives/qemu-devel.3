Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85235E9D411
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1Y-0007Fb-DF; Wed, 04 Feb 2026 11:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1E-00071q-0s
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng18-0004XW-Ss
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:19 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id EEF4F1D0016F;
 Wed,  4 Feb 2026 11:46:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223573; x=
 1770309973; bh=y5Txo/ge3wt7aVEEtskxAjDd4xcVvCJ4m6h2lSWpD1Q=; b=L
 pUmm6RBI47uX/2iV7XMLad7jUZa49EDU68m4sd34J38e8bAg9Sx6YTn8iSxiDTV3
 7noZoYywLAiKMeLL1hAoQlBBkdyATe4Y1dmQIAxQmnb6Lce3CtCyuTLMiLEt8oRP
 rBINq3F2ZojAg2rMs8HnrAwH/YKWbfyYbG4CEbyK1egP8VkZ2MsjapTPbHmFK5jE
 ztK0seSlLQqb9uX0nvgva4fkZ1QTKSLyvwKFKkgdxnIj9GOXnPENu8QS5e2VzKvK
 yziGDnBlpnWDIQrx8pl00nNGLEqJ7fManh1HfrIc2JWs2DT7ZjN4w/KfjC62/x9a
 J0wPraYFtXsZkM1P4MUpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223573; x=1770309973; bh=y
 5Txo/ge3wt7aVEEtskxAjDd4xcVvCJ4m6h2lSWpD1Q=; b=Z4gtT/nrcsixZmC5z
 mYcaaa2iT9Nu7xzX+n1eMOVedbmD3q36CgPjEv3vCRjbP2hLbDnMpausDCC/JkB9
 49DPJLyVSUQ/kf4AO775YmIN3xXjDRrP9LhENthQuQIWLrykgYhzIkijtNZW+/gC
 7L8U4mOiA+HBi7Hu/0ZO2/4ehvesquGJRK/2DhxtSqHchQ/4oV1YxODcwxgRh9/n
 OLWkGyGIrvbuSYpb+uwJ4QM6QMf05eqY9FbiojtmQDXFbuJMRP4rkkoWhGWxKE3R
 MBp0XZStSew8CZDWcAkySmJLQI2wHNoy0TkLncWWhpIcvcRfhdA2pdiL4qGhWbdA
 5cgQA==
X-ME-Sender: <xms:1XeDaXddbICp96WgUcH34CSkoiv6_lbockTd9lzL1aO-uMC0L770Jg>
 <xme:1XeDaUqtohfoXr8G5KH39fmR90f9KiPNvSSgZwaziSaIiNagIcsTrp4fLmV3GoEL0
 0gic99degY63jYF2ulVKu92NXk1U1d3HoEINoCvxenmk6clH_998IA>
X-ME-Received: <xmr:1XeDad5MqlieIB6xJyuL_GDp5t3fYtcBzvj7Tf-tML8PTZr2wRwEeQy74917>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1XeDaSqyBAtFqx07WZnZlgMNQDHM8cghGKorIpSAcbNhnc-xxgckUA>
 <xmx:1XeDaXgTK_64nB2D9X7LVk9KCJt5QcJ3LfwK6d9ab3gT1Uqn3-CsOw>
 <xmx:1XeDaUKbBvlHrfZuOxlyMb6Z0pzaM64aAren49lYFTaILxcB-lm9Kw>
 <xmx:1XeDafBw-MEFtwLJDi0QpOHJyL2eMQ-SrAZTSBbMVeXySly20paVdA>
 <xmx:1XeDabUn6y0iO-Tp05s9zKbBUsCO0L433ARbwJYR4d07OmMGZot5oWPk>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id aabaaa6e;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 11/18] ati-vga: Introduce ATI2DCtx struct for 2D blit
 context
Date: Wed,  4 Feb 2026 11:45:59 -0500
Message-ID: <20260204164606.3425246-12-chad@jablonski.xyz>
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

Previously all state derived from registers was moved to locals. Now we
can mechanically replace those locals with fields on the new ATI2DCtx
struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 222 +++++++++++++++++++++++++-------------------
 1 file changed, 126 insertions(+), 96 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 618aedc3da..4154202677 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -43,21 +44,39 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
-static void ati_set_dirty(ATIVGAState *s,
-                          const uint8_t *dst_bits, unsigned dst_y)
+typedef struct {
+    int bpp;
+    uint32_t rop3;
+    bool left_to_right;
+    bool top_to_bottom;
+    uint32_t frgd_clr;
+    const uint8_t *palette;
+    const uint8_t *vram_end;
+
+    QemuRect dst;
+    int dst_stride;
+    uint8_t *dst_bits;
+    uint32_t dst_offset;
+
+    QemuRect src;
+    int src_stride;
+    const uint8_t *src_bits;
+} ATI2DCtx;
+
+static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
-    VGACommonState *vga = &s->vga;
     DisplaySurface *ds = qemu_console_surface(vga->con);
 
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
-        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+            ctx->rop3 >> 16);
+    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
         memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
-                                s->regs.dst_offset + dst_y * surface_stride(ds),
-                                s->regs.dst_height * surface_stride(ds));
+                                ctx->dst_offset + ctx->dst.y
+                                * surface_stride(ds),
+                                ctx->dst.height * surface_stride(ds));
     }
 }
 
@@ -67,100 +86,105 @@ void ati_2d_blt(ATIVGAState *s)
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    int rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
-    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
-    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
-    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
-    uint8_t *palette = s->vga.palette;
-    unsigned dst_offset = s->regs.dst_offset;
-    unsigned dst_width = s->regs.dst_width;
-    unsigned dst_height = s->regs.dst_height;
-    unsigned dst_x = (left_to_right ?
-                     s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
-    unsigned dst_y = (top_to_bottom ?
-                     s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
+    ATI2DCtx ctx_;
+    ATI2DCtx *ctx = &ctx_;
+    ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
+    ctx->palette = s->vga.palette;
+    ctx->dst_offset = s->regs.dst_offset;
+    ctx->dst.width = s->regs.dst_width;
+    ctx->dst.height = s->regs.dst_height;
+    ctx->dst.x = (ctx->left_to_right ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
+    ctx->dst.y = (ctx->top_to_bottom ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
+    ctx->bpp = ati_bpp_from_datatype(s);
+    if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
+    ctx->dst_stride = s->regs.dst_pitch;
+    if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
+    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
+        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx->dst_stride *= ctx->bpp;
     }
-    int dst_stride_words = dst_stride / sizeof(uint32_t);
-    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x + (dst_y + dst_height) * dst_stride >= end) {
+    int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
+    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
+    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
+        || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
+         + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, dst_stride, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            dst_width, dst_height,
-            (left_to_right ? '>' : '<'),
-            (top_to_bottom ? 'v' : '^'));
-    switch (rop3) {
+            s->regs.src_offset, ctx->dst_offset, s->regs.default_offset,
+            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
+            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
+            ctx->dst.width, ctx->dst.height,
+            (ctx->left_to_right ? '>' : '<'),
+            (ctx->top_to_bottom ? 'v' : '^'));
+    switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (left_to_right ?
-                         s->regs.src_x : s->regs.src_x + 1 - dst_width);
-        unsigned src_y = (top_to_bottom ?
-                         s->regs.src_y : s->regs.src_y + 1 - dst_height);
-        int src_stride = s->regs.src_pitch;
-        if (!src_stride) {
+        ctx->src.x = (ctx->left_to_right ?
+                     s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
+        ctx->src.y = (ctx->top_to_bottom ?
+                     s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
+        ctx->src_stride = s->regs.src_pitch;
+        if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
+        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
+            ctx->src_stride *= ctx->bpp;
         }
-        int src_stride_words = src_stride / sizeof(uint32_t);
-        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
-            || src_bits + src_x
-             + (src_y + dst_height) * src_stride >= end) {
+        int src_stride_words = ctx->src_stride / sizeof(uint32_t);
+        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
+            || ctx->src_bits >= ctx->vram_end
+            || ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height)
+             * ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride_words, dst_stride_words,
-                bpp, bpp, src_x, src_y, dst_x, dst_y,
-                dst_width, dst_height);
+                ctx->src_bits, ctx->dst_bits, src_stride_words,
+                dst_stride_words, ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y,
+                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height);
 #ifdef CONFIG_PIXMAN
-        if (use_pixman_blt && left_to_right && top_to_bottom) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride_words, dst_stride_words, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   dst_width, dst_height);
+        if (use_pixman_blt && ctx->left_to_right && ctx->top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits,
+                                   (uint32_t *)ctx->dst_bits, src_stride_words,
+                                   dst_stride_words, ctx->bpp, ctx->bpp,
+                                   ctx->src.x, ctx->src.y, ctx->dst.x,
+                                   ctx->dst.y, ctx->dst.width, ctx->dst.height);
         } else if (use_pixman_blt) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = dst_width * (bpp / 8);
+            int llb = ctx->dst.width * (ctx->bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     dst_height);
-            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride_words, tmp_stride, bpp, bpp,
-                                   src_x, src_y, 0, 0,
-                                   dst_width, dst_height);
+                                     ctx->dst.height);
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
+                                   src_stride_words, tmp_stride, ctx->bpp,
+                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
+                                   ctx->dst.width, ctx->dst.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride_words, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
-                                       dst_width, dst_height);
+                fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
+                                       tmp_stride, dst_stride_words, ctx->bpp,
+                                       ctx->bpp, 0, 0, ctx->dst.x, ctx->dst.y,
+                                       ctx->dst.width, ctx->dst.height);
             }
             g_free(tmp);
         } else
@@ -169,18 +193,21 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = bpp / 8;
-            for (y = 0; y < dst_height; y++) {
-                i = dst_x * bypp;
-                j = src_x * bypp;
-                if (top_to_bottom) {
-                    i += (dst_y + y) * dst_stride;
-                    j += (src_y + y) * src_stride;
+            unsigned int y, i, j, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp;
+                j = ctx->src.x * bypp;
+                if (ctx->top_to_bottom) {
+                    i += (ctx->dst.y + y) * ctx->dst_stride;
+                    j += (ctx->src.y + y) * ctx->src_stride;
                 } else {
-                    i += (dst_y + dst_height - 1 - y) * dst_stride;
-                    j += (src_y + dst_height - 1 - y) * src_stride;
+                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
+                         * ctx->dst_stride;
+                    j += (ctx->src.y + ctx->dst.height - 1 - y)
+                         * ctx->src_stride;
                 }
-                memmove(&dst_bits[i], &src_bits[j], dst_width * bypp);
+                memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
+                        ctx->dst.width * bypp);
             }
         }
         break;
@@ -191,35 +218,38 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (rop3) {
+        switch (ctx->rop3) {
         case ROP3_PATCOPY:
-            filler = frgd_clr;
+            filler = ctx->frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
-                                                   palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
+                                                   ctx->palette[1],
+                                                   ctx->palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
-                                                   palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[3],
+                                                   ctx->palette[4],
+                                                   ctx->palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride_words, bpp, dst_x, dst_y,
-                dst_width, dst_height, filler);
+                ctx->dst_bits, dst_stride_words, ctx->bpp, ctx->dst.x,
+                ctx->dst.y, ctx->dst.width, ctx->dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride_words, bpp, dst_x,
-                         dst_y, dst_width, dst_height, filler))
+            !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
+                         ctx->dst.x, ctx->dst.y,
+                         ctx->dst.width, ctx->dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            for (y = 0; y < dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_stride;
-                for (x = 0; x < dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
+                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
+                    stn_he_p(&ctx->dst_bits[i], bypp, filler);
                 }
             }
         }
@@ -227,9 +257,9 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      rop3 >> 16);
+                      ctx->rop3 >> 16);
         return;
     }
 
-    ati_set_dirty(s, dst_bits, dst_y);
+    ati_set_dirty(&s->vga, ctx);
 }
-- 
2.52.0


