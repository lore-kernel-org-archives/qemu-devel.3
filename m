Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65BD10398B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eD-0002bX-6U; Fri, 27 Feb 2026 15:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e2-0001Vz-3Q
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007Q8-5B
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0C23F14001F7;
 Fri, 27 Feb 2026 15:41:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224861; x=
 1772311261; bh=WU6cZD7VMvAe2lt4ksMZ8qKTpaE4lnZg2DgkHNwr9uU=; b=m
 AMoqQWaqKShJ9Wjw7CSXCbUPwUuM64EeFH/Z3k/BimYZYGxRzHtxE00mLOO3xplg
 qzBfF14EeZaeNNK1amcl4xXA7lGglwx+M9PGTfZZrveDRZ5PIsQ31wHbipJgq84F
 NORZ6xaXbWAe7W+btGwyQFWcC0ByHBTtKhxBWNm/omM+oRt9LjUV1CaCoM/BFDWh
 vTIjnNxCeg1Ctz4z7xUvHgqq+KLpYUvcKDDcCwZmU2zfiV3ngsrB1XU0DZkhwvo/
 +6BhmfC521RK/4F4AbUkYeuiW2iIfwa70AFSxZOTRjMrFLUF68BLm22RsaNXyLko
 NuL8mn41ejmh8VsvSHpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224861; x=1772311261; bh=W
 U6cZD7VMvAe2lt4ksMZ8qKTpaE4lnZg2DgkHNwr9uU=; b=SJTcPqn9Vhr/Qjosf
 +t8h4cjvx9xCaX1wPhz/ukNbUvtJekqEwAAPHAepgoXIA+WYemcozz5IiwWtM6dQ
 fEj0nGdbxKArLG4/7Elj7hu8F8XoLAimbBOliar6rH0pbHrFNR59NZTiHXFXwlsu
 YRIS6+Pxq2p/GMef6IiRBMj1G5zMmYNfv8DRVj3zy4w5iBr0iqECEKPe60Vo+VfT
 dJiLF6hxcLkLyEp3LnJ/nGJU6j4ic2Bvl/2qacBiaJI8o3Jev2OKTpnVIx9eiJm/
 lTHkXXpuR2QkxPKjsRQj9Rf0ic+uinV53a5PMxmgnnuYTaUCXjh3zHMLpPyjUedu
 h0Xdw==
X-ME-Sender: <xms:XAGiaa23ZBWHpxJ971HKK6g0YVFmdyyagHk3piS2uJz48EcE9aOtnQ>
 <xme:XAGiaT-JkA2zTV6HtAe_E5TpNrNs0RPg5R5O_OMoUT9wYxRvMsUQvTkP8Scd_EHGq
 iVQFo7WVEq7mq5dMvDWuD9A4hCo9T6IGnYPb0vklO3iNVl4pMsuwDLk>
X-ME-Received: <xmr:XAGiabOc_2zVQtjJBHGM2QrYsiGcB_TAz3cnwxOe_j8ix1F8pYQouHuTiv99>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhgrgigvlh
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdr
 hhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:XAGiaXe0Q0TiFj6DxqhmRlrHitnj92GJ08GRh-760wCZjhy8GTEkrw>
 <xmx:XAGiaaV9wKmtYM8VDP1f-AM01LavA-i0sNEB3tYH33K4BpxQ8iSECQ>
 <xmx:XAGiafgW8CUmlrvPeph01aj9ZkBOndcqWsnW9g9Q_gGD30fja8hNgA>
 <xmx:XAGiaZ_ftW70nDGWEzySzcjXfAD-vHQ7CDYr_MQ3btdGTzj1Tk2Zww>
 <xmx:XQGiaUbyqslEtZRG0Aptte55Y12otTMDFe6mpGX6Yqc4CyiFWnyWWInK>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 77aaef6b;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 11/18] ati-vga: Introduce ATI2DCtx struct for 2D blit
 context
Date: Fri, 27 Feb 2026 15:39:37 -0500
Message-ID: <20260227203944.746471-12-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 221 +++++++++++++++++++++++++-------------------
 1 file changed, 126 insertions(+), 95 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 689b07b4d0..d43268ba5f 100644
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
 
@@ -67,100 +86,106 @@ void ati_2d_blt(ATIVGAState *s)
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    uint32_t rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
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
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     dst_height);
-            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride_words, tmp_stride_words, bpp, bpp,
-                                   src_x, src_y, 0, 0,
-                                   dst_width, dst_height);
+                                     ctx->dst.height);
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
+                                   src_stride_words, tmp_stride_words, ctx->bpp,
+                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
+                                   ctx->dst.width, ctx->dst.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
+                fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride_words, dst_stride_words,
-                                       bpp, bpp, 0, 0, dst_x, dst_y,
-                                       dst_width, dst_height);
+                                       ctx->bpp, ctx->bpp, 0, 0,
+                                       ctx->dst.x, ctx->dst.y,
+                                       ctx->dst.width, ctx->dst.height);
             }
             g_free(tmp);
         } else
@@ -169,18 +194,21 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -191,35 +219,38 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -227,9 +258,9 @@ void ati_2d_blt(ATIVGAState *s)
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


