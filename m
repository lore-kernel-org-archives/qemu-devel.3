Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87D1039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eD-0002bm-61; Fri, 27 Feb 2026 15:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e1-0001T9-Hl
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dy-0007Pz-79
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:04 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id EC98FEC0636;
 Fri, 27 Feb 2026 15:41:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 15:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224860; x=
 1772311260; bh=u1D2gj1k8+504f+ZE233OXp2oE6ZzFIewogKeoLNcOA=; b=s
 lRkq5OD032aqH27fu+CEjB/nvqKFpLdabMVk8QK1RSZQC4Nf1fZ5LEXpdWhc80+N
 LqtgD4ooqr6JeFJgB7/Z5MdvuhnHcJ2j7Y/XgH0Z7Zm24LTDrEJ4s+jbZHdum/VR
 73/rgzWb8BLtze1cyiNyZE9Um3WaEGqqSn/QJSWUx9NWmviN79mFRavTmlDVZDQ+
 a4I50k6RH4ho9s7lO1WxEvz7jZY0vBB8OJ24poEHJmD9u4p4MAJ5VTXIqzX2h4Pz
 QBLPNzE6jvrjCyYejUnxO4ne1vpVnrCBkELsuVWeHSpTKAb7K5MWFXsQmKdDnleK
 tleaRBDfWwwBV6vMl1O8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224860; x=1772311260; bh=u
 1D2gj1k8+504f+ZE233OXp2oE6ZzFIewogKeoLNcOA=; b=RSgkc2iifZdFmOoRW
 zi2zSJhzugcHzPKgChA+D3RGHEpDPqhDkijCFaVAsJ5JtdMEff0L0gnUFA842hJ6
 91yurKM82L7p68B9IhMiG8e0IVNdebNvYNMjFXlM43mHfDSGCqyRH49usdMTef9M
 0VtHDkCF/feYblMP/WMsPP8jZcmSDAK/p7i4h2esIiMiczwkexflKj+xIQcxRMO/
 itSusuWmylRnZC3Wn/LKH6JpXY4b+pZ/MkpEV2hhNKuixSQ0KR4wFL6yziT9UXxI
 chMVd3MK0BrvvaK8MldMRFP6fgBOc8NKiZg8y/PevaajbFsI8m0ExRd9GNwfUSc2
 GGclA==
X-ME-Sender: <xms:XAGiaSCjDtJXhBAz20oLS8SKoclyGKRlKNNX4yMQdq15i7x79n1g8A>
 <xme:XAGiaYDHXFt-iZdf-eAYefJzAbED6fcQutYcea1qiK3eFrj2E2zRVcck2hl0l7S8s
 LVaxENcnmJbW2yeVvuv17odcw-6fumto5PON-zhVbY66QsY5cMTGgE>
X-ME-Received: <xmr:XAGiacAbX7E_JxfqKzxDBaNOhqT1cF0yLw1Cv2qUWscyPf5V73fpdUfPPrHz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgv
 rdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtg
 hpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XAGiaboNg0K77qJFWlBgaWg3arfenDDNSlfFmzdPmxQjmhmX74_JEA>
 <xmx:XAGiaelNlgehVlb0GPBEJlkT24_50yDwag9i7482_f4q9KYr3jMuwg>
 <xmx:XAGiaTzKA3zcIlG6Pumlv3ET6C68dItfj8XboHYdczIAEL5SARHqrg>
 <xmx:XAGiae9EEKRWdaEJo3Ta-dNcUzTqEXe62T6HtaeCeNlg5rSVufrSoQ>
 <xmx:XAGiabKQrrwANvP4kXXfza7kftrPpB7Rrcml-EELFsaVTz8l4jVj0mP5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bf826384;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 10/18] ati-vga: Use local variables for register values in
 ati_2d_blt
Date: Fri, 27 Feb 2026 15:39:36 -0500
Message-ID: <20260227203944.746471-11-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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


