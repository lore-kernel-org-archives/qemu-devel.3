Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8178E6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppR-0004ka-9X; Fri, 30 Jan 2026 09:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppN-0004i0-BB
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppJ-00037n-Vk
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 387437A014B;
 Fri, 30 Jan 2026 09:50:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 30 Jan 2026 09:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784625; x=
 1769871025; bh=o1ubcYdTEFR+3MVjNXjnWKMO4P8GPx3t8mG+POQHPQY=; b=Z
 MpACYcv5xg4i4yHjXxPkkWbtMBVJUCTN53Aj3dmNjVMFo810UIilSpDHclHRWUF9
 8ae1Pgho01bFV0A2P98JH+HSvWqonclsjvB+O6jVQI82Siw4djCggaWEJzd6mT6q
 0kIIdDWWYM8ORwcbJaNiq0gR7undW+pO1tV0CA98Dfz32cXDnhH0LjiBgQ1m9nwP
 /cfQ5RR9dd+Rgczri/8UQ2DjkjoG+qi7lnea9fU0dDGqN+dTHelmm5LFZwwUJkA+
 Wi1Nn2ZBJuW2PghfsKyDl5DRXlQgCS09PFXTMLHbSDkWYEZBub2zrxwTUjeEoO4M
 4kYDzTA0tgJVOI1tkRybg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784625; x=1769871025; bh=o
 1ubcYdTEFR+3MVjNXjnWKMO4P8GPx3t8mG+POQHPQY=; b=mIDsbQtg1YzOmXG6k
 j7OCljrdW2ffK3gmVe2kphdYxmlVf5o4JYlnV8emBr3QiWSofEyrO+1HpHdwPGOV
 i6l9V11oxdyPpaNYbblOANIvHxB02r784intoE/Fnb6rqzT1+UvkQKfcLYqviOEF
 QJrqza2BLGDWqknV6SZRWrCzXWEXnZyKZTfOZbpwxbOm6qMp/AUtU4jsGZ3KY+Dq
 KEP+bByOo4ZDbg6OWLHLA9cbKPYXMuqqovTa/2ERGmhZB+Wf5/OKJgC0meoXQjpk
 umpsnPQgtz99kq4zTTblCiB7xP2CW6TSaXHCMSdFX+FmqOYfSjF5epKjnIitHNih
 uXkFw==
X-ME-Sender: <xms:MMV8aemVw1EnxQvaSES-HxbL7ArN60DYjG4NCegwKNMKuowgXtP4LQ>
 <xme:MMV8adQhlHuq0hf7ltmbfSpJwUBWj-bVsScjmZjIKGK0h1ppSEVMcsWbOFVABeSwc
 JoMXGLO8Qg8rSgOqa-G3Ewfr0Br4QOvpKHF8fjUncBcQzX2bq_--tA>
X-ME-Received: <xmr:MMV8aaDnZPB5Jlf1RSe7aLOwXqV0E6pXluzAZzSxYax6eBH09eGS_aELVbug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:McV8acTiWjPZUept2n0Ng5nTNrzPZ_iA0UDU_ogyuRYh8mGhaquu0g>
 <xmx:McV8aQohgPQH4ntNE0UaFwlUFVA5naHq4ZN_6yeNeQzBlqU7qlapxQ>
 <xmx:McV8aWyOBmRsuSbzdAw_5z7F6aHaPXqdAI5t4628UEstzXHgjRDQIw>
 <xmx:McV8adK1ItxyhAFWoJ9tBtV93y5jQIdNNKW25srrjWSujgdN2PY11w>
 <xmx:McV8ae8sjE6p8_b_lXEisOkbC9S40QtPQY1GiZ_bYKrRcY4cr07BLLiQ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f6f394ec;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 11/20] ati-vga: Introduce ATI2DCtx struct for 2D blit
 context
Date: Fri, 30 Jan 2026 09:49:56 -0500
Message-ID: <20260130145005.731129-12-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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

vram_end feels a little out of place to me in the ATI2DCtx struct but moving
it into the ctx allows us to eventually remove ATIVGAState entirely. I
also considered moving the dst validation that requires it outside of
ati_2d_blt and making it the responsibility of the caller but that has its
own downsides (forgetting to validate). In the end I left it in the ctx.
---
 hw/display/ati_2d.c | 216 +++++++++++++++++++++++++-------------------
 1 file changed, 122 insertions(+), 94 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a368950182..bc41ad37f6 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -43,6 +44,26 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+typedef struct {
+    int bpp;
+    uint32_t rop3;
+    bool left_to_right;
+    bool top_to_bottom;
+    uint32_t frgd_clr;
+    const uint8_t *palette;
+    const uint8_t *vram_end;
+
+    /* dst */
+    QemuRect dst;
+    int dst_stride;
+    uint8_t *dst_bits;
+
+    /* src */
+    QemuRect src;
+    int src_stride;
+    const uint8_t *src_bits;
+} ATI2DCtx;
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -50,105 +71,111 @@ void ati_2d_blt(ATIVGAState *s)
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    int rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
-    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
-    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
-    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
-    uint8_t *palette = s->vga.palette;
+    ATI2DCtx ctx;
+    ctx.rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx.left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    ctx.top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx.frgd_clr = s->regs.dp_brush_frgd_clr;
+    ctx.palette = s->vga.palette;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
-            rop3 >> 16);
+            ctx.rop3 >> 16);
     unsigned dst_offset = s->regs.dst_offset;
-    unsigned dst_width = s->regs.dst_width;
-    unsigned dst_height = s->regs.dst_height;
-    unsigned dst_x = (left_to_right ?
-                     s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
-    unsigned dst_y = (top_to_bottom ?
-                     s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
+    ctx.dst.width = s->regs.dst_width;
+    ctx.dst.height = s->regs.dst_height;
+    ctx.dst.x = (ctx.left_to_right ?
+                s->regs.dst_x : s->regs.dst_x + 1 - ctx.dst.width);
+    ctx.dst.y = (ctx.top_to_bottom ?
+                s->regs.dst_y : s->regs.dst_y + 1 - ctx.dst.height);
+    ctx.bpp = ati_bpp_from_datatype(s);
+    if (!ctx.bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
+    ctx.dst_stride = s->regs.dst_pitch;
+    if (!ctx.dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
+    ctx.dst_bits = s->vga.vram_ptr + dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
+        ctx.dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx.dst_stride *= ctx.bpp;
     }
-    int dst_stride_words = dst_stride / sizeof(uint32_t);
-    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + dst_height) * dst_stride >= end) {
+    int dst_stride_words = ctx.dst_stride / sizeof(uint32_t);
+    ctx.vram_end = s->vga.vram_ptr + s->vga.vram_size;
+    if (ctx.dst.x > 0x3fff || ctx.dst.y > 0x3fff || ctx.dst_bits >= ctx.vram_end
+        || ctx.dst_bits + ctx.dst.x
+         + (ctx.dst.y + ctx.dst.height) * ctx.dst_stride >= ctx.vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, dst_stride, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            dst_width, dst_height,
-            (left_to_right ? '>' : '<'),
-            (top_to_bottom ? 'v' : '^'));
-    switch (rop3) {
+            ctx.src_stride, ctx.dst_stride, s->regs.default_pitch,
+            ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
+            ctx.dst.width, ctx.dst.height,
+            (ctx.left_to_right ? '>' : '<'),
+            (ctx.top_to_bottom ? 'v' : '^'));
+    switch (ctx.rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (left_to_right ?
-                         s->regs.src_x : s->regs.src_x + 1 - dst_width);
-        unsigned src_y = (top_to_bottom ?
-                         s->regs.src_y : s->regs.src_y + 1 - dst_height);
-        int src_stride = s->regs.src_pitch;
-        if (!src_stride) {
+        ctx.src.x = (ctx.left_to_right ?
+                    s->regs.src_x : s->regs.src_x + 1 - ctx.dst.width);
+        ctx.src.y = (ctx.top_to_bottom ?
+                    s->regs.src_y : s->regs.src_y + 1 - ctx.dst.height);
+        ctx.src_stride = s->regs.src_pitch;
+        if (!ctx.src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
+        ctx.src_bits = s->vga.vram_ptr + s->regs.src_offset;
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            ctx.src_bits += s->regs.crtc_offset & 0x07ffffff;
+            ctx.src_stride *= ctx.bpp;
         }
-        int src_stride_words = src_stride / sizeof(uint32_t);
-        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
-            || src_bits + src_x
-             + (src_y + dst_height) * src_stride >= end) {
+        int src_stride_words = ctx.src_stride / sizeof(uint32_t);
+        if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
+            || ctx.src_bits >= ctx.vram_end
+            || ctx.src_bits + ctx.src.x
+             + (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride_words, dst_stride_words,
-                bpp, bpp, src_x, src_y, dst_x, dst_y,
-                dst_width, dst_height);
+                ctx.src_bits, ctx.dst_bits, src_stride_words, dst_stride_words,
+                ctx.bpp, ctx.bpp, ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
+                ctx.dst.width, ctx.dst.height);
 #ifdef CONFIG_PIXMAN
-        if (use_pixman_blt && left_to_right && top_to_bottom) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride_words, dst_stride_words, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   dst_width, dst_height);
+        if (use_pixman_blt && ctx.left_to_right && ctx.top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)ctx.src_bits,
+                                   (uint32_t *)ctx.dst_bits,
+                                   src_stride_words, dst_stride_words,
+                                   ctx.bpp, ctx.bpp,
+                                   ctx.src.x, ctx.src.y, ctx.dst.x, ctx.dst.y,
+                                   ctx.dst.width, ctx.dst.height);
         } else if (use_pixman_blt) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = dst_width * (bpp / 8);
+            int llb = ctx.dst.width * (ctx.bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     dst_height);
-            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride_words, tmp_stride, bpp, bpp,
-                                   src_x, src_y, 0, 0,
-                                   dst_width, dst_height);
+                                     ctx.dst.height);
+            fallback = !pixman_blt((uint32_t *)ctx.src_bits, tmp,
+                                   src_stride_words, tmp_stride,
+                                   ctx.bpp, ctx.bpp,
+                                   ctx.src.x, ctx.src.y, 0, 0,
+                                   ctx.dst.width, ctx.dst.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride_words, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
-                                       dst_width, dst_height);
+                fallback = !pixman_blt(tmp, (uint32_t *)ctx.dst_bits,
+                                       tmp_stride, dst_stride_words,
+                                       ctx.bpp, ctx.bpp,
+                                       0, 0, ctx.dst.x, ctx.dst.y,
+                                       ctx.dst.width, ctx.dst.height);
             }
             g_free(tmp);
         } else
@@ -157,18 +184,19 @@ void ati_2d_blt(ATIVGAState *s)
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
+            unsigned int y, i, j, bypp = ctx.bpp / 8;
+            for (y = 0; y < ctx.dst.height; y++) {
+                i = ctx.dst.x * bypp;
+                j = ctx.src.x * bypp;
+                if (ctx.top_to_bottom) {
+                    i += (ctx.dst.y + y) * ctx.dst_stride;
+                    j += (ctx.src.y + y) * ctx.src_stride;
                 } else {
-                    i += (dst_y + dst_height - 1 - y) * dst_stride;
-                    j += (src_y + dst_height - 1 - y) * src_stride;
+                    i += (ctx.dst.y + ctx.dst.height - 1 - y) * ctx.dst_stride;
+                    j += (ctx.src.y + ctx.dst.height - 1 - y) * ctx.src_stride;
                 }
-                memmove(&dst_bits[i], &src_bits[j], dst_width * bypp);
+                memmove(&ctx.dst_bits[i], &ctx.src_bits[j],
+                        ctx.dst.width * bypp);
             }
         }
         break;
@@ -179,38 +207,38 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (rop3) {
+        switch (ctx.rop3) {
         case ROP3_PATCOPY:
-            filler = frgd_clr;
+            filler = ctx.frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0],
-                                                   palette[1],
-                                                   palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx.palette[0],
+                                                   ctx.palette[1],
+                                                   ctx.palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3],
-                                                   palette[4],
-                                                   palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx.palette[3],
+                                                   ctx.palette[4],
+                                                   ctx.palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride_words, bpp, dst_x, dst_y,
-                dst_width, dst_height, filler);
+                ctx.dst_bits, dst_stride_words, ctx.bpp, ctx.dst.x, ctx.dst.y,
+                ctx.dst.width, ctx.dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!use_pixman_fill ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride_words,
-                         bpp, dst_x, dst_y,
-                         dst_width, dst_height, filler))
+            !pixman_fill((uint32_t *)ctx.dst_bits, dst_stride_words,
+                         ctx.bpp, ctx.dst.x, ctx.dst.y,
+                         ctx.dst.width, ctx.dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            for (y = 0; y < dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_stride;
-                for (x = 0; x < dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = ctx.bpp / 8;
+            for (y = 0; y < ctx.dst.height; y++) {
+                i = ctx.dst.x * bypp + (ctx.dst.y + y) * ctx.dst_stride;
+                for (x = 0; x < ctx.dst.width; x++, i += bypp) {
+                    stn_he_p(&ctx.dst_bits[i], bypp, filler);
                 }
             }
         }
@@ -218,15 +246,15 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      rop3 >> 16);
+                      ctx.rop3 >> 16);
         return;
     }
 
-    if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-        dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+    if (ctx.dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+        ctx.dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
         s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
         memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                dst_offset + dst_y * surface_stride(ds),
-                                dst_height * surface_stride(ds));
+                                dst_offset + ctx.dst.y * surface_stride(ds),
+                                ctx.dst.height * surface_stride(ds));
     }
 }
-- 
2.52.0


