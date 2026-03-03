Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B795DEB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnd-0008A5-Kj; Mon, 02 Mar 2026 21:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnU-0007pq-HL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:44 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnR-0002rG-Av
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:44 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 94C401400216;
 Mon,  2 Mar 2026 21:47:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 21:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506060; x=
 1772592460; bh=fBo861CugpdwKfrfxp/OWNxz/UC8TComfzwkajW38uc=; b=Y
 Kah8enH5U3YkOZfqSV7sawo+/aTQ2ocjOg6ZCoDxxEJ0ZfBAOA33bfRoEqFx/p1T
 ZwiWRS7bSEcjaAXM3Je/JSGJesgOdyMbr1H0dHrGWLb5XJ3PFDMOQ6TDmULgwice
 Q0Plk9k15QQTi1exXlHaFlqIYDU6GObLa3uSgQAhJURWhqWlLFrK0irQCiUg4LW9
 xcWwL1QIDyraofVhro7ZSnxayoAkGWuNZKbHKtnAQVQ9vaTE6Vl1J5iXzF006Exb
 k4IxJzEaLK8w8zXJEm9pEFDkr0iFaYIhln+DEviJ7cnwvtHMd5m/mU4c22qv3PvQ
 xFiK4Zbftz7cfIAwtL0Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506060; x=1772592460; bh=f
 Bo861CugpdwKfrfxp/OWNxz/UC8TComfzwkajW38uc=; b=wMarlTZ4rK9ZkgtQ0
 GdGzlnCADMV3fmbmXC6qoCxMimiyswGhbnOd3hvj9rUdWsJgtUr6mg/Dv3n7ov+5
 DHM+KZh2/bcFl6n/qLyNC25AFBtqfdWkAA7c0UVlMbRgkJuL+l9yPEmLuSXBE/Yq
 cJDEs79ddeGOSDXHDEDJmizITL8Xev6FP+l5TsqNKuZVFPo6rBxAQCFKEQDPMEVA
 XRJzoZjde3ZUwVGmLSvjf7GHL5stANQ/RuJihnlV5c5+rWOSM2XQVutEj3vggsNt
 d86xfraeEP/LbK/wvb7QFhLM2G7dmEu9/4yKu8heo6DQjvdly8jmHEiAluziwwc5
 4t+iQ==
X-ME-Sender: <xms:zEumaaDBL2P_XcvoZ3cnXbnVrL9uGmZGipd3RAd1LZDr3Qmq5s7PXA>
 <xme:zEumaQDE3QVLSOpNBepMHGm7EonZdVDXV4WCJz5Nm9aU8LXq_mUqZxQVOa9_Njh3n
 aRM6cTzULbd79d8srSiaCNMAnqyJDBEuchERKDj1nieIJ3_BwFx-GKW>
X-ME-Received: <xmr:zEumaUCeJfOeeFemREQGntRpmDoHALqKGJUFMXjtCX4Luy25bqaS-V28Gh9->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtph
 htthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghrtggr
 nhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:zEumaTqeR-vUhB0X2ZljAeUfsY0P9UwXc69b7na6LenGeDh8qXQiZQ>
 <xmx:zEumaWnUGrNvth1VoQCewxDba0PJhDY-Yq3WTgcGE2vsBtBM2mHezA>
 <xmx:zEumabwOSJKusmpz2P18EEi-DW_wfecaHRZX-4-HaYEDiuwCSGYo8g>
 <xmx:zEumaW9vrJpQXB3XclmN1WO0tUkHGZldjGfBRG1aiYbdpNvb0PaYdA>
 <xmx:zEumaauRgtvnEz56GmS4bhVuXG8XM_M1w6nlS75NV1u2cpv4jRQxDuEj>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:40 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 1edef6bd;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 15/17] ati-vga: Implement scissor rectangle clipping for
 2D operations
Date: Mon,  2 Mar 2026 21:47:28 -0500
Message-ID: <20260303024730.1489136-16-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
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


