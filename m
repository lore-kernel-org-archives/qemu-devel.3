Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDA1EB362E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e0-0006QU-0R; Mon, 02 Mar 2026 13:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006L4-Jy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:12 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dh-0006Y8-Tq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:08 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5C6F014001A1;
 Mon,  2 Mar 2026 13:05:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 13:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474705; x=
 1772561105; bh=u1D2gj1k8+504f+ZE233OXp2oE6ZzFIewogKeoLNcOA=; b=h
 +MX7gAMGVsJ3PBesM9MU7m11icqoPkR/B0Owox9Ozjkjhqm3L173VhDbv+zZkIAF
 ME0+NAM5tDyW+3XCuitCQpNOIJXAkn9MEFTyxFlwgZ8SS97mMlCZXw2PkqbheycK
 rhpAmSgup1q68FSqeuqMkVs8r0T9YAlonC/Ejy/YU30Oho4rO4YhJdKqoF/wthJJ
 38nBtcfKtNbFkc6HmCqVWXGbUgFrkJAEmFK4dvurAnXicxVQ9Zkkx/j4od2WOSOk
 IaBQntqsDg6Iv3pwykSfUQflR7HvGo5XBZIqr1I38myuViG+YaswHb/SoTN4S4O9
 xpblRJvFU8RJbvjtt/dlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474705; x=1772561105; bh=u
 1D2gj1k8+504f+ZE233OXp2oE6ZzFIewogKeoLNcOA=; b=mFRBXs7mV/Ujd4kHU
 hZxTFQ9xvDh9iTcHwQlEEp0VQrEK/o2toI2ps5+hNI9v23TdsHAD5c54T7HGKkd6
 s0BO19rkP+xvWv43DVuKbrEjWmUI+wt/cThmtK/Y84dOFnC17FYAB749inDWFGVO
 IpnyUpfE0lEa6Z9wliLKQVDidYxzI7s8MXiKTLmrGyigIAFuqUo+ClEW4wiaNSye
 YkuYf5Eu28YcbdF9XJiEecXAJRWpAm3V6m/nCbvexyqGALYvOXWsSCer+5t/fv4m
 BsDFqkdo21Zlbk+FUon6LKzxto7FOdgEd1xXuo/TArtDrwAEYE6ioj+oKOoTggpo
 u5FWg==
X-ME-Sender: <xms:UdGlabNRyXyRbAcYnzo5rkZWagjYukOACKYEygceiJnTYzlMCuzsDQ>
 <xme:UdGlac2BT6cuvvqGpdAiO9RoM51CU1pfnjdFYImwWH9prNzxItDk2Avrbgpf5ufbL
 omO1uyrqN4dWc2UpnNxLYX9Xcfdtv_1AEYva-bdpOexNLLs-7j9TQ>
X-ME-Received: <xmr:UdGlaSkFh71x_5JxrXFGq7m8SQH2STcReP_y0nHrN00Ei26hoXLrczI2V9tE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:UdGlabUyjdYxZnaALsm7fIk2Iv1XC4wy2CQEr-pXd9_IkHWEvJmDew>
 <xmx:UdGlaQvynh8urKuSeOkQsUuWu2y7zNGy5rqH_zg-UDTXtkdr9iYpLg>
 <xmx:UdGlaWZKQ_T8vdbDLBOf4yeKFkTxl27XQfk0-4JQh2sdoxIKa7v5Xw>
 <xmx:UdGlaXWZv9VecEEE-tz3-du65C9wQQ8dSoZ4RCcItuugP1PuMFBXfg>
 <xmx:UdGlaTTsL8XQOHMiHXVTOJ-Xh67_xfYHc6jHo_5DnKXHoqgh3W8BT6oY>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:04 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 38fde03e;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 10/17] ati-vga: Use local variables for register values in
 ati_2d_blt
Date: Mon,  2 Mar 2026 13:04:40 -0500
Message-ID: <20260302180447.1078098-11-chad@jablonski.xyz>
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

ati_2d_blt uses a mixture of locals and direct register access of needed
state. This assigns all values derived from register state to local
variables. It prepares the function for a larger refactor that removes
the dependency on the full device and direct register access entirely.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 97 ++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index e366774835..689b07b4d0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -65,10 +65,20 @@ void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+    bool use_pixman_fill = s->use_pixman & BIT(0);
+    bool use_pixman_blt = s->use_pixman & BIT(1);
+    uint32_t rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
+    uint8_t *palette = s->vga.palette;
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
@@ -79,7 +89,7 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -88,26 +98,25 @@ void ati_2d_blt(ATIVGAState *s)
     int dst_stride_words = dst_stride / sizeof(uint32_t);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+        || dst_bits + dst_x + (dst_y + dst_height) * dst_stride >= end) {
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
@@ -122,7 +131,7 @@ void ati_2d_blt(ATIVGAState *s)
         int src_stride_words = src_stride / sizeof(uint32_t);
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -130,30 +139,28 @@ void ati_2d_blt(ATIVGAState *s)
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
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
                                    src_stride_words, tmp_stride_words, bpp, bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   dst_width, dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
                                        tmp_stride_words, dst_stride_words,
                                        bpp, bpp, 0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                                       dst_width, dst_height);
             }
             g_free(tmp);
         } else
@@ -163,17 +170,17 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -184,34 +191,34 @@ void ati_2d_blt(ATIVGAState *s)
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
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
+                                                   palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
-                     s->vga.palette[4], s->vga.palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
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
             !pixman_fill((uint32_t *)dst_bits, dst_stride_words, bpp, dst_x,
-                         dst_y, s->regs.dst_width, s->regs.dst_height, filler))
+                         dst_y, dst_width, dst_height, filler))
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
@@ -220,7 +227,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+                      rop3 >> 16);
         return;
     }
 
-- 
2.52.0


