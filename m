Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089A10398B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e6-00025l-Pj; Fri, 27 Feb 2026 15:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e2-0001Vq-2i
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007QJ-7g
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 1AFA8EC0642;
 Fri, 27 Feb 2026 15:41:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 27 Feb 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224861; x=
 1772311261; bh=XKA7BDVAEuSkI7Cyv+HPSD9abD9gVHJAjeSHHpT4T3E=; b=V
 9/xn5cExtFqmIzwe71UGAc+7Cvb+NH9tEMKcJhBgrqARsjumwtQJFyFi+IaamsgN
 RKpE20k9uLq7Y3L+kibhtUYvCqyfqqAe9Fb3plckcFwKzSDIDf0+wr5Wh5sHP+9V
 WGk75+4FuHiUlfT+dq2Gvuet0XogWmqYJilHoNp0XBImn7HGI5/ifi5NAMs8eDrv
 yTH+1N6SOtcXs/FFgC2D2cEwiQGI+/MwtcHddNW1l8JG2pTeAenRWQ870O7APi/a
 Z6MFr8YFBrK7UPBO/pZnGZB8YPGfMDgLMD+Co+DKYpyE6w3K6OMSu591ROhe6mKH
 NppzZmx+j1+4wfKLtwIyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224861; x=1772311261; bh=X
 KA7BDVAEuSkI7Cyv+HPSD9abD9gVHJAjeSHHpT4T3E=; b=RgEkePhmkpJcw7xwB
 H/wjJkjP0VgVEfrfte2JbsmT/OAHUiR5oHVWIxQp3qfa2cxaPYJakavYmkB7T+pe
 Uv7mbZ8wt4etjlFNhw9wO0lNlBrzSmt8LmmJTnjD86qwhgfn7p7S6jOY2AKl7BNU
 DwPfN4Dg2NJcQG8RHQBC071bMICh3//4utNt6h4JEhtmlLGvKyawf1j+jXitAl75
 GkXJBN8W/FfbraVYCgLR8v9z/L754a0Tvf73UnpvUbPNNzBYi6xU0HPE0m/SXE+Y
 cyXK3xCL7LGb9GbFOlvzUvapIaeSi5u9g3+o5hp8gPh75/DaeUE3c8MD7tfKViHK
 Ocuwg==
X-ME-Sender: <xms:XQGiaWtfNMcd62x2Uw4QpQPE4-_E4C5aISBunQk2JJDROCtVtUrYFw>
 <xme:XQGiaSWp17psZuSNVxbtk0rmv3q4w_fdMWxXYlf3D7HtyMmdW3zkJXsTujmwGKF3v
 ku0bT6al1gmdOkU5LrYsNv0tTfG5esX5uHFTklL5PL796GOC5cogdk>
X-ME-Received: <xmr:XQGiaaHV-Pa5EgZIZXmRT9TCVzk9Qr90njSxq7Sl9DrQdrGy7BIc6YqxP0g->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvg
 drhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XQGiac3F7st4WWADDzcBbzqTAYFmrJ8sYoTLADt7iZTvcJH8C6vs0g>
 <xmx:XQGiaUMjcq7UADKqOaPAqoWs2WYbugu7FdShpicsVNkL_sYYj1YuFA>
 <xmx:XQGiaT6PB3JbRuErjQdF99QvfZzIhql_UBlb0eD_kbEkm4U0lrqdJQ>
 <xmx:XQGiaW35Sn_K_xzZ_F3o5mf1kYaMP2KDm8yqgCQIGeAAOQ8m9HWdpQ>
 <xmx:XQGiaQxjVRcrAO-rW1tdHsqHaWVoX59GGLejJfiuTkeRcyWsqD0fS_YV>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 811b5076;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 12/18] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
Date: Fri, 27 Feb 2026 15:39:38 -0500
Message-ID: <20260227203944.746471-13-chad@jablonski.xyz>
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

setup_2d_blt_ctx is responsible for knowing how to retrieve the state
needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
This will be useful in a future patch when HOST_DATA needs to make small
modifications to the ctx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 75 ++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index d43268ba5f..ebcec07334 100644
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


