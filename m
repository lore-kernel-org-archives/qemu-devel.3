Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FFBE6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppW-0004nv-4b; Fri, 30 Jan 2026 09:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppP-0004jR-JC
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:31 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-00038v-Re
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:31 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id DA4681D00067;
 Fri, 30 Jan 2026 09:50:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 09:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784626; x=
 1769871026; bh=74CoOPxXzXwBBCcNpmO7kmtjUhWvu3ZgP90v6OwJJNw=; b=l
 KT0gZnhOVtwQF/eNADPfhuDw+PVx1sq56nG2hRfgK1sITNlc+/97t/arg8q5YIVF
 kf3SmC5yoRCY9E6S9gkQkpmAkK88J1ixGt/zCjryKYCJJyrgq3SVNYe6ARSqKLoq
 /UMbHWyCnxbwKauii3cemYspGXe9V2iBcy1G5EivQdoQHOaoEU6lFi3OxIgySuEv
 +l6S6sgQA3UOtbf7RkEEQ5rlkjLYDimPMqjLjeRAfTMTY/MTn1WhA7GpA5e327ad
 chUFtx4lE+g7nEBNsS920APJZQUyRp+WLv5BDByl1RBQNVCV9PGfLggN5wQ6rz5m
 UsD/jdvgniAksExTbDNUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784626; x=1769871026; bh=7
 4CoOPxXzXwBBCcNpmO7kmtjUhWvu3ZgP90v6OwJJNw=; b=ewMql7eqHF5rk+YaV
 ZDANsz6EwvNbghxMNJP+acweE24r5yEE3WD3WX15/UFwM6Mk++RNBpkdsD6kdJWr
 v2BUS8/yNaLfUWD4XVMpDWW8D2z2o+dpSmYtM2SWhsWHmFWT5YfKdC/HwSfwj8a7
 xe5jtvMQF6uboh3TyHWM9XdeaWMKAh1kuUTZWvjFBMac0FEZ/hH/is+1qtN46WD2
 4pSUkuD63B2LQE8S7u8+yv/RLbWbgBOppvQNW65OWII9gpMRWJy4/Ejp4P6EGNTC
 92SRLodfCqkitIgd/a/uV52wzbHea0wDk30c2xPCJ7xeHeliMKNxa2IBdVM1QZVa
 k+X7g==
X-ME-Sender: <xms:MsV8aZT--3mJxhsVIDgFchUhQbTk8vENuk1hMiUxmLbyz8dD1jKiXQ>
 <xme:MsV8aaNURhHUJSicdiCdvWajWFo_dAynzgWx-IMFGEc-N7kILIJ1sbrJRI94kDRUH
 1wShW8jW7j7F3ECNqXMroCu-_J5wBlDqy5uUEd_t62NzP2s_N5YP0s>
X-ME-Received: <xmr:MsV8acODvh8IXxe3CK5hXMIuUZ0fJ2pY_MrMKXkoDXUZA07snNCD_y5W8IhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MsV8aavPDSnNMjUZjo4ew-29GsdEo6ZWs38HMVM1RzFbEtwRnJ22rw>
 <xmx:MsV8aWWJegn_I6cXDQCYkmWOTpwazjP6jTPZPLH6-RUYRjqnvKK6Mw>
 <xmx:MsV8aSu_SmpD19-UKX_WepDwKGqojj5MoUkA7yS7HvHaVsphaR8b0Q>
 <xmx:MsV8aSURC13j3Ymx85CGNQ8n6HvgUCyOj0pgYM4DRuVh2EdBB-XWnA>
 <xmx:MsV8acaYZy329TBiJP1fwTKbhBLQzczjeh_bNPtOb0irvZOlZkCoS1Dq>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f165a074;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 18/20] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Fri, 30 Jan 2026 09:50:03 -0500
Message-ID: <20260130145005.731129-19-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
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

Use scissor registers to clip blit operations. This is required
for text rendering in X using the r128 driver. Without it overly-wide
glyphs are drawn and create all sorts of chaos.

The visible destination rectangle (vis_dst) is the intersection of the
scissor rectangle and the destination rectangle (dst).

The src also needs to be offset if clipped on the top and/or
left sides to ensure that src data is read correctly and appears
clipped when drawn rather than shifted.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 80 +++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 3ff874c3ed..36bed89de0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -52,6 +52,7 @@ typedef struct {
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
+    QemuRect scissor;
 
     /* dst */
     QemuRect dst;
@@ -91,6 +92,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->palette = s->vga.palette;
     ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
+    /* scissor */
+    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
+    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    ctx->scissor.x = s->regs.sc_left;
+    ctx->scissor.y = s->regs.sc_top;
+
     /* dst */
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
@@ -124,6 +131,7 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
+    QemuRect vis_src, vis_dst;
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -140,10 +148,26 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
+    qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
+    if (!vis_dst.height || !vis_dst.width) {
+        /* Nothing is visible, completely clipped */
+        return;
+    }
+    /*
+     * The src must be offset if clipping is applied to the dst.
+     * This is so that when the source is blit to a dst clipped
+     * on the top or left the src image is not shifted into the
+     * clipped region but actually clipped.
+     */
+    vis_src.x = ctx->src.x + (vis_dst.x - ctx->dst.x);
+    vis_src.y = ctx->src.y + (vis_dst.y - ctx->dst.y);
+    vis_src.width = vis_dst.width;
+    vis_src.height = vis_dst.height;
+
     DPRINTF("%d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             ctx->src_stride, ctx->dst_stride,
-            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
-            ctx->dst.width, ctx->dst.height,
+            vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
+            vis_dst.width, vis_dst.height,
             (ctx->left_to_right ? '>' : '<'),
             (ctx->top_to_bottom ? 'v' : '^'));
     switch (ctx->rop3) {
@@ -159,34 +183,34 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 ctx->src_bits, ctx->dst_bits,
                 src_stride_words, dst_stride_words, ctx->bpp, ctx->bpp,
-                ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
-                ctx->dst.width, ctx->dst.height);
+                vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
+                vis_dst.width, vis_dst.height);
 #ifdef CONFIG_PIXMAN
         if (use_pixman_blt && ctx->left_to_right && ctx->top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)ctx->src_bits,
                                    (uint32_t *)ctx->dst_bits,
                                    src_stride_words, dst_stride_words,
                                    ctx->bpp, ctx->bpp,
-                                   ctx->src.x, ctx->src.y,
-                                   ctx->dst.x, ctx->dst.y,
-                                   ctx->dst.width, ctx->dst.height);
+                                   vis_src.x, vis_src.y,
+                                   vis_dst.x, vis_dst.y,
+                                   vis_dst.width, vis_dst.height);
         } else if (use_pixman_blt) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = ctx->dst.width * (ctx->bpp / 8);
+            int llb = vis_dst.width * (ctx->bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     ctx->dst.height);
+                                     vis_dst.height);
             fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
                                    src_stride_words, tmp_stride,
                                    ctx->bpp, ctx->bpp,
-                                   ctx->src.x, ctx->src.y, 0, 0,
-                                   ctx->dst.width, ctx->dst.height);
+                                   vis_src.x, vis_src.y, 0, 0,
+                                   vis_dst.width, vis_dst.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride, dst_stride_words,
                                        ctx->bpp, ctx->bpp,
-                                       0, 0, ctx->dst.x, ctx->dst.y,
-                                       ctx->dst.width, ctx->dst.height);
+                                       0, 0, vis_dst.x, vis_dst.y,
+                                       vis_dst.width, vis_dst.height);
             }
             g_free(tmp);
         } else
@@ -196,20 +220,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = ctx->bpp / 8;
-            for (y = 0; y < ctx->dst.height; y++) {
-                i = ctx->dst.x * bypp;
-                j = ctx->src.x * bypp;
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp;
+                j = vis_src.x * bypp;
                 if (ctx->top_to_bottom) {
-                    i += (ctx->dst.y + y) * ctx->dst_stride;
-                    j += (ctx->src.y + y) * ctx->src_stride;
+                    i += (vis_dst.y + y) * ctx->dst_stride;
+                    j += (vis_src.y + y) * ctx->src_stride;
                 } else {
-                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
+                    i += (vis_dst.y + vis_dst.height - 1 - y)
                          * ctx->dst_stride;
-                    j += (ctx->src.y + ctx->dst.height - 1 - y)
+                    j += (vis_src.y + vis_dst.height - 1 - y)
                          * ctx->src_stride;
                 }
                 memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
-                        ctx->dst.width * bypp);
+                        vis_dst.width * bypp);
             }
         }
         break;
@@ -238,20 +262,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
                 ctx->dst_bits, dst_stride_words, ctx->bpp,
-                ctx->dst.x, ctx->dst.y,
-                ctx->dst.width, ctx->dst.height, filler);
+                vis_dst.x, vis_dst.y,
+                vis_dst.width, vis_dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
             !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words,
-                         ctx->bpp, ctx->dst.x, ctx->dst.y,
-                         ctx->dst.width, ctx->dst.height, filler))
+                         ctx->bpp, vis_dst.x, vis_dst.y,
+                         vis_dst.width, vis_dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = ctx->bpp / 8;
-            for (y = 0; y < ctx->dst.height; y++) {
-                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
-                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stride;
+                for (x = 0; x < vis_dst.width; x++, i += bypp) {
                     stn_he_p(&ctx->dst_bits[i], bypp, filler);
                 }
             }
-- 
2.52.0


