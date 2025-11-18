Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75B4CEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNx9-0005TH-V5; Tue, 18 Nov 2025 10:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwv-000513-RJ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwr-0001wp-L4
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 946697A017D;
 Tue, 18 Nov 2025 10:48:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 10:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480916; x=
 1763567316; bh=Z2edmTsmlfyCNhBlxeziD5JnEZgw0x5Fa3j/cl/tWy4=; b=U
 QEe2cJg14ZdLGMl4GvKPnQrSmUgk/zpC1dVISwHJshebtGSucyogVAtyVDtg+xaH
 EKdtV75uMFV6xM/QQJU3v1GzljWseSAfZy7618p672OWMJdl2OQ8muExJIpwl1TB
 U3s15Kg/tV8rrH1bFPrZoiNeZrHTX8rLt5vTLLJJ+svvz+uPmpQD7LUF+a71TLTv
 ZJ6uWEoZauoxdjr8UWV9axT62xodHGEIL32cRArVWiXm0/ZViv4zrXn9JjpNCVBu
 Vw5ERdkOpyyGLqCkLMQgg1pFgAvOxfA/RT3m9xQQG+8ZqSZdRKcLiI92wsaFm3hy
 laABGzbKo0+5YSUdGeRtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480916; x=1763567316; bh=Z
 2edmTsmlfyCNhBlxeziD5JnEZgw0x5Fa3j/cl/tWy4=; b=DZMOmPkJ8M5qfvjKE
 NqAWQ5UUc0tiEPKnVvdzYvV3gWMzrbdPUzt1tjnqnrJVBMqv09nbQCQXZ7N96FPp
 6Jut3Br8mjRXsK6BZ48+CHtGmDlSiWTs4OWleLcwjM1gU4M/TPLvcmf3yMA38U83
 F/9o1l5qtsmyR2fNXQ3plCHZQGt1HJWbSDDbdtHbt6qsiTo+Rdt3HBLmw/RSTtHg
 UTqt8x6rh9LztxLG/oVdnPKTpQnv+XV4oX58rReKZLVFC0y/al1Ct04RKMoLQ8Jz
 +abSygDIirfbPEixX2zyABdqBRusywjatYZdWL5dmYhFbBkZ847U4VsW0V8457xA
 3kNDQ==
X-ME-Sender: <xms:VJUcadjrOdhEGfqOTHPy5WooY1_2ewiWRVP2hn6Rdd-phdIuUIvC6w>
 <xme:VJUcaZdyf4e8HwN1JCqEDAfmiQoUrImjrtg22981xj6hm2mQtB3173OtD4oyQDfdh
 TjH24F2O4sMn8b2_JggZ3eQxFssCGphtELIpDWDg8McSdERRGBl3wA>
X-ME-Received: <xmr:VJUcaad86fsnrD6SE6lrr_2v4A4ILV5HU6AHwN_Zc8KFVPU7E5cbIMcWWbJn>
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
X-ME-Proxy: <xmx:VJUcab-gJq0VZ4hxmQ6f8rcqL7lTasnKbGw3hrFvGxbAxbENmbNopA>
 <xmx:VJUcaemGU6pnDvNb3BR7RhLl7qBkRS9xfuQgEGT6Pd0U_SYT5rHigg>
 <xmx:VJUcaV9IIwiOl2If4Lg0xKOhBabvv4PNVEnzi3W_6govqnruzAmPwQ>
 <xmx:VJUcaUk0crFOqfUIhme4zuz133pPZuF8XElQVfMWSjSLVoKuFuOBfg>
 <xmx:VJUcaRqhHfzF4Zg1HtVL05VELRB4ZAgJoeKa_DNR_2sE5qk848pcrWmK>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:35 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8143d485;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 07/11] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Tue, 18 Nov 2025 10:48:08 -0500
Message-ID: <20251118154812.57861-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
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

Use scissor registers to clip blit operations. This is required
for text rendering in X using the r128 driver. Without it overly-wide
glyphs are drawn and create all sorts of chaos.

Use QemuRect helpers for calculating the intersection of the
destination and scissor rectangles. Source coordinates are
also updated to reflect clipping. The original destination dimensions
are stored in 'dst' while the clipped rectangle is in 'visible' for
clear distinction between the two.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 90 ++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0695c26b3b..9c96ee155f 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -76,10 +76,16 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+
+    QemuRect dst = dst_rect(s);
+    QemuRect scissor = sc_rect(s);
+    QemuRect visible;
+    if (!qemu_rect_intersect(&dst, &scissor, &visible)) {
+        return;
+    }
+    uint32_t src_left_offset = visible.x - dst.x;
+    uint32_t src_top_offset = visible.y - dst.y;
+
     int bpp = ati_bpp_from_datatype(s);
     if (!bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -97,17 +103,16 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride *= bpp;
     }
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+    if (visible.x > 0x3fff || visible.y > 0x3fff || dst_bits >= end
+        || dst_bits + visible.x
+         + (visible.y + visible.height) * dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            s->regs.dst_width, s->regs.dst_height,
+            s->regs.src_x, s->regs.src_y, dst.x, dst.y, dst.width, dst.height,
             (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
             (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
@@ -115,9 +120,11 @@ void ati_2d_blt(ATIVGAState *s)
     {
         bool fallback = false;
         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
+                         s->regs.src_x + src_left_offset :
+                         s->regs.src_x + 1 - dst.width + src_left_offset);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+                         s->regs.src_y + src_top_offset :
+                         s->regs.src_y + 1 - dst.height + src_top_offset);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -131,7 +138,7 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + visible.height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -140,31 +147,31 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height);
+                src_x, src_y, visible.x, visible.y,
+                visible.width, visible.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
                                    src_stride, dst_stride, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   src_x, src_y, visible.x, visible.y,
+                                   visible.width, visible.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = s->regs.dst_width * (bpp / 8);
+            int llb = visible.width * (bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     visible.height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
                                    src_stride, tmp_stride, bpp, bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   visible.width, visible.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
                                        tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                                       0, 0, visible.x, visible.y,
+                                       visible.width, visible.height);
             }
             g_free(tmp);
         } else
@@ -177,17 +184,17 @@ void ati_2d_blt(ATIVGAState *s)
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
 
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp;
+            for (y = 0; y < visible.height; y++) {
+                i = visible.x * bypp;
                 j = src_x * bypp;
                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (dst_y + y) * dst_pitch;
+                    i += (visible.y + y) * dst_pitch;
                     j += (src_y + y) * src_pitch;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                    i += (visible.y + visible.height - 1 - y) * dst_pitch;
+                    j += (src_y + visible.height - 1 - y) * src_pitch;
                 }
-                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+                memmove(&dst_bits[i], &src_bits[j], visible.width * bypp);
             }
         }
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
@@ -195,13 +202,13 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    visible.y * surface_stride(ds),
+                                    visible.height * surface_stride(ds));
         }
         s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         dst_x + s->regs.dst_width : dst_x);
+                         visible.x + visible.width : visible.x);
         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+                         visible.y + visible.height : visible.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -226,20 +233,21 @@ void ati_2d_blt(ATIVGAState *s)
 
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height, filler);
+                dst_bits, dst_stride, bpp, visible.x, visible.y,
+                visible.width, visible.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
+                         visible.x, visible.y, visible.width, visible.height,
+                         filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-            for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_pitch;
-                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
+            for (y = 0; y < visible.height; y++) {
+                i = visible.x * bypp + (visible.y + y) * dst_pitch;
+                for (x = 0; x < visible.width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
             }
@@ -249,11 +257,11 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
+                                    visible.y * surface_stride(ds),
+                                    visible.height * surface_stride(ds));
         }
         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
+                         visible.y + visible.height : visible.y);
         break;
     }
     default:
-- 
2.51.0


