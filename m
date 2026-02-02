Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E7E7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qu-0000QB-N9; Mon, 02 Feb 2026 15:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q5-0007Kx-Gf
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:07 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q2-0001p0-7U
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:04 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 0C92F1D00115;
 Mon,  2 Feb 2026 15:47:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 02 Feb 2026 15:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065278; x=
 1770151678; bh=6bj5sIeQrzcgA+I7zOwDmSSTxJBOe/eU0fzJwdHATxE=; b=T
 4gDb5+ykaSedoBGSK76T+e01GmHx4JhBbZ/b2PaJOoyMhAt+Kon9a1s0qeANdnoA
 SQdoqIPNx01ObwC0sJDc4DdTkOokJqS9FRxSEDASBux1ehOzRh1locZQ0I1MOXYu
 LtIPMaisCrz4YJmgKlG9bjIQx3vOGp9bqMUV6jxaiWQ3ozpVBbEY4xVuDIbyAQFs
 ie7hdGaDgDCX1ybOM7bL6A95B3emoyNk5lrAGgNiBUiQ43mUeTW00xegMKB7l8A8
 P93iZFMeUwqlmfD3gNGlPULmeuOdXgU78rUpfk4+U5O8EONXRwgZwBlLemWnmzQq
 TLLRwdWzDgf4dGCedERDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065278; x=1770151678; bh=6
 bj5sIeQrzcgA+I7zOwDmSSTxJBOe/eU0fzJwdHATxE=; b=XusZxB24FFUVHEpIL
 iHNbR92uxYHKgLqYTpCROOVpLi+q/QHMGMa7A2s/VuLuSOk6K5ks4d7H1P2aCWtY
 nNqqiQIIdUC71CZRt5BIfLs6Bc2yILTXJ/LmPG6dZYssbyWYivNmpcghWudQB81m
 L0suXNijRZ3RIh459JJDN9ApgzA1Prn9Njjbbch20CZstHV77NsIDprLLQCt6sc3
 IRdcGY7VroEBVbyQo812mt42OrSKxpD4Qw1AzRcTkEFs6TgdUtbBe2zNwCsh/LBv
 f8xqHfytwoJC4TOU7DOzFx+0Sk44ahZyGKOawl7mkyteI8rgZjJrbJbjlhj+c6Jl
 22CTQ==
X-ME-Sender: <xms:fg2BaUZRoazea9VEUiFRzzVWkmQM63OmdsosENIkNGimbz07q2KvRw>
 <xme:fg2BaW12DsLJsA11n44XQPmcCvG6r2d335k3adb_R2V33lCIMKknj2WAyYFRb7bi_
 g7vykp-GYrinkjWEvgwwCyr7ttoSiYNv5TqRDxQNEbuoBfSQf6T1S0>
X-ME-Received: <xmr:fg2BacViiIXubRgx6EQgfQtkZzpXmXNIJNLmYdVTZ6OSXqMeunuGwzGlAKRb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 gthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:fg2BaYWPNTB4dkORXpKT_Gf8MipLz-U_ZV6qm7-GdDFPRQEWFbAKxg>
 <xmx:fg2BaTcVvbSi5eykfpZDNdsCUOwSrxLuf4i-HL4rbtriI-nSNxm_VA>
 <xmx:fg2BaZXz1iC2CWwlNUnw2ZfaN7tULH8QT8to3UHqrYIAOSOLUzlIWw>
 <xmx:fg2BaUeejEufjIOu5dLSIEtTVNbmZiUCBAVSRId6w2i8Q7NE4-CqcQ>
 <xmx:fg2BaUCBPgpqmRa4NkK1cJAW1jGyA9cp6kbnED-cUbWZq2yJheVqpDJ2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3bf59918;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 09/19] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
Date: Mon,  2 Feb 2026 15:47:27 -0500
Message-ID: <20260202204738.3080092-10-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
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

Pixman requires stride in words. So over the course of the ati_2d_blt
function both src and dst stride were mutated before being passed to
pixman and then back afterwards.

This creates local variables holding src and dst stride in words
avoiding the potentially confusing mutation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 5d24d11d7a..f6c65ef3cc 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -86,6 +86,7 @@ void ati_2d_blt(ATIVGAState *s)
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
         dst_stride *= bpp;
     }
+    int dst_stride_words = dst_stride / sizeof(uint32_t);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
         || dst_bits + dst_x
@@ -119,6 +120,7 @@ void ati_2d_blt(ATIVGAState *s)
             src_bits += s->regs.crtc_offset & 0x07ffffff;
             src_stride *= bpp;
         }
+        int src_stride_words = src_stride / sizeof(uint32_t);
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
              + (src_y + s->regs.dst_height) * src_stride >= end) {
@@ -126,18 +128,18 @@ void ati_2d_blt(ATIVGAState *s)
             return;
         }
 
-        src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
+                src_bits, dst_bits,
+                src_stride_words, dst_stride_words,
+                bpp, bpp, src_x, src_y, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
+                                   src_stride_words, dst_stride_words,
+                                   bpp, bpp,
                                    src_x, src_y, dst_x, dst_y,
                                    s->regs.dst_width, s->regs.dst_height);
         } else if (s->use_pixman & BIT(1)) {
@@ -147,12 +149,14 @@ void ati_2d_blt(ATIVGAState *s)
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
                                      s->regs.dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride_words, tmp_stride,
+                                   bpp, bpp,
                                    src_x, src_y, 0, 0,
                                    s->regs.dst_width, s->regs.dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
+                                       tmp_stride, dst_stride_words,
+                                       bpp, bpp,
                                        0, 0, dst_x, dst_y,
                                        s->regs.dst_width, s->regs.dst_height);
             }
@@ -164,18 +168,17 @@ void ati_2d_blt(ATIVGAState *s)
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
+                    i += (dst_y + s->regs.dst_height - 1 - y)
+                         * dst_stride;
+                    j += (src_y + s->regs.dst_height - 1 - y)
+                         * src_stride;
                 }
                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
             }
@@ -202,21 +205,21 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
+                dst_bits, dst_stride_words, bpp,
+                dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst_bits, dst_stride_words,
+                         bpp, dst_x, dst_y,
+                         s->regs.dst_width, s->regs.dst_height, filler))
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


