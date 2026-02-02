Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA26E7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qQ-0007oC-RK; Mon, 02 Feb 2026 15:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q7-0007Mr-Cu
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:09 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0001pP-0y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:05 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 04CA81D00133;
 Mon,  2 Feb 2026 15:48:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 15:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065280; x=
 1770151680; bh=0lZr8XQmWGb15vpqX2+bUmT6P83W9+zZYeCJJBxjpI4=; b=B
 CIqOXMqAqlyZi86irNe5n579/Fqx2Q/73lI8Tb4ndMsyaaaTNY3T54GZ+BWg0Q3v
 ZExzjORBBas5VllE64G7YEGFVfOeirSakF27jfgan1s29itCZpNeTtN82WnYi7Y9
 /HzuH2uQ4R79dp+eBvwcb236QkYi/N945GzF0SdnD9q3cP+cTnY1YLGi2mdbLYE5
 oTTrWWUKrlNIDpZSqWL0ko31yiCY9nYQ4hStFQE69wfC46TIRHXYiK/Ey90iGD9a
 46RtJBwCR796lIKW6NhhhO28d0dVvQWtDVtUrY8eJdm3XFZzv11x2VzMG5k04xUh
 +em3b/ZFVwUAW4gjEjncw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065280; x=1770151680; bh=0
 lZr8XQmWGb15vpqX2+bUmT6P83W9+zZYeCJJBxjpI4=; b=o5fcU4Tby+EzP+Cd9
 ACVQHOvwvblEzfVaL4NdtCQVdLnS+GTdh4GjxghxPTDfV0dIUycUG4KMLwbBcNno
 AHVNAXMtJceKWRkWAe1xnK84MAwudcEvHab2KRl25qBE3GomX9fR45Wgy29+oizg
 xt2QhuwrBcV1vpuJF3Ik528KdNY45l9k+jXId21avUsrOHlR2HyJDgv3eUxujPv7
 8LBCJpxmfAno9iwQtJchSQGgNdDHuc+ZufJ6ZpEsIhAg0w/5dsRrTEkp0JIRbP3n
 1lvxRFunOr+WC1RqbI7s9lFor3P3XaV40UNYIp8ENhtVDfS0vSNL0BNbcqaRIQWQ
 sRhvw==
X-ME-Sender: <xms:gA2BaRbk8SyI1pnodF1IPyP2Umh3fyaHz959el69_Qd-F8PUfvO7Sg>
 <xme:gA2Baf3YA4BiMov6ruoXTy1ZNCxKJPipuDMPF2brM8bwW9eYrwFlLlDlmY-3RY1aD
 dXIAr0XkzPE5u642d2IftmuBvNl3f59p_f6v_qj-UTviEE4FGcu0PY>
X-ME-Received: <xmr:gA2BaRW6UJp0iOCnwWihFYmrCiMQlyAcYitwYoGCkCgRAMi5u13ypxseeFxR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gA2BaZWctOX8IGkrzx3RA_XhDGBosRaA3FAonqTM2wZumIzwok9vBQ>
 <xmx:gA2BaQcFUgxaXdKvI5KGsPBLgYjKXdb6wa-PHd0YZOwaF-ObcPfeZw>
 <xmx:gA2BaSXvda7NAsP6Lj-R8ugFO0s7zWH8jtr3bvgfg2YUjDH5O7JD6Q>
 <xmx:gA2BaZcaATc5dFs4RNvFDZj91dQfU6_TbEyL4-OoghAYiyKwOZjKKg>
 <xmx:gA2BaVCXlwWyM-xqhmc331S5VDhEp63kUtQ6TwA7kAdAb1IhAtA_u5zE>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:48:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 34aeabb7;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 17/19] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Mon,  2 Feb 2026 15:47:35 -0500
Message-ID: <20260202204738.3080092-18-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
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
 hw/display/ati_2d.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 4b16265733..b9fc9f3057 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -52,6 +52,7 @@ typedef struct {
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
+    QemuRect scissor;
 
     QemuRect dst;
     int dst_stride;
@@ -89,6 +90,11 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->palette = s->vga.palette;
     ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
+    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
+    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    ctx->scissor.x = s->regs.sc_left;
+    ctx->scissor.y = s->regs.sc_top;
+
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
     ctx->dst.x = (ctx->left_to_right ?
@@ -127,6 +133,7 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
+    QemuRect vis_src, vis_dst;
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -143,6 +150,22 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -157,34 +180,34 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
                 ctx->src_bits, ctx->dst_bits,
                 src_stride_words, dst_stride_words,
                 ctx->bpp, ctx->bpp,
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
@@ -194,20 +217,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -236,20 +259,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
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


