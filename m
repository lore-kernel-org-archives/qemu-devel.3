Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E667BE6BF13
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppQ-0004kB-NY; Fri, 30 Jan 2026 09:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppN-0004hv-72
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppK-00037x-5j
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:28 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 6A9AF1D00141;
 Fri, 30 Jan 2026 09:50:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 30 Jan 2026 09:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784625; x=
 1769871025; bh=aEAVs8nhWZjUQGIGcxn8VMbeYHw0sDTZNSguZo7+NUY=; b=J
 dQ4Y12EPiQbop73WVUUSLkr6j43Db/Le20nwir63eVeM7Pm8sytpwm9/JXsNDBbJ
 ljSIpcL6/9QudbVqf4Rl/5h0IeuII/gxS7YPOlAIQjFhyQHlRLEmCPwJJe81V7WS
 DwZuaQv8PS0izm82lns5ezIxaKzrSTtXdNr5/BtwHsaElKPhrCBVBKJs/XTanMBr
 PecixTQZF6Cbk3ZKm1mig4Gubxl5SRc+5/GP7qIF3gDuQk7czt/088F4TgF+/SP1
 7LPovjnBwFIw3I3a/z62E2kDPwzBhTE0h2dI8Ze9+NKXBRqHqNsqbeEqay39T9g7
 3IH/d/AzxWDrTiY5ZWsuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784625; x=1769871025; bh=a
 EAVs8nhWZjUQGIGcxn8VMbeYHw0sDTZNSguZo7+NUY=; b=t7BQydrRLxsduMMPu
 O+bD0dyUDlp6iaQwzKM7U4kt8ddEVCFkHBdlL4zRbky9i6qhGkcyX5QI5hg+iOv/
 BRBhbJnjW1ya/iwGsmIRxy8wSaL7e/YhbYGxZ01yMnkYpH2NbnETY38XB6a1FzUo
 MTW4sWW36T+wMjwliMyTjSMZ7kUIdwhycklIfZRK6QmfqHRYhyR/Bsj7OMaNy6Hw
 PA5eYorFIpD4nbGW/YlTH6l+K14NhJ8IZPMQ2WEr/8Fkb99v62peql8nR5kQjjYK
 8c1Z4BqkdTBfMt7wveAz182OryTTSopW/PuSVSMBCc7guX+iCJc7qjds6SCarEhN
 Y/gxg==
X-ME-Sender: <xms:McV8aZlCKegfn_JMA9kVceOsVBuR7mTRb38GO3WAkpu6Z3wQngy5bw>
 <xme:McV8acTIRLDgGpUYcuTY0-xIpcfrQQUyx0jgwJH1ONzLtpyUGusIIt5h2GoMicB7y
 8OJsKon_Bdf3VLm4ZXttAdNzxpQ74hrGQlfdKWOLS5Pxv2xIt5XInY>
X-ME-Received: <xmr:McV8adCb1xqX5c5-qgK_bSiCVlsz_KYsWujwwlf2JTmvdM2OpBNgBlfdWfcD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:McV8aTS7VBD3Urd-qAR0I8A2TRWRco19i4TnWAu_AA3W6ofq5vtTzQ>
 <xmx:McV8abrolSoGQVAZvv4rEjmvTn6hzQOVRsNkh1gNwSofgA71HN-ysQ>
 <xmx:McV8aVy09LLmJdYRvN60viJCoGKYFC9LeA-R7-X0b-RpqjLyT5FkvQ>
 <xmx:McV8aQJ93oZEiURKdqtca456htTFpCpHCA6E_vuwmjBY8VGgwbIZ5Q>
 <xmx:McV8aV-UkcdDS8osCixrG7f2p_i_6bTbGXuaanWByTA0nLWNNElnHywY>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 973266c4;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 12/20] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
Date: Fri, 30 Jan 2026 09:49:57 -0500
Message-ID: <20260130145005.731129-13-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
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

setup_2d_blt_ctx is responsible for knowing how to retrieve the state
needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
This will be useful in a future patch when HOST_DATA needs to make small
modifications to the ctx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index bc41ad37f6..4c55898e9a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -25,7 +25,7 @@
  * possible.
  */
 
-static int ati_bpp_from_datatype(ATIVGAState *s)
+static int ati_bpp_from_datatype(const ATIVGAState *s)
 {
     switch (s->regs.dp_datatype & 0xf) {
     case 2:
@@ -64,6 +64,43 @@ typedef struct {
     const uint8_t *src_bits;
 } ATI2DCtx;
 
+static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
+{
+    ctx->bpp = ati_bpp_from_datatype(s);
+    ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
+    ctx->palette = s->vga.palette;
+    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
+
+    /* dst */
+    ctx->dst.width = s->regs.dst_width;
+    ctx->dst.height = s->regs.dst_height;
+    ctx->dst.x = (ctx->left_to_right ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
+    ctx->dst.y = (ctx->top_to_bottom ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
+    ctx->dst_stride = s->regs.dst_pitch;
+    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx->dst_stride *= ctx->bpp;
+    }
+
+    /* src */
+    ctx->src.x = (ctx->left_to_right ?
+                 s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
+    ctx->src.y = (ctx->top_to_bottom ?
+                 s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
+    ctx->src_stride = s->regs.src_pitch;
+    ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx->src_stride *= ctx->bpp;
+    }
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -72,40 +109,21 @@ void ati_2d_blt(ATIVGAState *s)
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
     ATI2DCtx ctx;
-    ctx.rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
-    ctx.left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
-    ctx.top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
-    ctx.frgd_clr = s->regs.dp_brush_frgd_clr;
-    ctx.palette = s->vga.palette;
+    setup_2d_blt_ctx(s, &ctx);
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             ctx.rop3 >> 16);
     unsigned dst_offset = s->regs.dst_offset;
-    ctx.dst.width = s->regs.dst_width;
-    ctx.dst.height = s->regs.dst_height;
-    ctx.dst.x = (ctx.left_to_right ?
-                s->regs.dst_x : s->regs.dst_x + 1 - ctx.dst.width);
-    ctx.dst.y = (ctx.top_to_bottom ?
-                s->regs.dst_y : s->regs.dst_y + 1 - ctx.dst.height);
-    ctx.bpp = ati_bpp_from_datatype(s);
     if (!ctx.bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    ctx.dst_stride = s->regs.dst_pitch;
     if (!ctx.dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    ctx.dst_bits = s->vga.vram_ptr + dst_offset;
-
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx.dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        ctx.dst_stride *= ctx.bpp;
-    }
     int dst_stride_words = ctx.dst_stride / sizeof(uint32_t);
-    ctx.vram_end = s->vga.vram_ptr + s->vga.vram_size;
     if (ctx.dst.x > 0x3fff || ctx.dst.y > 0x3fff || ctx.dst_bits >= ctx.vram_end
         || ctx.dst_bits + ctx.dst.x
          + (ctx.dst.y + ctx.dst.height) * ctx.dst_stride >= ctx.vram_end) {
@@ -123,21 +141,10 @@ void ati_2d_blt(ATIVGAState *s)
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        ctx.src.x = (ctx.left_to_right ?
-                    s->regs.src_x : s->regs.src_x + 1 - ctx.dst.width);
-        ctx.src.y = (ctx.top_to_bottom ?
-                    s->regs.src_y : s->regs.src_y + 1 - ctx.dst.height);
-        ctx.src_stride = s->regs.src_pitch;
         if (!ctx.src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        ctx.src_bits = s->vga.vram_ptr + s->regs.src_offset;
-
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            ctx.src_bits += s->regs.crtc_offset & 0x07ffffff;
-            ctx.src_stride *= ctx.bpp;
-        }
         int src_stride_words = ctx.src_stride / sizeof(uint32_t);
         if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
             || ctx.src_bits >= ctx.vram_end
-- 
2.52.0


