Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03990EB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e2-0006SP-1f; Mon, 02 Mar 2026 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006L7-LN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:12 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7di-0006YI-5s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:08 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id A4057EC0619;
 Mon,  2 Mar 2026 13:05:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 13:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474705; x=
 1772561105; bh=IPi+ecxc4wgwVeHP8E50CkKINE93WugdLnJ2LSTd5ew=; b=R
 C5+N2KZjabUE4ju1S/ASIXxOPfBBMJOxO+ZLl04bL8i/nvVSFTCZZGi0gLYhHFtz
 UobmyvLm9aditRpA8rYh+djQW7gef++xSBfGBSlUL4VUliPsy/RKLpatHyWRKLcV
 UDyn6QyNh1fR5WeRH1zMfBug3JLGbOWR2Q6iPWPRWFn9CUFj0d6m15wXEU3RkoRr
 ZMu6WcUQ6s73z80BdU3Inbk1XDN2WQtw+oJ9vcwcXTwvMn8Y3l2Lcg1REqfOIEMw
 FK/baRzAtw3g/k0/+gEOhDu4tiaZ9J2x98f/d5E9+ECYXVwftoG8h293TyrjQ/J9
 AXQ3AIBAUnpx1ZnJ+I/qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474705; x=1772561105; bh=I
 Pi+ecxc4wgwVeHP8E50CkKINE93WugdLnJ2LSTd5ew=; b=uA1YPqF+8tBcaJkz3
 5NuNg9aS948J+XSqkdvCyhX/9o8QHGn/5Og7pLlehLukJJ3dxPXuO9PFDCyJ9+vO
 lauoYVYenX92aUZKgKMVIcNw+nN3Spvkl+qx9EfCkQDGsDMsHPqL1Mg+qFwbbSco
 1L01j42S7uRA6cUfkvdqChfoDpwmVboHUeNCOq0tXzLpmT9fNWH7jSWolu1Vce6i
 8PLDDZAAhcoR/7uFORNnc1332hRR/pn4K+bhg1ddWO7MbEfiagcyzCl/jCXkM4on
 OEGXo+HNXb5Q8NfUSHdSik7vUNnYuHu4kmytR074GinInrSU3QsXPINVkkEvF9iC
 2heCQ==
X-ME-Sender: <xms:UdGlaWfbAWQKUoJsyT6dyu7SIF1i3mXvVGJXe0dFNVRT0RZvSCkRIw>
 <xme:UdGlaXHbCfD7fGMGT7pmiH59ReDsy5j7B_hpljYdkpG6j0BDP7ZOK298EIIxZQjwt
 cTWGyyZ27UDj_8-k6RLwvJaoFXD_GgIDZmr6LihcIvdrevR-UTh6QQE>
X-ME-Received: <xmr:UdGlaf2HmPw09vRNV0lGmBeI7j-bwmQms7qQSneRJYeMawinJ3mcdXNAGdxJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnh
 gurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghl
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrd
 hhuhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:UdGlafle_N8c84eX4R-UdBBEAxZAs5kllyoEzuEXKYQTwumcwjL2zw>
 <xmx:UdGlaf_iaczNcsrzqYQYd4JZv21k-P33kwq9dY9xNQ3DYyMeWTZFOA>
 <xmx:UdGlaUoaF5SkuboqX4Dq3Jcx6jV4TxjhCsT6kExvuFr5K6waKHP0xA>
 <xmx:UdGlaYn15Y1wYQHCphIosaZZlc-o2JUcoburt30ocMMmP4T3bmrXbA>
 <xmx:UdGlaRi_FfMOpDKfEqk-22toaH4sd2jZ8Fx_jiJhs1hJQjOcwXRuAq-T>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:05 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bcc37ccb;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 12/17] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
Date: Mon,  2 Mar 2026 13:04:42 -0500
Message-ID: <20260302180447.1078098-13-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
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

setup_2d_blt_ctx is responsible for knowing how to retrieve the state
needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
This will be useful in a future patch when HOST_DATA needs to make small
modifications to the ctx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 73 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index d43268ba5f..f1536e5425 100644
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
@@ -80,76 +80,79 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
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


