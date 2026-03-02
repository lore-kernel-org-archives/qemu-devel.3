Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9987FEB362B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e5-0006Uc-09; Mon, 02 Mar 2026 13:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dp-0006Le-E7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006Yi-7U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D348A1400211;
 Mon,  2 Mar 2026 13:05:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474706; x=
 1772561106; bh=sTdS7ZFy1U3Sh7R5XP6n+ak0xFyIYk9nL8I7S7Brk8c=; b=g
 WoGBZXLOLKMWZUCM1Gfqp+VS8eaH8XGUqn0vKJk3ToD4QMjigjOfobP+HLpOvyok
 GpzBxkvETqhbK80LS11cy3YvZmHb/dLwwGCIDVpyOvl90248mPCS3eS4eZlAkRr6
 JVjBEHlN2CbiroOJGxqrHeOCE0y9hMark5rQDl04CyCBChtEWZqD2V7xbZzwop1+
 93MQw5ti0Mog4MdMDoLfMyJ7uIkKiT92lmeLqXXhkrrmaQqBzefQIC0tDTz7uopa
 yNmi0n78LJsSmTvoFB59H8GswMw0MaE44F4jLaV/p0qHPhrVrmyDWWQ/z2EY3KOY
 GykwM+tJwBtvsbZ9Ec91Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474706; x=1772561106; bh=s
 TdS7ZFy1U3Sh7R5XP6n+ak0xFyIYk9nL8I7S7Brk8c=; b=H7+3bwW9uLXwOyeNL
 Ns0pLpkXNa4GE3X9AC80z7KNlg7ItTNGzWO1UI6rJNiS79S0MNX8Wp5ZuS5gA7qX
 OsQ/BXbwlPs4tqFT3SPqnsAscj8g5wftO0ABYvHWKhpiSsJRQv3+GPT9Fi7B6Jkc
 OjSCLrdow1kRv61VELkzLapm/vsYLWvflxPA1erF0rGnpUuQDTCMrd1YqGZ4wLuj
 vR9Mi2vPwDYsEzivUmeSRfFn4QcojR3JG2ygirTS5ASbfs6wZ6/S4cVi07xj6x1T
 vPxEznoFaTBCVlpghrMQ6u9Oml42wgHPdca9Ed4eMUPZ0EYs/7oK7BV5NrwNpc3v
 hkTRg==
X-ME-Sender: <xms:UtGlaRkTG-z4uIBPtG68yVG9FBtNax56Xgei-NjeXOe5YtfVZGE3Rg>
 <xme:UtGlaTt-6D68k3Pj_SFYuzpAnQbCLdYgAt1G_qOEMYJdJNtbqDifSLg67CBEYFWl6
 vLAZeUaFJpsyK3aisxCF48tw2PHRVBuYVrajCkBcy4bHBbdJolj1aE>
X-ME-Received: <xmr:UtGlaf9T3dUcj04AZMGyQoHW7R9522LennAy3D8JwTpSyDIcUfZHe78myRFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvg
 drhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:UtGladMHaf-aZVD20FiIcNp6di31UWJoSZPDTxrDOmj03NUsCK_WZQ>
 <xmx:UtGladGjWYIfPTb9t7eHC7ZOeRFZqjLwDufSWJeZ_rWb5PzTwNUlEA>
 <xmx:UtGlabTfAFD2AlpD79ahu2J8L6U7XLPoCL6MQJVWYloJ5utkBj-_bA>
 <xmx:UtGlaas_hIHcRZFj311RSLrVKD6rX6PEWEJiknQICtwIsNjq1HcHhg>
 <xmx:UtGlaQLwrbJv8UztDae8hPwJhPGcm7xL9ChfK0Yqiakx-Qxk4mR-1ZLf>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:06 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f0616d5b;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 15/17] ati-vga: Implement scissor rectangle clipping for
 2D operations
Date: Mon,  2 Mar 2026 13:04:45 -0500
Message-ID: <20260302180447.1078098-16-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
 hw/display/ati_2d.c | 84 ++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 4fa28f7beb..e240093f12 100644
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
@@ -127,6 +133,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
+    QemuRect vis_src, vis_dst;
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return false;
@@ -142,6 +149,29 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
+    qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
+    if (!vis_dst.height || !vis_dst.width) {
+        /* Nothing is visible, completely clipped */
+        return false;
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
+    DPRINTF("dst: (%d,%d) %dx%d -> vis_dst: (%d,%d) %dx%d\n",
+            ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height,
+            vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);
+    DPRINTF("src: (%d,%d) %dx%d -> vis_src: (%d,%d) %dx%d\n",
+            ctx->src.x, ctx->src.y, ctx->src.width, ctx->src.height,
+            vis_src.x, vis_src.y, vis_src.width, vis_src.height);
+
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
@@ -151,9 +181,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             return false;
         }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
-        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
+        if (vis_src.x > 0x3fff || vis_src.y > 0x3fff
             || ctx->src_bits >= ctx->vram_end
-            || ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height)
+            || ctx->src_bits + vis_src.x + (vis_src.y + vis_dst.height)
              * ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
@@ -161,31 +191,31 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
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
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     ctx->dst.height);
+                                     vis_dst.height);
             fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
                                    src_stride_words, tmp_stride_words, ctx->bpp,
-                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
-                                   ctx->dst.width, ctx->dst.height);
+                                   ctx->bpp, vis_src.x, vis_src.y, 0, 0,
+                                   vis_dst.width, vis_dst.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride_words, dst_stride_words,
                                        ctx->bpp, ctx->bpp, 0, 0,
-                                       ctx->dst.x, ctx->dst.y,
-                                       ctx->dst.width, ctx->dst.height);
+                                       vis_dst.x, vis_dst.y,
+                                       vis_dst.width, vis_dst.height);
             }
             g_free(tmp);
         } else
@@ -195,20 +225,20 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -236,20 +266,20 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                ctx->dst_bits, dst_stride_words, ctx->bpp, ctx->dst.x,
-                ctx->dst.y, ctx->dst.width, ctx->dst.height, filler);
+                ctx->dst_bits, dst_stride_words, ctx->bpp, vis_dst.x,
+                vis_dst.y, vis_dst.width, vis_dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
             !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
-                         ctx->dst.x, ctx->dst.y,
-                         ctx->dst.width, ctx->dst.height, filler))
+                         vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height,
+                         filler))
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


