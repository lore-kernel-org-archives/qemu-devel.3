Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E2ACEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNxi-00064s-AG; Tue, 18 Nov 2025 10:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwu-0004zr-3j
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwq-0001x1-JO
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:55 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id D061F1D00253;
 Tue, 18 Nov 2025 10:48:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480917; x=
 1763567317; bh=v9a5Rp/GL3pw3s6c7lYFE1jraXZm7oao+QupjGo4MmE=; b=G
 FxI9agC3GClG0GjM9vJ981x9mC8l2P0sUwcWqI4Tf4j918Sbr5I4IfucBxsSuDtb
 AmLxx2uJ5gxfo/aM+QQM2xqXpBAZZ/h8z21cMVTY6Bm1uQyEZ/+cQnJVIkd3WO7w
 6pxtqU4ymtbLAMMkHU/rjr9qm0fRsHRCy4vRE3MN2cm4XPEnBfRY3VlUXn0Ql9E9
 SM669weckQda2qRP7XDYoX+BdKblgOLu6zCdgloBaqrIvIVjZ6JNiWdWicViAssn
 ow6mXVqHEY6r5IUvKe+eK3Fpck5eB7r0AB61qJrPabHQku794LfViZcePAlCtu9/
 osNwBZ6gg0Hc2fSGzvdRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480917; x=1763567317; bh=v
 9a5Rp/GL3pw3s6c7lYFE1jraXZm7oao+QupjGo4MmE=; b=tRggQHdZp1raLaqkT
 HZptVRJRDDNWRT07iLuD9obwY4JOLJNl98BnOAfIXRUn/g9YhFHXJNRAwlnb3Vgm
 CMtBpoWanQ4F5ZNQHtLZPqu2gpviHD2IhzLqWhBiPPbyj5MJ0KafqGvUU8I99uEN
 TJiwCkiFcociEYvI654m+G0PfdIDsFS57cvbYf5skWWYqd2hxR3+5Af1mkt3lJwR
 53jLRA0jO6LRlY4xS7+k5OrV2NqrP03vatddxA0FvwUtnRN24lQj5W+uZF1jFmMO
 byRwkAVDsw+K0RitvBNtZaAfg0RdnT7NkqR0BQ36Q4/CcoHSrCqa8CD9Lqz2npv0
 ztELQ==
X-ME-Sender: <xms:VZUcaTQXqp1T0vMg_-LRsLxulYH-zYNFRp7_899bsFDGk5iAxsCMgQ>
 <xme:VZUcacOQBiApe2Ev8K-DTnFfQ8VuX9IYSbEy-hGsXKDUk7EZF-v-f9hUnj9y_Ta5U
 y1cEFUpQeVyIvutjiZpqqw0RPt3FFQHw9dg1ht_-pi_lhrgwaurPQ>
X-ME-Received: <xmr:VZUcaWPdHEtkm5nhQcSk-qtmsCEpnqBSKUM_0Bs3ySwAtCxaAUmiwS0ZvlHd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VZUcacu4P8QFmX7VyeWhjI4Q6WDefopVUZiT4iMjzxHXRdL94D43wg>
 <xmx:VZUcaQWMrZ5k5jDqahEAGJ8WjLjznBVPPNmQ72SmtA9l0PiIeLjA2Q>
 <xmx:VZUcaUud3vCaui--3n1pEowohMOk9K7Izoio9krmvoheL3jNP1685g>
 <xmx:VZUcacVkEQkIXPHIt3aU3EtjowaRx7zXGhvGUVK5q5LRARNOoFxBug>
 <xmx:VZUcaeYDJ7zm43brimjKDAkbVN1nvpgpqBYUWz_m26Ugaxy510pWpREQ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:36 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 6ab2304b;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 09/11] ati-vga: Refactor ati_2d_blt to use dst setup helper
Date: Tue, 18 Nov 2025 10:48:10 -0500
Message-ID: <20251118154812.57861-10-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a pure refactor of the ati_2d_blt function to make use of the
setup_2d_blt_dst helper and the struct it returns. There should be no
changes in behavior in this patch.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 166 +++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 95 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index f2e01e28e9..e30a4cd941 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -130,55 +130,29 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-
-    QemuRect dst = dst_rect(s);
-    QemuRect scissor = sc_rect(s);
-    QemuRect visible;
-    if (!qemu_rect_intersect(&dst, &scissor, &visible)) {
-        return;
-    }
-    uint32_t src_left_offset = visible.x - dst.x;
-    uint32_t src_top_offset = visible.y - dst.y;
-
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
-    }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
-    }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
-
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
-    }
+    ATIBlitDest dst = setup_2d_blt_dst(s);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (visible.x > 0x3fff || visible.y > 0x3fff || dst_bits >= end
-        || dst_bits + visible.x
-         + (visible.y + visible.height) * dst_stride >= end) {
-        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-        return;
-    }
+
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst.x, dst.y, dst.width, dst.height,
-            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
-            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
+            s->regs.src_x, s->regs.src_y,
+            dst.rect.x, dst.rect.y, dst.rect.width, dst.rect.height,
+            (dst.left_to_right ? '>' : '<'),
+            (dst.top_to_bottom ? 'v' : '^'));
+
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         s->regs.src_x + src_left_offset :
-                         s->regs.src_x + 1 - dst.width + src_left_offset);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         s->regs.src_y + src_top_offset :
-                         s->regs.src_y + 1 - dst.height + src_top_offset);
+        unsigned src_x = (dst.left_to_right ?
+                         s->regs.src_x + dst.src_left_offset :
+                         s->regs.src_x + 1 -
+                         dst.rect.width + dst.src_left_offset);
+        unsigned src_y = (dst.top_to_bottom ?
+                         s->regs.src_y + dst.src_top_offset :
+                         s->regs.src_y + 1 -
+                         dst.rect.height + dst.src_top_offset);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -188,44 +162,44 @@ void ati_2d_blt(ATIVGAState *s)
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            src_stride *= dst.bpp;
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + visible.height) * src_stride >= end) {
+             + (src_y + dst.visible.height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
+        dst.stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, visible.x, visible.y,
-                visible.width, visible.height);
+                src_bits, dst.bits, src_stride, dst.stride, dst.bpp, dst.bpp,
+                src_x, src_y, dst.visible.x, dst.visible.y,
+                dst.visible.width, dst.visible.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
-            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
-            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
-                                   src_x, src_y, visible.x, visible.y,
-                                   visible.width, visible.height);
+            dst.left_to_right &&
+            dst.top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst.bits,
+                                   src_stride, dst.stride, dst.bpp, dst.bpp,
+                                   src_x, src_y, dst.visible.x, dst.visible.y,
+                                   dst.visible.width, dst.visible.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = visible.width * (bpp / 8);
+            int llb = dst.visible.width * (dst.bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     visible.height);
+                                     dst.visible.height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride, tmp_stride, dst.bpp, dst.bpp,
                                    src_x, src_y, 0, 0,
-                                   visible.width, visible.height);
+                                   dst.visible.width, dst.visible.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, visible.x, visible.y,
-                                       visible.width, visible.height);
+                fallback = !pixman_blt(tmp, (uint32_t *)dst.bits,
+                                       tmp_stride, dst.stride, dst.bpp, dst.bpp,
+                                       0, 0, dst.visible.x, dst.visible.y,
+                                       dst.visible.width, dst.visible.height);
             }
             g_free(tmp);
         } else
@@ -234,35 +208,36 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = bpp / 8;
+            unsigned int y, i, j, bypp = dst.bpp / 8;
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
+            unsigned int dst_pitch = dst.stride * sizeof(uint32_t);
 
-            for (y = 0; y < visible.height; y++) {
-                i = visible.x * bypp;
+            for (y = 0; y < dst.visible.height; y++) {
+                i = dst.visible.x * bypp;
                 j = src_x * bypp;
-                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (visible.y + y) * dst_pitch;
+                if (dst.top_to_bottom) {
+                    i += (dst.visible.y + y) * dst_pitch;
                     j += (src_y + y) * src_pitch;
                 } else {
-                    i += (visible.y + visible.height - 1 - y) * dst_pitch;
-                    j += (src_y + visible.height - 1 - y) * src_pitch;
+                    i += (dst.visible.y + dst.visible.height - 1 - y) *
+                         dst_pitch;
+                    j += (src_y + dst.visible.height - 1 - y) * src_pitch;
                 }
-                memmove(&dst_bits[i], &src_bits[j], visible.width * bypp);
+                memmove(&dst.bits[i], &src_bits[j], dst.visible.width * bypp);
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst.bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst.bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    visible.y * surface_stride(ds),
-                                    visible.height * surface_stride(ds));
+                                    dst.visible.y * surface_stride(ds),
+                                    dst.visible.height * surface_stride(ds));
         }
-        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         visible.x + visible.width : visible.x);
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         visible.y + visible.height : visible.y);
+        s->regs.dst_x = (dst.left_to_right ?
+                         dst.visible.x + dst.visible.width : dst.visible.x);
+        s->regs.dst_y = (dst.top_to_bottom ?
+                         dst.visible.y + dst.visible.height : dst.visible.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -285,37 +260,38 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
+        dst.stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, visible.x, visible.y,
-                visible.width, visible.height, filler);
+                dst.bits, dst.stride, dst.bpp, dst.visible.x, dst.visible.y,
+                dst.visible.width, dst.visible.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
-                         visible.x, visible.y, visible.width, visible.height,
+            !pixman_fill((uint32_t *)dst.bits, dst.stride, dst.bpp,
+                         dst.visible.x, dst.visible.y,
+                         dst.visible.width, dst.visible.height,
                          filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-            for (y = 0; y < visible.height; y++) {
-                i = visible.x * bypp + (visible.y + y) * dst_pitch;
-                for (x = 0; x < visible.width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = dst.bpp / 8;
+            unsigned int dst_pitch = dst.stride * sizeof(uint32_t);
+            for (y = 0; y < dst.visible.height; y++) {
+                i = dst.visible.x * bypp + (dst.visible.y + y) * dst_pitch;
+                for (x = 0; x < dst.visible.width; x++, i += bypp) {
+                    stn_he_p(&dst.bits[i], bypp, filler);
                 }
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst.bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst.bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    visible.y * surface_stride(ds),
-                                    visible.height * surface_stride(ds));
+                                    dst.visible.y * surface_stride(ds),
+                                    dst.visible.height * surface_stride(ds));
         }
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         visible.y + visible.height : visible.y);
+        s->regs.dst_y = (dst.top_to_bottom ?
+                         dst.visible.y + dst.visible.height : dst.visible.y);
         break;
     }
     default:
-- 
2.51.0


