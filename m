Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D429E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1R-00078e-T9; Wed, 04 Feb 2026 11:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1D-00071n-VA
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng19-0004Xd-D4
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:19 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 51B141D0013D;
 Wed,  4 Feb 2026 11:46:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223574; x=
 1770309974; bh=8E8EO5MFzU7EGJqwB1/3+1ke6zNnVRVKaQSUNKQX0jQ=; b=K
 GH7ugJQcwY9J8nIENFJ5iwybn44HY7e3IvFEA9w2Q+RAb42iN3cTPMjRGupbVSDK
 OmgWxGKir41vouPjpgdEbxvt0crvdqz94HBuVMAEg5aUrXLdzE47RQHltKd6BaKA
 dOE2lCQ4T9DfY2plaQP/08u+KEAYfaz8TMJEVy0MYDYxvQe5de+6gqHQC96BQxdt
 1t+qJxqZGk8QM/e8OMcUVlhYw0E26VrTOdQIc8ZLt2hvj4qz9H1+rp2W/vLuNoeu
 hw7nFYEgXJ8KGkpfLyhuL14n5XsdciCXWPYHI83W3NCbbVj0cwtC8OQ2lri3Kj6d
 dOHtqxBi0/AsxapYsqQ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223574; x=1770309974; bh=8
 E8EO5MFzU7EGJqwB1/3+1ke6zNnVRVKaQSUNKQX0jQ=; b=seNyV5rUPdO0CXAsf
 SZEEamWohTxbGEvXL8zBglDkLGA38klAYIMhbd9vRvobriNx4S3+qb8LDrZez58X
 98BjZ8y6ft96Qx9ZDUM3D0UMTMr8niW/zbBUB7nFFKXEP99hnFiW4KrfXNMstnBb
 8cY7/i9Xm4d0LMcnyln70nHUxtlcV75lDI/CmK4dmbOIC5coYnch8PldjiMWfKGR
 +Tk4646NCVz/0f16WN8SOpR2sQg8hI1M/wrwUaMvJH30LxD2vHdlAM1vqb7GS95S
 fI7nXW6B+Y+Z24hHIfwrWhLiYO2fzSjIoBEPud4C11vKo/0eAtLntueQtx84G1sj
 SRCYg==
X-ME-Sender: <xms:1neDaXch5d13bFTR2k-y7UY_YJUJjsSqlkVsBwMItR6iqmQkj2YRwg>
 <xme:1neDaUohJhQzzLe7DQRxStTJhgKlpuf1Bs9GamjG2aOvcI2TsqESTeBBQ8s7-nCQ7
 P3WRtIdINttSThx5_lZLYDE8IJ1wMYn6SyEW0rTzXrSL7bVHSlPIQ>
X-ME-Received: <xmr:1neDad6w2uZfKCidqi7fRIfCAbVPQYqEfjVPQ1MrJXyIzVsVMqE2sxreAQzX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:1neDaSpGdz_00yO3zvwjcHxrZygyjD18wS36VUje06yoCAPki28dqw>
 <xmx:1neDaXgX7LMpsPMAHTBiXKTmufabMGMTUsZEPSNmH9ftarvaZezXGA>
 <xmx:1neDaUJPzXX0Frd4RonGdhyQotrhij1Jzb7t8AtMIoCUvDdjzTQtXw>
 <xmx:1neDafAUS1grzJRG5j-0BJAGqoxecer_dE6hLDZSMF7zv_r0pyLzPA>
 <xmx:1neDabX77MKqu3rjkKe3igGKz0tuuDV2o10c74uLrjbmHvoJuFDYjuld>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 31db66e4;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 12/18] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
Date: Wed,  4 Feb 2026 11:46:00 -0500
Message-ID: <20260204164606.3425246-13-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 75 ++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 4154202677..cf80296a25 100644
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
@@ -80,76 +80,81 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
     }
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
-    /* FIXME it is probably more complex than this and may need to be */
-    /* rewritten but for now as a start just to get some output: */
-    bool use_pixman_fill = s->use_pixman & BIT(0);
-    bool use_pixman_blt = s->use_pixman & BIT(1);
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
+    ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
     ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
+    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
+
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
     ctx->dst.x = (ctx->left_to_right ?
                  s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
     ctx->dst.y = (ctx->top_to_bottom ?
                  s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
-    ctx->bpp = ati_bpp_from_datatype(s);
+    ctx->dst_stride = s->regs.dst_pitch;
+    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx->dst_stride *= ctx->bpp;
+    }
+
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
+    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
+            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
+            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
+            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
+            ctx->dst.width, ctx->dst.height,
+            (ctx->left_to_right ? '>' : '<'),
+            (ctx->top_to_bottom ? 'v' : '^'));
+}
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    /* FIXME it is probably more complex than this and may need to be */
+    /* rewritten but for now as a start just to get some output: */
+    bool use_pixman_fill = s->use_pixman & BIT(0);
+    bool use_pixman_blt = s->use_pixman & BIT(1);
+    ATI2DCtx ctx_;
+    ATI2DCtx *ctx = &ctx_;
+    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    ctx->dst_stride = s->regs.dst_pitch;
     if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
-
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        ctx->dst_stride *= ctx->bpp;
-    }
     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
-    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
         || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
          + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
-    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, ctx->dst_offset, s->regs.default_offset,
-            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
-            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
-            ctx->dst.width, ctx->dst.height,
-            (ctx->left_to_right ? '>' : '<'),
-            (ctx->top_to_bottom ? 'v' : '^'));
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        ctx->src.x = (ctx->left_to_right ?
-                     s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
-        ctx->src.y = (ctx->top_to_bottom ?
-                     s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
-        ctx->src_stride = s->regs.src_pitch;
         if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
-
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
-            ctx->src_stride *= ctx->bpp;
-        }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
             || ctx->src_bits >= ctx->vram_end
-- 
2.52.0


