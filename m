Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A419D4A5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoP-0005x9-VB; Thu, 15 Jan 2026 21:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo2-0005qa-EH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:27 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0002SB-Fp
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:22 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 971B21D00099;
 Thu, 15 Jan 2026 21:43:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531393; x=
 1768617793; bh=d1iXvXcdM9g7qg5Sr1ETV1BMhOz1njZpEnObm+hPq08=; b=T
 bqbsGib0aDDHgsZkepriJzEuNbR7HurBFGy41xL8z+IVO9DT27lEy1De0A5ujPFy
 AgqOg2iPWedgWNy3pt9Nl5CHNtpHEZVSr/ILHZLiX2sfpilWOtvYfkCmJZSYFjJs
 wLXWw85bfmXHNWs0z4wtoM1+IYFk9/WbXpsS5zrKIXaZAJvZk6Y8AHAGX/cAy/zl
 xZotzMu0HtcJp4N4zB26kaiA/b/QJowguhgS6Jnn4PWlRd4qV17NV+kA1Ep6ujZR
 neQ5tM8mMTw0NAKlCObud+cyrXBFp2v+wMcdQ8Gof37JiMoh6xZfM9DQyH30qmRx
 4TLdKwRJQdkdOwhSlTj1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531393; x=1768617793; bh=d
 1iXvXcdM9g7qg5Sr1ETV1BMhOz1njZpEnObm+hPq08=; b=EF2VbzsIDpPzQKj33
 yCaKyJ4xNz/x9HK8x7DxCQpPV6Iy3+UnO6T/ZDyEntAokjLvsUn8Lmxa3cPabzqG
 nOcVAD91PM1OJUkBwPyeI68sRU1jYv05HhFrxp/dibU2UwKxdInkP7KabrYazLah
 +MbhVbkmrNYjAV2zhE1xIh4SKEOfa1bu6/Sgyi4QfK3or6FBHNVg1vVX6D/yRbje
 OEAovqRZrX7wDY1pdiBiPltAotG7CGWSKgkKtcAND6LNoGigiMqN71zr/h/x4nWs
 gspVsG4/NnVjWwAx4aejck1JcZmbnGnHQHIJm0uTP/ywbYKz0mIpKaDA3uA4lE3W
 CIJbA==
X-ME-Sender: <xms:waVpafOBWalEKzsKWqlLx5aixVpmDaqFGxfMvEThN6bP7EcnVkYJWg>
 <xme:waVpaRaesr37o9uXWjudv9GiiDO3uvSax1gmsRaGQW94zxdtJiVi4pnDEji1GhWII
 K9XoFU47zBjoOM26NKeL9zdwPN5DQNaIjEcnlRscdLsPsS0AkHy2gk>
X-ME-Received: <xmr:waVpabob20N8iuTCh4f6rf7_nKEgU9cxNho49N_AQO6AWhQHq1w5UJeNvAoa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:waVpadZtdoOvcixy7wj56KsB58UfxH-cwRxMNZSu8YEK64a2wAmVKw>
 <xmx:waVpabSDxJ8uiM_oNf0_fKJ9hU_0WJazPPvtusOo4gm3KVK_ZlBvtg>
 <xmx:waVpac5MgSE17SaaniAjT7_Wb2nv80H065KxiDzEqzQi6nhGDF_whQ>
 <xmx:waVpaYzRyU5tLsqTD2lmk-QmHU0pbzujjsERa2JQxch5GUTyVxCOlw>
 <xmx:waVpaSEYn8RzIRMjvK53_SWSTx9PTaOSz6kU5YW6eLo3_Aw2rM-QP3Bu>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 52e9db10;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 10/12] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Thu, 15 Jan 2026 21:42:56 -0500
Message-ID: <20260116024258.1487173-11-chad@jablonski.xyz>
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

Use scissor registers to clip blit operations. This is required
for text rendering in X using the r128 driver. Without it overly-wide
glyphs are drawn and create all sorts of chaos.

The visible destination rectangle (vis_dst) is the intersection of the
scissor rectangle and the destination rectangle (dst.rect).

The src also needs to be offset if clipped on the top and/or
left sides to ensure that src data is read correctly and appears
clipped when drawn rather than shifted.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 81 ++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 691e0f0702..a5dc5ba98e 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -86,7 +86,8 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    int dst_stride_words, src_stride_words;
+    int dst_stride_words, src_stride_words, vis_src_x, vis_src_y;
+    QemuRect scissor, vis_dst;
 
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
@@ -108,14 +109,32 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
         return;
     }
 
+    qemu_rect_init(&scissor,
+                   s->regs.sc_left, s->regs.sc_top,
+                   s->regs.sc_right - s->regs.sc_left + 1,
+                   s->regs.sc_bottom - s->regs.sc_top + 1);
+    qemu_rect_intersect(&dst->rect, &scissor, &vis_dst);
+    if (!vis_dst.height || !vis_dst.width) {
+        /* Nothing to do, completely clipped */
+        return;
+    }
+
     dst_stride_words = dst->stride / sizeof(uint32_t);
     src_stride_words = src->stride / sizeof(uint32_t);
+    /*
+     * The src must be offset if clipping is applied to the dst.
+     * This is so that when the source is blit to a dst clipped
+     * on the top or left the src image is not shifted into the
+     * clipped region but actually clipped.
+     */
+    vis_src_x = src->x + (vis_dst.x - dst->rect.x);
+    vis_src_y = src->y + (vis_dst.y - dst->rect.y);
 
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             src->stride, dst->stride, s->regs.default_pitch,
-            src->x, src->y, dst->rect.x, dst->rect.y,
-            dst->rect.width, dst->rect.height,
+            vis_src_x, vis_src_y, vis_dst.x, vis_dst.y,
+            vis_dst.width, vis_dst.height,
             (dst->left_to_right ? '>' : '<'),
             (dst->top_to_bottom ? 'v' : '^'));
 
@@ -133,33 +152,33 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
                 src->bits, dst->bits,
                 src_stride_words, dst_stride_words,
                 dst->bpp, dst->bpp,
-                src->x, src->y, dst->rect.x, dst->rect.y,
-                dst->rect.width, dst->rect.height);
+                vis_src_x, vis_src_y, vis_dst.x, vis_dst.y,
+                vis_dst.width, vis_dst.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             dst->left_to_right && dst->top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)src->bits, (uint32_t *)dst->bits,
                                    src_stride_words, dst_stride_words,
                                    dst->bpp, dst->bpp,
-                                   src->x, src->y, dst->rect.x, dst->rect.y,
-                                   dst->rect.width, dst->rect.height);
+                                   vis_src_x, vis_src_y, vis_dst.x, vis_dst.y,
+                                   vis_dst.width, vis_dst.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = dst->rect.width * (dst->bpp / 8);
+            int llb = vis_dst.width * (dst->bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     dst->rect.height);
+                                     vis_dst.height);
             fallback = !pixman_blt((uint32_t *)src->bits, tmp,
                                    src_stride_words, tmp_stride,
                                    dst->bpp, dst->bpp,
-                                   src->x, src->y, 0, 0,
-                                   dst->rect.width, dst->rect.height);
+                                   vis_src_x, vis_src_y, 0, 0,
+                                   vis_dst.width, vis_dst.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst->bits,
                                        tmp_stride, dst_stride_words,
                                        dst->bpp, dst->bpp,
-                                       0, 0, dst->rect.x, dst->rect.y,
-                                       dst->rect.width, dst->rect.height);
+                                       0, 0, vis_dst.x, vis_dst.y,
+                                       vis_dst.width, vis_dst.height);
             }
             g_free(tmp);
         } else
@@ -169,17 +188,17 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = dst->bpp / 8;
-            for (y = 0; y < dst->rect.height; y++) {
-                i = dst->rect.x * bypp;
-                j = src->x * bypp;
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp;
+                j = vis_src_x * bypp;
                 if (dst->top_to_bottom) {
-                    i += (dst->rect.y + y) * dst->stride;
-                    j += (src->y + y) * src->stride;
+                    i += (vis_dst.y + y) * dst->stride;
+                    j += (vis_src_y + y) * src->stride;
                 } else {
-                    i += (dst->rect.y + dst->rect.height - 1 - y) * dst->stride;
-                    j += (src->y + dst->rect.height - 1 - y) * src->stride;
+                    i += (vis_dst.y + vis_dst.height - 1 - y) * dst->stride;
+                    j += (vis_src_y + vis_dst.height - 1 - y) * src->stride;
                 }
-                memmove(&dst->bits[i], &src->bits[j], dst->rect.width * bypp);
+                memmove(&dst->bits[i], &src->bits[j], vis_dst.width * bypp);
             }
         }
         break;
@@ -205,20 +224,20 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst->bits, dst_stride_words, dst->bpp, dst->rect.x, dst->rect.y,
-                dst->rect.width, dst->rect.height, filler);
+                dst->bits, dst_stride_words, dst->bpp, vis_dst.x, vis_dst.y,
+                vis_dst.width, vis_dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)dst->bits,
-                    dst_stride_words, dst->bpp, dst->rect.x, dst->rect.y,
-                    dst->rect.width, dst->rect.height, filler))
+                    dst_stride_words, dst->bpp, vis_dst.x, vis_dst.y,
+                    vis_dst.width, vis_dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = dst->bpp / 8;
-            for (y = 0; y < dst->rect.height; y++) {
-                i = dst->rect.x * bypp + (dst->rect.y + y) * dst->stride;
-                for (x = 0; x < dst->rect.width; x++, i += bypp) {
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp + (vis_dst.y + y) * dst->stride;
+                for (x = 0; x < vis_dst.width; x++, i += bypp) {
                     stn_he_p(&dst->bits[i], bypp, filler);
                 }
             }
@@ -237,7 +256,7 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
          * This has not yet been validated on R100 hardware.
          */
         s->regs.dst_y = (dst->top_to_bottom ?
-                        dst->rect.y + dst->rect.height : dst->rect.y);
+                        vis_dst.y + vis_dst.height : vis_dst.y);
     }
 
     if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
@@ -245,8 +264,8 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
         s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
         memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                 s->regs.dst_offset +
-                                dst->rect.y * surface_stride(ds),
-                                dst->rect.height * surface_stride(ds));
+                                vis_dst.y * surface_stride(ds),
+                                vis_dst.height * surface_stride(ds));
     }
 }
 
-- 
2.51.2


