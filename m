Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B68FE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppS-0004lD-GJ; Fri, 30 Jan 2026 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppP-0004j5-2z
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:31 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-00038V-CS
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:30 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id A04FE1D00125;
 Fri, 30 Jan 2026 09:50:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 09:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784625; x=
 1769871025; bh=y34hm50ngq3yoGNE/+uyLGPZYl4YOCtQaqgiWP1RJjk=; b=h
 BGnzNpxrR13KZjJYiTDkooHjWLeHSTOJbuDOHyRZFbTxVzOn5nENS/goMTo5M1/7
 K4ypAbEk8tp4R6DyoXn3XmSojZtwwylm0lg49PNRRLeO7EBkuQVvm68ATb8DnuRV
 +RhGiSDiC884OB2mflcNlGH3SZ43gEP05o2HdqG2t3Knwkrmcse1Kf/iaE5Lnw6K
 1QS8fp0b0/DClRmoDoks6mJUnrCMi4Vnyl0vRRi32nXH61IpdvGFqgS8hLuWmYnT
 1GHUepBLCsyXKiiUORPY2GExq4aX4SyCkQTnAjEc8r+IaF8Hke1uZ4+xSSqv+1Qr
 GewroDg4gmz/z8+9kin8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784625; x=1769871025; bh=y
 34hm50ngq3yoGNE/+uyLGPZYl4YOCtQaqgiWP1RJjk=; b=LTvq++F8bgTOI3DN5
 fWpI61SEEUtlT8tz5P1ZFHadOG0xIjeU8UNlrIQLIy8NYonUEuEeGrEDvcJ2DgEZ
 9ssTxMKMsMhruvluKRpBe+YMRr/QvWQ0sKyuRzbkyQ+2M2+/5zRqfFyC82pAVjJE
 gzBRZhb69c4H4kiR0LNJsdXL1Pzd95l6P6gb9xj8z13477Lws0cNd+sqCLqUO72s
 PSpFl1fE1M1QRASmX98aJtimi5J1LPA050sMQVp7/TtXBWv2k7l+IJ0UVqEnzE9X
 hsRLAcEz+fDXGt6Mf+Kh1hg89otPeERUUQaKBW/dS1ldtH/J9vQDyra8NY0/t0Kj
 7P8iQ==
X-ME-Sender: <xms:McV8aY8PYTCzoAyCNDzjmLOo-Bp8LS3LgBvCiVXkA31b84eBAgpq7g>
 <xme:McV8aYIR9NjmSv3UeYjyDiPCGHlRGuuYR8CuASiFBO7tkEY6Y1gFiWyZVRzS9FC_a
 t3YCdCPtzSm1BUamBwLn_lt24Qvtcy_kDkRtOA2HD0tQnC2nJUZ8-o>
X-ME-Received: <xmr:McV8abZI_LsTvrvK0zBKUwBkuP2b7zNxAmw_5D1a8GwGyoMreiTlKe8Sapdu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 gthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:McV8aSL9UHiEZ8N8Qid30KfKHPj_IwDGeGrWaU7oNuo0gZ9pvzs7vg>
 <xmx:McV8aRDPoT_Fnlhx-SCEs2RvsDchv_I1pmrgUCDf676jnAQMej78fw>
 <xmx:McV8afoKP0U3omXTnxDyU-Dqwl2vhSqBES58n6QFExwkGp3lcCqBmg>
 <xmx:McV8aUhS_3ccsowLF3JTzc2B6cH2FTnhfjOLYAmUrOQdMLAB2FkwNA>
 <xmx:McV8aS3GOGHe48CuukulIuSYGD6mg7fbBem9-L_VnShmiaUJ8Ys6JTCH>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id aff3bcd3;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 13/20] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Fri, 30 Jan 2026 09:49:58 -0500
Message-ID: <20260130145005.731129-14-chad@jablonski.xyz>
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

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 162 ++++++++++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 75 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 4c55898e9a..5ea2df1126 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -101,88 +101,90 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     }
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    ATI2DCtx ctx;
-    setup_2d_blt_ctx(s, &ctx);
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
-            ctx.rop3 >> 16);
+            ctx->rop3 >> 16);
     unsigned dst_offset = s->regs.dst_offset;
-    if (!ctx.bpp) {
+    if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    if (!ctx.dst_stride) {
+    if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    int dst_stride_words = ctx.dst_stride / sizeof(uint32_t);
-    if (ctx.dst.x > 0x3fff || ctx.dst.y > 0x3fff || ctx.dst_bits >= ctx.vram_end
-        || ctx.dst_bits + ctx.dst.x
-         + (ctx.dst.y + ctx.dst.height) * ctx.dst_stride >= ctx.vram_end) {
+    int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
+    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
+        || ctx->dst_bits >= ctx->vram_end
+        || ctx->dst_bits + ctx->dst.x
+         + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, dst_offset, s->regs.default_offset,
-            ctx.src_stride, ctx.dst_stride, s->regs.default_pitch,
-            ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
-            ctx.dst.width, ctx.dst.height,
-            (ctx.left_to_right ? '>' : '<'),
-            (ctx.top_to_bottom ? 'v' : '^'));
-    switch (ctx.rop3) {
+            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
+            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
+            ctx->dst.width, ctx->dst.height,
+            (ctx->left_to_right ? '>' : '<'),
+            (ctx->top_to_bottom ? 'v' : '^'));
+    switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        if (!ctx.src_stride) {
+        if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        int src_stride_words = ctx.src_stride / sizeof(uint32_t);
-        if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
-            || ctx.src_bits >= ctx.vram_end
-            || ctx.src_bits + ctx.src.x
-             + (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end) {
+        int src_stride_words = ctx->src_stride / sizeof(uint32_t);
+        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
+            || ctx->src_bits >= ctx->vram_end
+            || ctx->src_bits + ctx->src.x
+             + (ctx->src.y + ctx->dst.height)
+             * ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                ctx.src_bits, ctx.dst_bits, src_stride_words, dst_stride_words,
-                ctx.bpp, ctx.bpp, ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
-                ctx.dst.width, ctx.dst.height);
+                ctx->src_bits, ctx->dst_bits,
+                src_stride_words, dst_stride_words, ctx->bpp, ctx->bpp,
+                ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
+                ctx->dst.width, ctx->dst.height);
 #ifdef CONFIG_PIXMAN
-        if (use_pixman_blt && ctx.left_to_right && ctx.top_to_bottom) {
-            fallback = !pixman_blt((uint32_t *)ctx.src_bits,
-                                   (uint32_t *)ctx.dst_bits,
+        if (use_pixman_blt && ctx->left_to_right && ctx->top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits,
+                                   (uint32_t *)ctx->dst_bits,
                                    src_stride_words, dst_stride_words,
-                                   ctx.bpp, ctx.bpp,
-                                   ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
-                                   ctx.dst.width, ctx.dst.height);
+                                   ctx->bpp, ctx->bpp,
+                                   ctx->src.x, ctx->src.y,
+                                   ctx->dst.x, ctx->dst.y,
+                                   ctx->dst.width, ctx->dst.height);
         } else if (use_pixman_blt) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = ctx.dst.width * (ctx.bpp / 8);
+            int llb = ctx->dst.width * (ctx->bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     ctx.dst.height);
-            fallback = !pixman_blt((uint32_t *)ctx.src_bits, tmp,
+                                     ctx->dst.height);
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
                                    src_stride_words, tmp_stride,
-                                   ctx.bpp, ctx.bpp,
-                                   ctx.src.x, ctx.src.y, 0, 0,
-                                   ctx.dst.width, ctx.dst.height);
+                                   ctx->bpp, ctx->bpp,
+                                   ctx->src.x, ctx->src.y, 0, 0,
+                                   ctx->dst.width, ctx->dst.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)ctx.dst_bits,
+                fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride, dst_stride_words,
-                                       ctx.bpp, ctx.bpp,
-                                       0, 0, ctx.dst.x, ctx.dst.y,
-                                       ctx.dst.width, ctx.dst.height);
+                                       ctx->bpp, ctx->bpp,
+                                       0, 0, ctx->dst.x, ctx->dst.y,
+                                       ctx->dst.width, ctx->dst.height);
             }
             g_free(tmp);
         } else
@@ -191,19 +193,21 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = ctx.bpp / 8;
-            for (y = 0; y < ctx.dst.height; y++) {
-                i = ctx.dst.x * bypp;
-                j = ctx.src.x * bypp;
-                if (ctx.top_to_bottom) {
-                    i += (ctx.dst.y + y) * ctx.dst_stride;
-                    j += (ctx.src.y + y) * ctx.src_stride;
+            unsigned int y, i, j, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp;
+                j = ctx->src.x * bypp;
+                if (ctx->top_to_bottom) {
+                    i += (ctx->dst.y + y) * ctx->dst_stride;
+                    j += (ctx->src.y + y) * ctx->src_stride;
                 } else {
-                    i += (ctx.dst.y + ctx.dst.height - 1 - y) * ctx.dst_stride;
-                    j += (ctx.src.y + ctx.dst.height - 1 - y) * ctx.src_stride;
+                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
+                         * ctx->dst_stride;
+                    j += (ctx->src.y + ctx->dst.height - 1 - y)
+                         * ctx->src_stride;
                 }
-                memmove(&ctx.dst_bits[i], &ctx.src_bits[j],
-                        ctx.dst.width * bypp);
+                memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
+                        ctx->dst.width * bypp);
             }
         }
         break;
@@ -214,38 +218,39 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (ctx.rop3) {
+        switch (ctx->rop3) {
         case ROP3_PATCOPY:
-            filler = ctx.frgd_clr;
+            filler = ctx->frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx.palette[0],
-                                                   ctx.palette[1],
-                                                   ctx.palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
+                                                   ctx->palette[1],
+                                                   ctx->palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx.palette[3],
-                                                   ctx.palette[4],
-                                                   ctx.palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[3],
+                                                   ctx->palette[4],
+                                                   ctx->palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                ctx.dst_bits, dst_stride_words, ctx.bpp, ctx.dst.x, ctx.dst.y,
-                ctx.dst.width, ctx.dst.height, filler);
+                ctx->dst_bits, dst_stride_words, ctx->bpp,
+                ctx->dst.x, ctx->dst.y,
+                ctx->dst.width, ctx->dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
-            !pixman_fill((uint32_t *)ctx.dst_bits, dst_stride_words,
-                         ctx.bpp, ctx.dst.x, ctx.dst.y,
-                         ctx.dst.width, ctx.dst.height, filler))
+            !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words,
+                         ctx->bpp, ctx->dst.x, ctx->dst.y,
+                         ctx->dst.width, ctx->dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = ctx.bpp / 8;
-            for (y = 0; y < ctx.dst.height; y++) {
-                i = ctx.dst.x * bypp + (ctx.dst.y + y) * ctx.dst_stride;
-                for (x = 0; x < ctx.dst.width; x++, i += bypp) {
-                    stn_he_p(&ctx.dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
+                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
+                    stn_he_p(&ctx->dst_bits[i], bypp, filler);
                 }
             }
         }
@@ -253,15 +258,22 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      ctx.rop3 >> 16);
+                      ctx->rop3 >> 16);
         return;
     }
 
-    if (ctx.dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-        ctx.dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+    if (ctx->dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+        ctx->dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
         s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
         memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                dst_offset + ctx.dst.y * surface_stride(ds),
-                                ctx.dst.height * surface_stride(ds));
+                                dst_offset + ctx->dst.y * surface_stride(ds),
+                                ctx->dst.height * surface_stride(ds));
     }
 }
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    ati_2d_do_blt(s, &ctx);
+}
-- 
2.52.0


