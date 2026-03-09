Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EBEF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcz3-00045i-M5; Mon, 09 Mar 2026 11:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyQ-0003PJ-Ax
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyO-0000nC-CM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439b611274bso5422011f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071806; x=1773676606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tTti1wy5ozk2OtX7KUAlckip7ivw9FflaAIgql8dEYQ=;
 b=nfDyATixxcaMLjwl9e3XWIKtpTITKVPejpR/A8V6WdQWRB2wZOAG64K9ZpTEJR3Zc6
 LuKIXTvvMWPnVd+/hfyA3SxSR7FghaZe9P8NqQhGoX0K79Q2K8Wavw6eWo8rATR1Ff9p
 fqejs4jIdX4XvCbeTiXF9q172YYXrXa1G1mf+qL5uOlPbtOem08AHiXKaXaIZWVQwQEt
 T1nsar4+tQkCjiYVXPTC9M9VK2yF9Q6/oMxijmFJ8Hyi4L2DCD0bVA+ykT+wCbx72TkU
 nbAYNw0ZiEfgelWm43pXe+ZdeWTcePPl/fxoXyd+8MBw1U1ZhUe0tHRNdWBKEjzzU3wH
 TBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071806; x=1773676606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tTti1wy5ozk2OtX7KUAlckip7ivw9FflaAIgql8dEYQ=;
 b=KVBxNvi2qtGdhAK9ORmpYrPCEAk9poe1/IRCEvd59sTZXTGjgO1xs2K1r1rJC92kLf
 H3Zp67sgXNYt9KOdlpkAq3BcKiLuROJSc7UQg4AvP45CHW0xVOTbJcol5v7jP5Ooh2W7
 newFDQKFAcWcPnFt0upIcen/vZpYicrbkkfIanhiXS2Q/zQXnEoif85UIxMePwZXIz9O
 fekEFY3peCXGhdjab/eimJyleJDZdTv+LenrBQtDDDYVrmLwv6P4rhI8zIKBYX6SS+T2
 +12OT2UB66SU1Uwg7gmFCmFX12J5jwWz9VUgPmutEtncfqDG4qMckKHdXtiXHBmJ+sMC
 XhDg==
X-Gm-Message-State: AOJu0YwbiXaauZTwFa6Zm+NG9AQcRMMeXujnTDjLl/b6sXX3KCBw3BWb
 dlzVpFDdH9g0fMlrpQa4mWz71gQugY3pMEd3O6PxZkhCzlssynMiyBjEqY775XOAkPlVm3Kvp2k
 zoEapPIg=
X-Gm-Gg: ATEYQzyeFTC6zhnEv1vuAmhKNztoXWMUTW9A1TQH3sMzNurtGp+piWBLCNSjFxrniOn
 rYQz08C839uudFmPHlrP49vb1doBYU33fR7HECOyjf2P26xWeaJ7rb1SnStw+umqwIs5mvafStX
 Yi6sOHyVueZ1L1p9hraCIXsDojwpAQFF89RNOcL4ijXn0Lc08O5IGtZyFbNoTUUhlkBfwnbQ0v8
 i/279R0jVidrLCQ74w8dhWZ721qQkjeVTEA6/QKFY/sHte61XWvSEGhUZMQeYIrSBEjYrwC012M
 3Nk98soT0/53J6QSNfgVAgWEyjZ/Mt+krqvyzKobcBjxO51sgVlIo42N7l2V8g29s6yYfDSuqKq
 TmXCE05o0itY323zw8WzTXzgxoDWsZjs//BHpSXi3jqHpsxIQ5ksxz3MLUJQnIDJIuNRgJ2npiw
 Bs3elxqGsFjz0uAjsHx99XquZj6cX1F3MkJEyI377VjKbY9XS5W2LC4vZiaHQHdLTtfc5qpg/V7
 XsiC/RQLZI=
X-Received: by 2002:a05:6000:2013:b0:439:ac98:7520 with SMTP id
 ffacd0b85a97d-439da885b37mr19209632f8f.37.1773071805442; 
 Mon, 09 Mar 2026 08:56:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d95dsm29929682f8f.7.2026.03.09.08.56.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/49] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
Date: Mon,  9 Mar 2026 16:52:09 +0100
Message-ID: <20260309155219.62400-40-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chad Jablonski <chad@jablonski.xyz>

setup_2d_blt_ctx is responsible for knowing how to retrieve the state
needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
This will be useful in a future patch when HOST_DATA needs to make small
modifications to the ctx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <6e2dccba65d9b369e0db633c0149a77351827222.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 75 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 1ae2fbc5f89..ef4d2e21b5e 100644
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
@@ -80,73 +80,76 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
     }
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
-    /* FIXME it is probably more complex than this and may need to be */
-    /* rewritten but for now as a start just to get some output: */
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
-    if (!ctx->bpp) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
-    }
     ctx->dst_stride = s->regs.dst_pitch;
-    if (!ctx->dst_stride) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
-    }
-    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
-
+    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
         ctx->dst_stride *= ctx->bpp;
     }
-    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
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
+    ATI2DCtx ctx_;
+    ATI2DCtx *ctx = &ctx_;
+    setup_2d_blt_ctx(s, ctx);
+    if (!ctx->bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
+        return;
+    }
+    if (!ctx->dst_stride) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
+        return;
+    }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
         ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
         (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
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
         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff ||
             ctx->src_bits >= ctx->vram_end ||
             ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height) *
-- 
2.53.0


