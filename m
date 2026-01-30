Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5960EE6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppP-0004jP-Kj; Fri, 30 Jan 2026 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppM-0004hg-O2
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:28 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppJ-00037c-NL
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:28 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E9D4A7A014F;
 Fri, 30 Jan 2026 09:50:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 09:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784624; x=
 1769871024; bh=xzOsuUawMO2+Y1RPHsk+AIZj06ef1x1Nb5hWiRi2MKU=; b=Y
 RxzX/I28wluPPdmY9QTkDv1hsTS9RsNV8epeVWj8/a8CNzfTCSVh51RTmaw/6KkB
 mU1r2r+UfMfNHFTKWFbGvZd/IKhAPcMhFA8xkC19KKNU9EazfAH3BhA4RGlu36hS
 9DO/H+MxJ6oV8j1x6hLCUstojs+sN9SEhcH76O3y194tFh1XHeSNOk8HQxzubott
 GOxVUNdL723mDDeZ2RuwrUOrebNBC9gJ25gq3duf2zlzH4q2tR6TVRY4wM+myXD/
 8CKDylSo9f3zd7PWDmZUfC2OxmlffFuAuwj1XNbXZgORNu7h/QRtXsts/E1o3j8K
 NANeHgRojHXfuE6h4a/6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784624; x=1769871024; bh=x
 zOsuUawMO2+Y1RPHsk+AIZj06ef1x1Nb5hWiRi2MKU=; b=lqpAq0t/eIGyDqlwb
 huZCdukM1JMXBEDqKZLciSJA2clvvcjrbjeeseyrPnNfUk48wHB9CrlJMjh/pe+5
 zM5Ywg/afHeKkkyYYZDxFwhF4hjlErgifyRbARKrQCVDcEe3In3MmYLfv/J1Yk+s
 /ZNFonpeZmGAqxYeZaBVy1e5Yu5rSNnJcpwv3slXntkfdS5Lls11sH01lUv7jbAW
 NWG2p9/yUtJ8rBUBAjxVZdoUU1tdrVas8wZC0I1cJUmoCB9j0LN3OYhtito6VZ6i
 wOOz1ovt9A7OylLT8E+yrpS9bfeEY4mGDCAATgJ9WOvU/zYxZd2XXl3Gz8Uyv7xq
 gRGkA==
X-ME-Sender: <xms:MMV8aXXBEV6yvFb7M0nfdd5Z6CTmMaOs0xin9zvEC1085co2ZsKvxw>
 <xme:MMV8aXB0DIGpr9ZhFA_s29HgD4gjvB5deuNr9QlG7ol31ccRZcmF0KjiFOx5OaafL
 oMkFZUgpis1rWlc7XAmzBZEvAD_7woxM8v89dhDAqzfmIFZrDG_XWg>
X-ME-Received: <xmr:MMV8aQw8qM6IpwPU4BoqGhuE0odkA_ygG_pNNrTMuhZGryg5RUUU3LKSKQU7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:MMV8acDcbs_PN1ltdqBuWNRZy0wPhfe53S1gNJD6Nj19EJ_2Xrt10w>
 <xmx:MMV8aVb56VczfZkniFALu7VbU-1flPTegt_1P4eqmMhXyMbrdHSMCw>
 <xmx:MMV8acjuex4kiMHzHQOCbQDKyeWSUADpZ2B-fJvVXhyx-UAX6Vt0hg>
 <xmx:MMV8af5kf1GeEE8aYCIv4NMJd6VtfklLCQt5KkePXg4Q1E2LslEsAQ>
 <xmx:MMV8aavYYWYz2CgRrZXIOwf3465VOA4R7CeLcJbXDXck3sTdpL4gIWJ6>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id dd6e8917;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 10/20] ati-vga: Use local variables for register values in
 ati_2d_blt
Date: Fri, 30 Jan 2026 09:49:55 -0500
Message-ID: <20260130145005.731129-11-chad@jablonski.xyz>
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

ati_2d_blt uses a mixture of locals and direct register access of needed
state. This assigns all values derived from register state to local
variables. It prepares the function for a larger refactor that removes
the dependency on the full device and direct register access entirely.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 104 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 47 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 310b3067b4..a368950182 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -48,14 +48,24 @@ void ati_2d_blt(ATIVGAState *s)
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
+    bool use_pixman_fill = s->use_pixman & BIT(0);
+    bool use_pixman_blt = s->use_pixman & BIT(1);
+    int rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
+    uint8_t *palette = s->vga.palette;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+            rop3 >> 16);
+    unsigned dst_offset = s->regs.dst_offset;
+    unsigned dst_width = s->regs.dst_width;
+    unsigned dst_height = s->regs.dst_height;
+    unsigned dst_x = (left_to_right ?
+                     s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
+    unsigned dst_y = (top_to_bottom ?
+                     s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
     int bpp = ati_bpp_from_datatype(s);
     if (!bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -66,7 +76,7 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -76,25 +86,25 @@ void ati_2d_blt(ATIVGAState *s)
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
         || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+         + (dst_y + dst_height) * dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
+            s->regs.src_offset, dst_offset, s->regs.default_offset,
+            s->regs.src_pitch, dst_stride, s->regs.default_pitch,
             s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            s->regs.dst_width, s->regs.dst_height,
-            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
-            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
-    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+            dst_width, dst_height,
+            (left_to_right ? '>' : '<'),
+            (top_to_bottom ? 'v' : '^'));
+    switch (rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+        unsigned src_x = (left_to_right ?
+                         s->regs.src_x : s->regs.src_x + 1 - dst_width);
+        unsigned src_y = (top_to_bottom ?
+                         s->regs.src_y : s->regs.src_y + 1 - dst_height);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -109,7 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
         int src_stride_words = src_stride / sizeof(uint32_t);
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -117,30 +127,28 @@ void ati_2d_blt(ATIVGAState *s)
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride_words, dst_stride_words,
                 bpp, bpp, src_x, src_y, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height);
+                dst_width, dst_height);
 #ifdef CONFIG_PIXMAN
-        if ((s->use_pixman & BIT(1)) &&
-            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
-            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+        if (use_pixman_blt && left_to_right && top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
                                    src_stride_words, dst_stride_words, bpp, bpp,
                                    src_x, src_y, dst_x, dst_y,
-                                   s->regs.dst_width, s->regs.dst_height);
-        } else if (s->use_pixman & BIT(1)) {
+                                   dst_width, dst_height);
+        } else if (use_pixman_blt) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = s->regs.dst_width * (bpp / 8);
+            int llb = dst_width * (bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
                                    src_stride_words, tmp_stride, bpp, bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   dst_width, dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
                                        tmp_stride, dst_stride_words, bpp, bpp,
                                        0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                                       dst_width, dst_height);
             }
             g_free(tmp);
         } else
@@ -150,17 +158,17 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = bpp / 8;
-            for (y = 0; y < s->regs.dst_height; y++) {
+            for (y = 0; y < dst_height; y++) {
                 i = dst_x * bypp;
                 j = src_x * bypp;
-                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+                if (top_to_bottom) {
                     i += (dst_y + y) * dst_stride;
                     j += (src_y + y) * src_stride;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_stride;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_stride;
+                    i += (dst_y + dst_height - 1 - y) * dst_stride;
+                    j += (src_y + dst_height - 1 - y) * src_stride;
                 }
-                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+                memmove(&dst_bits[i], &src_bits[j], dst_width * bypp);
             }
         }
         break;
@@ -171,35 +179,37 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+        switch (rop3) {
         case ROP3_PATCOPY:
-            filler = s->regs.dp_brush_frgd_clr;
+            filler = frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[0],
-                     s->vga.palette[1], s->vga.palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0],
+                                                   palette[1],
+                                                   palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
-                     s->vga.palette[4], s->vga.palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3],
+                                                   palette[4],
+                                                   palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
                 dst_bits, dst_stride_words, bpp, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height, filler);
+                dst_width, dst_height, filler);
 #ifdef CONFIG_PIXMAN
-        if (!(s->use_pixman & BIT(0)) ||
+        if (!use_pixman_fill ||
             !pixman_fill((uint32_t *)dst_bits, dst_stride_words,
                          bpp, dst_x, dst_y,
-                         s->regs.dst_width, s->regs.dst_height, filler))
+                         dst_width, dst_height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
-            for (y = 0; y < s->regs.dst_height; y++) {
+            for (y = 0; y < dst_height; y++) {
                 i = dst_x * bypp + (dst_y + y) * dst_stride;
-                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
+                for (x = 0; x < dst_width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
             }
@@ -208,7 +218,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+                      rop3 >> 16);
         return;
     }
 
@@ -216,7 +226,7 @@ void ati_2d_blt(ATIVGAState *s)
         dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
         s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
         memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                s->regs.dst_offset + dst_y * surface_stride(ds),
-                                s->regs.dst_height * surface_stride(ds));
+                                dst_offset + dst_y * surface_stride(ds),
+                                dst_height * surface_stride(ds));
     }
 }
-- 
2.52.0


