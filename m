Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9519410398B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e5-0001pR-0e; Fri, 27 Feb 2026 15:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e1-0001TG-IH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dy-0007Q7-7H
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:04 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8993514001F0;
 Fri, 27 Feb 2026 15:41:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 15:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224860; x=
 1772311260; bh=lCg0ydTcvECcQMK7tczPRmb81G6yDxSx9iHuTCxaTpc=; b=M
 0mgbY1k/EVWUWXYAXVOXoQ1XuTkMoaKNRJZ9CAjq7znhfLhnZnFK0Jelzqf8nQii
 7baclHwpKIP4I1fU4mcJ/W6XcaiENbG5QkO4aGwqjWoa+YXeXhQpNpH7USig6P1Q
 aFzKyoYiqwECRcySYi3R5/dhhvOj1ItBSgzMTEcPlMRXLK6YC7hM+2U5ll55oWRn
 GZGR0rZCLuEsHfevmU5YHXVQw1ZxA0MYRxQp+ZUncG1aWiONMYgAoGuGPnv2RXuk
 9orVwExs0mHwZ1XZOie8LXnYg3rmmT+xpOKv6irbdmKF1MTX43bqzsQD9pAsAgxi
 K46MFA6zXpo9RkjnN+8EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224860; x=1772311260; bh=l
 Cg0ydTcvECcQMK7tczPRmb81G6yDxSx9iHuTCxaTpc=; b=OeLgFTiOr4QnftgqY
 IEYg4wuT8ieRnC3K9LooU9J64OzaqW0Ezvv8aJOQEpCKa2pANq4Tk7Q5FN6xazvc
 49xnc8xNDRr10mgxQ9T2Ly8Nme6++ZnH7+bhtUdeZ9tP4PuRy63fEfylUogLMUBo
 kXnfghZzgP9TVJNPK/TpdIUslqiGqub8cSu3F/WPY0O+0B/opoN1V0vYUmNyErgv
 Kx11HH5hcfbt9nwBrPhftOR7JpSK2uBU0lr7zyPv6hK23nf3mJ1YhOfa0kKmibQW
 k+fst2EpqSz73ZuYDrjnfp7FpZVRcw8Qy6S8BdUBw+wBli7qtl6ltYyrB/Y+gm9Z
 pq3xw==
X-ME-Sender: <xms:XAGiadrUNiz1aaiBqKNDaqvXAWwpf4S1xyqfMbKxCOygSWZZMIjHMA>
 <xme:XAGiaWhjuXahX9FqZLHctROAwNNi2GjCFg1ceXeewhYs4WuCA620sno2qjkYvIH9L
 482YWW6hx597OiGKm8oz56LGr0eA7BlrTStBTtnQz8as5d81xKciww>
X-ME-Received: <xmr:XAGiaShWMZP_3bMDkNcEQMDM5dRcalvfdfrAuLAn0kUKopxeF6irbHogR-B5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhird
 ighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XAGiaUjJ6qF-K7nArQCIZp_WfdjZyQChv28lI9P6fgMz27tl-nXKnw>
 <xmx:XAGiaaIgRBWkjWWdAgIFBp3PBVHUTSmlmuJoi5buL0_RwLyF4LssTw>
 <xmx:XAGiabHKp9jWfaf327VCAujzEJ9-dObMbGBUlBIMxmnBZ62gOwGl8A>
 <xmx:XAGiaWSb8a4rzUYbLFaL-LvWPLnj7E33Jmx580i_Jdva_r9hm4TOcQ>
 <xmx:XAGiab92qdK7AARVJyBjeM1B18cMrn2tZ4_-4FfzW2ld9JOSNNHS9Qb5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4b8c2ff7;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 09/18] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
Date: Fri, 27 Feb 2026 15:39:35 -0500
Message-ID: <20260227203944.746471-10-chad@jablonski.xyz>
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


