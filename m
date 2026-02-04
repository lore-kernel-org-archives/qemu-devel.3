Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7B4E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1L-000740-5R; Wed, 04 Feb 2026 11:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1F-000721-AV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1A-0004YH-5o
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:21 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 088DD7A00FC;
 Wed,  4 Feb 2026 11:46:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223574; x=
 1770309974; bh=ALXw7+kFhadaK+v0D/xMOYKKTLFyhtOCLdEdTyR+gUQ=; b=p
 Fw+YISTQiQzMadscwrpIbq5C0AP/bPCa7WrgzheyCXwGye033NB2gQvG9jhpjdU4
 65+EgLvsQtmWyF58ivsCiRyk93fx3koZGz1UK6qdyXI+pV/K2hyJ7u2LF9tb14Y8
 zCmy5nbNct5LVh6rLny3nmdwwsqHdw6YyAPmHHBQ2d9gVLsky0DCPS/2gg/3S7bz
 d4hWVC6uZGs56r9SeMiZSssWWAKirlOb5dcHPNZ5kgKCfvhLfOvnJOJM9Zz3Zimd
 SPBffSR1MCazLfgAUKoLFBOVzW3ohCs9D9+VB4nTG/jEzriBrv60ZJ0ILMEtSTBp
 aNFeKqJitmhS17oPklPVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223574; x=1770309974; bh=A
 LXw7+kFhadaK+v0D/xMOYKKTLFyhtOCLdEdTyR+gUQ=; b=WTB62BZwjbBHfkGyR
 f+3iTYHrEYDTgB3/ETGbPALnnF/Vl/JGFB4HNRzi02jfcHnjRAVxUHA2zr/kTLxP
 8Sjls4fHvHKIFn4mOvIPL+zoOjd9qQlZf7+v7eptyQGekb0EfYygFG575YkOY8Ua
 DQ8a+4YRwd1sIi9qwcCKIXagvyQCz3/wQLBdYgFmGazwskRh+wzo5EOHcR9PJVlG
 z2EQA12t5cdEgdEdF/DOCjnnu2LogbqU17dq4xASeLoftroIQU2JfKHPMN3AfVyq
 /SEH9p16/XZXH2rsmaNHmQZb3jJTiJ7zgqHjT2RdYzcVZWRtFmSSZpQz4FVIDu7H
 DyBHg==
X-ME-Sender: <xms:1neDafr44G9A9GCQWcpfFWEQXZwFRaksxjUNRXvY71C9F-dPHZwZrQ>
 <xme:1neDaRGWxMYwoCvmorIT5ECJe0j434PmGuQLh8-rgjOcOx_jvlR-U0Jb0sCwRlg33
 NylmhECXobLHdH7ODw5eJK7IMoHyNpizdUdoHnMYUnjb8ldpQMa-Q>
X-ME-Received: <xmr:1neDaZkzsYrIAPbv3bPm_3TcGkGiwm8f4tLvadrri1jpoX0rKhVdwB9T3SSu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:1neDacnxpGlxeQKcydi6FrKiWjaavBSjvRldnLVdTmE7J9fKaN-ioA>
 <xmx:1neDaSsEI8oO-TlAQq_wQDMzp_4sN7Q_8x0U8kIFt5raKjmG5O2yjQ>
 <xmx:1neDaXnp3LKUmxT--FuhkaHMJ8iWOVIuuarYdxpHMYxltHAxhD7sRQ>
 <xmx:1neDaVsoMTmdxXth2eotJ4zbDk6NWfbogx6CNuQBEW2nepJ1orBRTQ>
 <xmx:1neDacTVkrFC-aSbhsIahP6CkIqAuQNXWvdiZ2SLd4GmoxUjwZvHUJif>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:14 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e57244e6;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 16/18] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Wed,  4 Feb 2026 11:46:04 -0500
Message-ID: <20260204164606.3425246-17-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 463da001d9..53f00e07ec 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -52,6 +52,7 @@ typedef struct {
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
+    QemuRect scissor;
 
     QemuRect dst;
     int dst_stride;
@@ -91,6 +92,11 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->dst_offset = s->regs.dst_offset;
     ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
+    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
+    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    ctx->scissor.x = s->regs.sc_left;
+    ctx->scissor.y = s->regs.sc_top;
+
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
     ctx->dst.x = (ctx->left_to_right ?
@@ -129,6 +135,7 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
+    QemuRect vis_src, vis_dst;
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -144,6 +151,22 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
@@ -156,30 +179,30 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 ctx->src_bits, ctx->dst_bits, src_stride_words,
-                dst_stride_words, ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y,
-                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height);
+                dst_stride_words, ctx->bpp, ctx->bpp, vis_src.x, vis_src.y,
+                vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);
 #ifdef CONFIG_PIXMAN
         if (use_pixman_blt && ctx->left_to_right && ctx->top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)ctx->src_bits,
                                    (uint32_t *)ctx->dst_bits, src_stride_words,
                                    dst_stride_words, ctx->bpp, ctx->bpp,
-                                   ctx->src.x, ctx->src.y, ctx->dst.x,
-                                   ctx->dst.y, ctx->dst.width, ctx->dst.height);
+                                   vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
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
                                    src_stride_words, tmp_stride, ctx->bpp,
-                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
-                                   ctx->dst.width, ctx->dst.height);
+                                   ctx->bpp, vis_src.x, vis_src.y, 0, 0,
+                                   vis_dst.width, vis_dst.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride, dst_stride_words, ctx->bpp,
-                                       ctx->bpp, 0, 0, ctx->dst.x, ctx->dst.y,
-                                       ctx->dst.width, ctx->dst.height);
+                                       ctx->bpp, 0, 0, vis_dst.x, vis_dst.y,
+                                       vis_dst.width, vis_dst.height);
             }
             g_free(tmp);
         } else
@@ -189,20 +212,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -230,20 +253,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                ctx->dst_bits, dst_stride_words, ctx->bpp, ctx->dst.x,
-                ctx->dst.y, ctx->dst.width, ctx->dst.height, filler);
+                ctx->dst_bits, dst_stride_words, ctx->bpp, vis_dst.x,
+                vis_dst.y, vis_dst.width, vis_dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
-            !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
-                         ctx->dst.x, ctx->dst.y,
-                         ctx->dst.width, ctx->dst.height, filler))
+             !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
+                          vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height,
+                          filler))
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


