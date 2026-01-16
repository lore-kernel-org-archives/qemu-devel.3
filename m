Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64CED4A5EB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoO-0005wp-Lp; Thu, 15 Jan 2026 21:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0005qX-OH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:23 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnw-0002RZ-9M
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:18 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E086F1D00089;
 Thu, 15 Jan 2026 21:43:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531392; x=
 1768617792; bh=vPQDpUt6s4t6qzdjQu1QltXUX8nqG/MKbC89zGDfm7E=; b=u
 cf3TEYubiHAWAH+Qx5iVeU2Z4RRRZQNGeMcQTVpA3UKaD0r7U8fA5XHt+clTQN/e
 lV5vV3P5IqCzXFBrJserzp6TP3lGZFSRpJH85hRX0Jum/V9N6F7Ow0a2EwnB9fuN
 hvh9MpCGb6RQ3/7oVvOhM9GcZkmMuVxlrzSPRe8YvkiWqa37WdKKEw2dxnPbzVMz
 hv5Ml8JvKlSCuDk1xpDx435DH9k7/jc/VUZouh/UsAf8YlIoYKIX9VVSpvxFiGLf
 Y9x6HZvwkSI4qI1qy1gEgEFfllVS0ORhhGhcPaLTx7Dfyj1XVqsVjUoZO4X3Qmok
 7meIRVR/vDPBYs4lVH8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531392; x=1768617792; bh=v
 PQDpUt6s4t6qzdjQu1QltXUX8nqG/MKbC89zGDfm7E=; b=gsyPRDfU60z4My+lR
 IszmPSJjo+M2CtY8um5MRFCzJdPts9LBzwmw5X53C1Jg3JrSmVi6exEC8JItMo9o
 OYLwjrzctFaI5yF89vDxPG9Y+m5l7yNedo7oultZrlov6rMVgfn3zALPh1lvpOpm
 E0PmHHaUtNM/R4Q0Dx3GGdtq7c5LMIJ/GNz5J2MZq5DisYQCw2PhzUnqnrUfyxUb
 0NIk0PIVCfiwMc/EIFFmNSs4MVTmxE7n//pKbKCdQt93bCZoVKWC4gKSGFcaJUsW
 mNYvN2iVjN53DiT+m1mmY9mp2IJ29S2sWLulHcyzS9DKN5hvbxInK57RvKNjuDzd
 vh44g==
X-ME-Sender: <xms:wKVpad5i0AE7rz851V3wuZr6lXb3YWH26vZ5FJKTHcnduEaEQ4HghA>
 <xme:wKVpaSWEB1kuOwTpXYUpzbfcff3WEVjy14IAt0e0ix2pCA_6J0uCermiTAIEaW_y3
 DKFTazith6ucysnIGS1exJkNPxkohTqB_H242h-auB-Cvm8BYflkN8>
X-ME-Received: <xmr:wKVpaR2KhsW0_MKlLud_UaJHrVjEB1maNnRuPb0j8whBLbmw5QxvSzDIX7u_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wKVpaf1f5Vurl5kvY_tdkBaQJCcPbkFRzqayWklIaOuI3J9Pf3r02A>
 <xmx:wKVpaU-ohIJHriOhI59Se55VXT7Ge4rLg3GKhlMUfHz1VMP0wm-m2g>
 <xmx:wKVpac0kGHdQs4V4vRQa1Ly1Rrdg5_OIVrdbQ2F6jqM-k6a6SGBSjw>
 <xmx:wKVpaR_jJodIx9T786li_P26dWfk4G_xDsrUiImy6YHPeC8VF8nnkQ>
 <xmx:wKVpaTg9r2T9g8ngSz4R9uoy2EnXr2_MwKhcY25wMJtVL5vYG2CO9yi2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ff1c2f02;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 07/12] ati-vga: Create and use ATIBltSrc struct
Date: Thu, 15 Jan 2026 21:42:53 -0500
Message-ID: <20260116024258.1487173-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This creates a struct to hold all src state relevant to a blit.
A future patch implements the actual blit as a function accepting a src
and dst. This will be important for implementation of HOST_DATA which
sources data from a buffer and not VRAM.

The majority of the changes in this patch involve mechanically changing
src data references to use this new struct. There should be no change in
behavior.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 77 ++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 75bd38e9b0..91fd3b7827 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -25,6 +25,13 @@
  * possible.
  */
 
+typedef struct {
+    int x;
+    int y;
+    int stride;
+    uint8_t *bits;
+} ATIBltSrc;
+
 typedef struct {
     QemuRect rect;
     int bpp;
@@ -79,9 +86,11 @@ void ati_2d_blt(ATIVGAState *s)
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    int dst_stride_words;
+    int dst_stride_words, src_stride_words;
     ATIBltDst _dst; /* TEMP: avoid churn in future patches */
     ATIBltDst *dst = &_dst;
+    ATIBltSrc _src; /* TEMP: avoid churn in future patches */
+    ATIBltSrc *src = &_src;
 
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
@@ -90,6 +99,19 @@ void ati_2d_blt(ATIVGAState *s)
 
     setup_2d_blt_dst(s, dst);
 
+    src->x = (dst->left_to_right ?
+             s->regs.src_x :
+             s->regs.src_x + 1 - dst->rect.width);
+    src->y = (dst->top_to_bottom ?
+             s->regs.src_y :
+             s->regs.src_y + 1 - dst->rect.height);
+    src->stride = s->regs.src_pitch;
+    src->bits = s->vga.vram_ptr + s->regs.src_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        src->bits += s->regs.crtc_offset & 0x07ffffff;
+        src->stride *= dst->bpp;
+    }
+
     if (!dst->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -106,11 +128,12 @@ void ati_2d_blt(ATIVGAState *s)
     }
 
     dst_stride_words = dst->stride / sizeof(uint32_t);
+    src_stride_words = src->stride / sizeof(uint32_t);
 
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, dst->stride, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst->rect.x, dst->rect.y,
+            src->stride, dst->stride, s->regs.default_pitch,
+            src->x, src->y, dst->rect.x, dst->rect.y,
             dst->rect.width, dst->rect.height,
             (dst->left_to_right ? '>' : '<'),
             (dst->top_to_bottom ? 'v' : '^'));
@@ -119,42 +142,31 @@ void ati_2d_blt(ATIVGAState *s)
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (dst->left_to_right ?
-                       s->regs.src_x : s->regs.src_x + 1 - dst->rect.width);
-        unsigned src_y = (dst->top_to_bottom ?
-                       s->regs.src_y : s->regs.src_y + 1 - dst->rect.height);
-        int src_stride = s->regs.src_pitch;
-        if (!src_stride) {
+
+        if (!src->stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
-
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= dst->bpp;
-        }
-        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
-            || src_bits + src_x
-             + (src_y + dst->rect.height) * src_stride >= end) {
+        if (src->x > 0x3fff || src->y > 0x3fff || src->bits >= end
+            || src->bits + src->x
+             + (src->y + dst->rect.height) * src->stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
-        src_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst->bits,
-                src_stride, dst_stride_words,
+                src->bits, dst->bits,
+                src_stride_words, dst_stride_words,
                 dst->bpp, dst->bpp,
-                src_x, src_y, dst->rect.x, dst->rect.y,
+                src->x, src->y, dst->rect.x, dst->rect.y,
                 dst->rect.width, dst->rect.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
             dst->left_to_right && dst->top_to_bottom) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst->bits,
-                                   src_stride, dst_stride_words,
+            fallback = !pixman_blt((uint32_t *)src->bits, (uint32_t *)dst->bits,
+                                   src_stride_words, dst_stride_words,
                                    dst->bpp, dst->bpp,
-                                   src_x, src_y, dst->rect.x, dst->rect.y,
+                                   src->x, src->y, dst->rect.x, dst->rect.y,
                                    dst->rect.width, dst->rect.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
@@ -162,10 +174,10 @@ void ati_2d_blt(ATIVGAState *s)
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
                                      dst->rect.height);
-            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride,
+            fallback = !pixman_blt((uint32_t *)src->bits, tmp,
+                                   src_stride_words, tmp_stride,
                                    dst->bpp, dst->bpp,
-                                   src_x, src_y, 0, 0,
+                                   src->x, src->y, 0, 0,
                                    dst->rect.width, dst->rect.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst->bits,
@@ -182,18 +194,17 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = dst->bpp / 8;
-            unsigned int src_pitch = src_stride * sizeof(uint32_t);
             for (y = 0; y < dst->rect.height; y++) {
                 i = dst->rect.x * bypp;
-                j = src_x * bypp;
+                j = src->x * bypp;
                 if (dst->top_to_bottom) {
                     i += (dst->rect.y + y) * dst->stride;
-                    j += (src_y + y) * src_pitch;
+                    j += (src->y + y) * src->stride;
                 } else {
                     i += (dst->rect.y + dst->rect.height - 1 - y) * dst->stride;
-                    j += (src_y + dst->rect.height - 1 - y) * src_pitch;
+                    j += (src->y + dst->rect.height - 1 - y) * src->stride;
                 }
-                memmove(&dst->bits[i], &src_bits[j], dst->rect.width * bypp);
+                memmove(&dst->bits[i], &src->bits[j], dst->rect.width * bypp);
             }
         }
         if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-- 
2.51.2


