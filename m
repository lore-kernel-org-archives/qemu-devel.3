Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161FBC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBB-0007jV-On; Sun, 19 Jul 2026 12:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB9-0007iK-N6
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB7-0002P5-4u
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7B6F47A0082;
 Sun, 19 Jul 2026 12:15:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 19 Jul 2026 12:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477742; x=
 1784564142; bh=s0CQSii4/ZJ3c1go+L4vlGB9APv9y1mACEzske6WaXM=; b=W
 UYxT6TYtQVyBS8MPphA5pKumCAvp/mZxn6aG8849lxtoJAe04h8v2iHEx6J2sFNn
 2lFd/AAC1FXyDGCogpoZyzXZXBB/raVwepvOc1DjiFr3ioGTLUcMfoO1DNzxAl09
 TIANiKeE3BY0bhgoza0V/Cal3TrgKuovlKn1U67UHY9WTKe4Z6O4GxmvBfd/yiiU
 NdhudeBp3FeJC0w2PxFNprkCbQRDOaT2Y+OVy0gOx6V1rHujKGcefRWUBUUY3gmi
 g6YTzDoJJktC/0oyuxYtzhyvX2RJY6FINAq1LpZEgFQqtC5zOXoXvBYdLtXRmABz
 /Fxm61V/W7nLfdNJkpjfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477742; x=1784564142; bh=s
 0CQSii4/ZJ3c1go+L4vlGB9APv9y1mACEzske6WaXM=; b=rBW+kzNS8Mv6jG0c+
 VPeSaBdUz0jVmQfoA6qV6534d9uzlQZdZRwNG9CFZYlFXKrbYsTKIzYXSz3Ay7ME
 /3qvh7Wi5QNukOWQ4joIsrtkHr6Gz1s+XDrPYr+sqcphE+sWBRNZcsdlGcltF3Dm
 Lc+U7O5L3Xf81ecqBHzSP+FTzgFkE52ntCR0XulXT1iF7Z50KR744PWJHh8/JrJM
 yJNZbPzlh8kahP/8QMzuKgod4RtSGQ3fZrWIkXHIPhcO+0OZg8lwWm5nIV79Rd+i
 VE+aMKBwMV9jxPdLzYbtr4zpGlqYAvjsFHa7v7xiAfwEZxOSnBeXJTjdkx95knuZ
 UZXjw==
X-ME-Sender: <xms:LvhcaqDyP2pElEphSDpJ8nyBBibDfJl0imOtrdQUnE1VJCpwGGbT_g>
 <xme:Lvhcar8FiM6SZ23AwfIAcJvDZWU7fWJrMeTPnReyEL81jkgPqxa6CiMg0CDdAxDs6
 JMq9K63rhdNqlO5MYRYYMOe0gdDBk-0xVJBtbSyDtyaVG8ti6-kEAA>
X-ME-Received: <xmr:Lvhcaq8Upkfx6RGvTl45oxw_La5vvUiQgxKsgcXvzQm5xBCHePpuZdRh9aA>
X-ME-Proxy-Cause: dmFkZTF2M8/td2x4uX0quVUht6oTuzlOtlV8s/xAIpba0AK3yD3yx/edKpxJCFjEj6RVFW
 tZylprZe+5ZeJQcZMYpgGdlyYr4p2Wtx0Pp9uwz7oCUjsZcueHidxeZqaoOMQW+WpAqS8o
 36DmnFTRazz4ZZYy3JE1PDUxJVJ6kQybtpH5PX9NmR/So+sfpFNwXUOFOf+enlYoThGfBq
 /4lv/qCY4C+TNW42jFI8nDAtYiw5rFjgpjUCC0EAiSX1/r68t1adlaGfPCZ9kDzHhyIsa/
 zjm0Fxwf9RtbwH8g1DU4zTrN01nzO9FlVCZHr0GOq/w+LWaLMT81m5uJTc0ahE79g4sRFE
 BTfIKNwQSBft9PUx0apEjvZsXu5DC53y1535Qdl19YivuZz9U8XSnXfBvrsHRh9SaMI36c
 WwxkkG7EptUkXOu4CJ2Me0POKSJj5D/RZZoWGB1Zp/m4U0If03/F24WWtjONYUBmm1EOzy
 gP++rMRRXb4+nl79gphVqo3xDn37VfiLKqzn6YfmDSs0uTSuJU5LMB0K5zrDYTQnRugByF
 Zh1KiUJo6A6GGc92XlpONWvw0K1gaVolyDlTP4x+JSnIA5OS8vwTv7UaaspmyNPeXSLgel
 MIcPY4aDzxzHZWKWC9+YRfzGTrfANEy/dq4Xqhtehz37RYxNUbJ1UsNWRMuA
X-ME-Proxy: <xmx:LvhcaieManTAUSO5Y00tGxiCyAgMqXNrXqRXH5MpT3EexvMNdRO5ug>
 <xmx:LvhcajEynruEuU4u3LgTBFMSMlJog-VrXnGQFCU4UYWKUm7ZjkLvlA>
 <xmx:LvhcagfmMNG-aqLcEWZ2xlLOhB6LJ8HOQPvugXW_nXXDEyyVN8LTQA>
 <xmx:LvhcatFEw46ogisXuynUPmZ1G3eLeH9oyyh25ZvL09c7J0R0svATew>
 <xmx:LvhcagLvRqGQ2bjlGMnyahUvKhsERv9GrufV3nkUdYv_Xx7GKRO-ieDB>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:41 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cdbe9dce;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 2/9] ati-vga: r100 does not latch defaults on
 DP_GUI_MASTER_CNTL
Date: Sun, 19 Jul 2026 12:15:29 -0400
Message-ID: <20260719161536.774061-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
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

The r128 latches the default values of src/dst clipping, pitch, and
offset when the default flags are set on DP_GUI_MASTER_CNTL. The r100
does not do this and instead uses the default values at blit time without
updating the registers.

Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
Radeon QY (RV100) (PCI 1002:5159).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c    | 36 +++++++++++++++++++-----------------
 hw/display/ati_2d.c | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index db7e08a462..76070d76a7 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -895,23 +895,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
 
-        if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
-            s->regs.src_offset = s->regs.default_offset;
-            s->regs.src_pitch = s->regs.default_pitch;
-        }
-        if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
-            s->regs.dst_offset = s->regs.default_offset;
-            s->regs.dst_pitch = s->regs.default_pitch;
-        }
-        if (!(data & GMC_SRC_CLIPPING)) {
-            s->regs.src_sc_right = s->regs.default_sc_right;
-            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
-        }
-        if (!(data & GMC_DST_CLIPPING)) {
-            s->regs.sc_top = 0;
-            s->regs.sc_left = 0;
-            s->regs.sc_right = s->regs.default_sc_right;
-            s->regs.sc_bottom = s->regs.default_sc_bottom;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
+                s->regs.src_offset = s->regs.default_offset;
+                s->regs.src_pitch = s->regs.default_pitch;
+            }
+            if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
+                s->regs.dst_offset = s->regs.default_offset;
+                s->regs.dst_pitch = s->regs.default_pitch;
+            }
+            if (!(data & GMC_SRC_CLIPPING)) {
+                s->regs.src_sc_right = s->regs.default_sc_right;
+                s->regs.src_sc_bottom = s->regs.default_sc_bottom;
+            }
+            if (!(data & GMC_DST_CLIPPING)) {
+                s->regs.sc_top = 0;
+                s->regs.sc_left = 0;
+                s->regs.sc_right = s->regs.default_sc_right;
+                s->regs.sc_bottom = s->regs.default_sc_bottom;
+            }
         }
         break;
     case DST_WIDTH_X:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 3b27917bf4..f51ecb747a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -104,18 +104,26 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
-    ctx->dst_offset = s->regs.dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         /* r128 scissor values are inclusive */
         ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
         ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+        ctx->scissor.x = s->regs.sc_left;
+        ctx->scissor.y = s->regs.sc_top;
     } else {
-        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
-        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;
+        if (s->regs.dp_gui_master_cntl & GMC_DST_CLIPPING) {
+            ctx->scissor.x = s->regs.sc_left;
+            ctx->scissor.y = s->regs.sc_top;
+            ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
+            ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;
+        } else {
+            ctx->scissor.x = 0;
+            ctx->scissor.y = 0;
+            ctx->scissor.width = s->regs.default_sc_right;
+            ctx->scissor.height = s->regs.default_sc_bottom;
+        }
     }
-    ctx->scissor.x = s->regs.sc_left;
-    ctx->scissor.y = s->regs.sc_top;
 
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
@@ -123,20 +131,30 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
                  s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
     ctx->dst.y = (ctx->top_to_bottom ?
                  s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
-    ctx->dst_stride = s->regs.dst_pitch;
-    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->dst_stride *= ctx->bpp;
+        ctx->dst_stride = s->regs.dst_pitch * ctx->bpp;
+        ctx->dst_offset = s->regs.dst_offset;
+    } else {
+        ctx->dst_stride = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
+                          ? s->regs.dst_pitch : s->regs.default_pitch;
+        ctx->dst_offset = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
+                          ? s->regs.dst_offset : s->regs.default_offset;
     }
+    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
 
     ctx->src.x = (ctx->left_to_right ?
                  s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
     ctx->src.y = (ctx->top_to_bottom ?
                  s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
-    ctx->src_stride = s->regs.src_pitch;
-    ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->src_stride *= ctx->bpp;
+        ctx->src_stride = s->regs.src_pitch * ctx->bpp;
+        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
+    } else {
+        ctx->src_stride = s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
+                          ? s->regs.src_pitch : s->regs.default_pitch;
+        ctx->src_bits = s->vga.vram_ptr +
+                        (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
+                        ? s->regs.src_offset : s->regs.default_offset);
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
@@ -181,6 +199,7 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
     qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
     if (!vis_dst.height || !vis_dst.width) {
         /* Nothing is visible, completely clipped */
+        DPRINTF("entire blt clipped, nothing drawn\n");
         return false;
     }
     /*
-- 
2.54.0


