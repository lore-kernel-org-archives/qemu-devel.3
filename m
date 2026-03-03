Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5772EB3658
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFne-0008AB-2Y; Mon, 02 Mar 2026 21:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnS-0007og-JR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:42 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnQ-0002qY-3X
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:42 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9CDA21400167;
 Mon,  2 Mar 2026 21:47:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 21:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506059; x=
 1772592459; bh=lCg0ydTcvECcQMK7tczPRmb81G6yDxSx9iHuTCxaTpc=; b=e
 ggUxRcQVtxrAxIQAYzHt/JHWF50rcZDeBK550AFcBh6U6cM1lcKI0+OWGKQUSwux
 rjhXGr/uSTaWVWVV9ERvepdzM+5YoXqYWjYXanXRGl/xRABqZI9Kgh6T6pvQfei2
 MNtK5VO0bkwxZSbkZXk3ogMAjuSBkM/GgBEGpyY6tDCFO+6mnXMeTahDWh8dUmGx
 rNpGeoMbdqHa3Hz64QhLYuSwhbEt4qRtrlqFSHeO82ymS7lVbsWPU4SGC/Eqf7YZ
 6SNF3qhh6x0kqSKEqdLQcUqcnIBgpUH0nI3SA6A0NR3WElXuKNsBeNJbhKgJfqGI
 HydwoU5aF1NEvBAZOWDmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506059; x=1772592459; bh=l
 Cg0ydTcvECcQMK7tczPRmb81G6yDxSx9iHuTCxaTpc=; b=J6aCIIfdZ9wqFLjdd
 IZa/WcstRYyHOibQ/0M8yW+VgRbcGdAvnKkX0QooanyWmDq0s3oZ8AS3TCpl9dHB
 iPyyO/o6tWQi+0/0vmgWOltXSsxs/Lrqe3F5vQG+ArWMKsqojVeU6kmxyXchkqGm
 v2K7yo641lvC3pAckGf2Gu6OPAkJ6DQr+4d+NDVEYazUWaI/fy76XL5dY4LjQwV2
 Xe35Kfp97OxAPfSbDAzlz4DF+QimdQ9iPlHH3tVHexRrq+oGBmHaAFMsVdmNByoQ
 uySYG6FMKYLqXrrqeRX8sSLIpWJoMjE9nHgqwsXWrH3XhmLzFiG53EASmoOF94Ps
 Nk1uw==
X-ME-Sender: <xms:y0umaZ1IJr-pmDqycOoQddjF88mU9WuEIVama-bWCuMISi7CJSaaFA>
 <xme:y0umaW_fcvp_DPxy0VZ5qKmb4AQ3Xz3blllutecvH64mtYaBcmjXbqwEVMDTjHMBs
 EVQtZbQzOS8pYkgnU9ZlCZWOm5w9X35pj-KAgKv4wNvwLHtI6THJgOZ>
X-ME-Received: <xmr:y0umaSNvDbeCDZ5bC3l4Os6dY4As6h_OtOA5UlCvHzinszEgz7Op063ZvfjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoh
 epmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:y0umaSfudlZhrmKH-QOLPx5vnMwZLZ3GjATf9AofZ0UGpOLPAy8jxw>
 <xmx:y0umaZUtpD2t1A8ZZfKBwpMmPP4_SQfJaCY5jGPftlry6XmpGrDlhg>
 <xmx:y0umaSigM__evbb_S9E3AOsh3YxyNKXf1EhZ89pQrUNhqaBMrDKHrA>
 <xmx:y0umaQ9p-LUS20-wHCZjkQs1msxazQj8TrnrWs5ZPRoONdxVHXOlsw>
 <xmx:y0umaXZ_VaJaMrgEuEuyyH6sApanB1JPHqX8MQq5pFTxgxKsGLCIDtZE>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:39 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id be0d1b1a;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 09/17] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
Date: Mon,  2 Mar 2026 21:47:22 -0500
Message-ID: <20260303024730.1489136-10-chad@jablonski.xyz>
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

Pixman requires stride in words. So over the course of the ati_2d_blt
function both src and dst stride were mutated before being passed to
pixman and then back afterwards.

This creates local variables holding src and dst stride in words
avoiding the potentially confusing mutation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 980cdd6ac0..e366774835 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -85,6 +85,7 @@ void ati_2d_blt(ATIVGAState *s)
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
         dst_stride *= bpp;
     }
+    int dst_stride_words = dst_stride / sizeof(uint32_t);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
         || dst_bits + dst_x
@@ -118,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
             src_bits += s->regs.crtc_offset & 0x07ffffff;
             src_stride *= bpp;
         }
+        int src_stride_words = src_stride / sizeof(uint32_t);
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
              + (src_y + s->regs.dst_height) * src_stride >= end) {
@@ -125,34 +127,32 @@ void ati_2d_blt(ATIVGAState *s)
             return;
         }
 
-        src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
+                src_bits, dst_bits, src_stride_words, dst_stride_words,
+                bpp, bpp, src_x, src_y, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
+                                   src_stride_words, dst_stride_words, bpp, bpp,
                                    src_x, src_y, dst_x, dst_y,
                                    s->regs.dst_width, s->regs.dst_height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
             int llb = s->regs.dst_width * (bpp / 8);
-            int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
-            uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
+            int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
                                      s->regs.dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride_words, tmp_stride_words, bpp, bpp,
                                    src_x, src_y, 0, 0,
                                    s->regs.dst_width, s->regs.dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
+                                       tmp_stride_words, dst_stride_words,
+                                       bpp, bpp, 0, 0, dst_x, dst_y,
                                        s->regs.dst_width, s->regs.dst_height);
             }
             g_free(tmp);
@@ -163,18 +163,15 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = bpp / 8;
-            unsigned int src_pitch = src_stride * sizeof(uint32_t);
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-
             for (y = 0; y < s->regs.dst_height; y++) {
                 i = dst_x * bypp;
                 j = src_x * bypp;
                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (dst_y + y) * dst_pitch;
-                    j += (src_y + y) * src_pitch;
+                    i += (dst_y + y) * dst_stride;
+                    j += (src_y + y) * src_stride;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_stride;
+                    j += (src_y + s->regs.dst_height - 1 - y) * src_stride;
                 }
                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
             }
@@ -201,21 +198,19 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
+                dst_bits, dst_stride_words, bpp, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst_bits, dst_stride_words, bpp, dst_x,
+                         dst_y, s->regs.dst_width, s->regs.dst_height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
             for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_pitch;
+                i = dst_x * bypp + (dst_y + y) * dst_stride;
                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
-- 
2.52.0


